//
//  FLMyLandViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMyLandViewController.h"
#import "FLCityViewController.h"
#import "FLDistrictViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLCityCardView.h"

static NSString *cellReuseIdentifier = @"cell";

@interface FLMyLandViewController ()

@end

@implementation FLMyLandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setHidden:YES];
    
    [FLAppTheme menuButtonForViewController:self];
    
    
    //TableView
    [_districtTableView setDelegate:self];
    [_districtTableView setDataSource:self];
    
    //Generate district data
    NSArray *holdingDistrictArray = [[FLDataSource sharedDataSource] getHoldingDistrict];
    NSArray *holdingDistrictCityArray = [holdingDistrictArray valueForKey:@"parentCity"];
    NSArray *holdingDistrictCityIDArray = [holdingDistrictCityArray valueForKey:@"cityID"];
    NSSet *holdingDistrictCityIDSet = [NSSet setWithArray:holdingDistrictCityIDArray];
    NSArray *distinctHoldingDistrictCityIDArray = [holdingDistrictCityIDSet allObjects];
    
    //Sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    distinctHoldingDistrictCityIDArray = [distinctHoldingDistrictCityIDArray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSMutableArray *districtArray = [NSMutableArray arrayWithCapacity:[distinctHoldingDistrictCityIDArray count]];
    for (int i =0; i <[distinctHoldingDistrictCityIDArray count]; i++) {
        
        [districtArray addObject:[NSMutableArray array]];
    }
    
    for (FLDistrictData *district in holdingDistrictArray) {
        
        int index = [distinctHoldingDistrictCityIDArray indexOfObject:district.parentCity.cityID];
        [districtArray[index] addObject:district];
    }
    
    _cityDataArray = [[FLDataSource sharedDataSource] getHoldingCity];
    _districtDataArray = districtArray;
    
    
    //Collection View
    [_cityScrollView setDelegate:self];
    [self generateCityContent];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication rootViewController] setEnableToMove:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)generateCityContent {
    
    for (int index =0; index < [_cityDataArray count]; index ++) {
        
        FLCityData *cityData = _cityDataArray[index];
        NSArray *photoArray = [[FLDataSource sharedDataSource] getPhotosInCity:cityData];
        FLPhotoData *photo = photoArray[0];
        
        int starNum = 0;
        for (FLPhotoData *photo in photoArray) {
            starNum += [photo.favoriteNum intValue];
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCityCardOnTap:)];
        
        FLCityCardView *card = [[FLCityCardView alloc] initWithFrame:CGRectMake(7 +index*274, 14, 260, 400)];
        [card addGestureRecognizer:tapGesture];
        [card.photoView setImageWithURL:[NSURL URLWithString:photo.sourceM]];
        [card.cityNameLabel setText:cityData.cityName];
        [card.photoNumLabel setText:[NSString stringWithFormat:@"%i photos", [photoArray count]]];
        [card.starNumLabel setText:[NSString stringWithFormat:@"%i stars", starNum]];
        [card.levelIconView setImage:[[FLDataSource sharedDataSource] bannerForPhotoNum:[photoArray count]]];
        [card setTag:index];
        [_cityScrollView addSubview:card];
    }
    [_cityScrollView setContentSize:CGSizeMake(274 *[_cityDataArray count], 400)];
}
- (void)generateDistrictData {
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_districtDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    [headView setBackgroundColor:[UIColor clearColor]];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    [footView setBackgroundColor:[UIColor clearColor]];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    FLMyDistrictCell *cell = (FLMyDistrictCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FLMyDistrictCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setDelegate:self];
    }
    FLDistrictData *districtData = _districtDataArray[indexPath.row][0];
    [cell.cityNameLabel setText:[districtData parentCity].cityName];
    
    [cell setDistrictDataArray:_districtDataArray[indexPath.row]];
    return cell;
}


#pragma mark - Scroll View Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [_pageControl setCurrentPage:page];
}


#pragma mark - My District Cell Delegate
- (void)districtCell:(FLMyDistrictCell *)cell didSelectedDistrictAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"district" sender:cell.districtDataArray[indexPath.item]];
}


#pragma mark - UIEvents
- (IBAction)cityButton_touchUpInside:(UIButton *)sender {
    
    if (_cityButton.isSelected) return;
    
    [_cityButton setSelected:YES];
    [_districtButton setSelected:NO];
    
    [_cityScrollView setHidden:NO];
    [_pageControl setHidden:NO];
    [_districtTableView setHidden:YES];
    
}
- (IBAction)districtButton_touchUpInside:(UIButton *)sender {
    
    if (_districtButton.isSelected) return;
    
    [_cityButton setSelected:NO];
    [_districtButton setSelected:YES];
    
    [_cityScrollView setHidden:YES];
    [_pageControl setHidden:YES];
    [_districtTableView setHidden:NO];
}
- (void)handleCityCardOnTap:(UITapGestureRecognizer *)sender {
    
    [self performSegueWithIdentifier:@"city" sender:_cityDataArray[sender.view.tag]];
}


#pragma mark - Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"city"]) {
        
        FLUserData *mayor = [[FLDataSource sharedDataSource] getMayorOfCity:sender];
        
        [(FLCityViewController *)segue.destinationViewController setCityData:sender];
        [(FLCityViewController *)segue.destinationViewController setMayorData:mayor];
    }
    else if ([segue.identifier isEqualToString:@"district"]) {
        
        [(FLDistrictViewController *)segue.destinationViewController setDistrictData:sender];
    }
    [[UIApplication rootViewController] setEnableToMove:NO];
}

@end
