//
//  FLCityViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLCityViewController.h"
#import "FLDistrictViewController.h"
#import "FLPhotoViewerViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLDistrictData.h"
#import "FLDistrictCell.h"

@interface FLCityViewController ()

@end

@implementation FLCityViewController

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
    [FLAppTheme backButtonForViewController:self];
    
    //Profile
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 50, 50)];
    [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    [_profileImageView.layer setCornerRadius:25.0f];
    [_profileImageView.layer setMasksToBounds:YES];
    [_profileBorderView addSubview:_profileImageView];
    
    _barSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 0.5f)];
    [_barSeparator setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75f]];
    [_barSeparator setHidden:YES];
    [self.view addSubview:_barSeparator];
    
    
    //Info View;
    _infoContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 317)];
    [_infoContainerView setBackgroundColor:[UIColor clearColor]];
    [_contentTableView setTableHeaderView:_infoContainerView];
    
    UIView *photoContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 245)];
    [photoContainer setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15f]];
    [_infoContainerView addSubview:photoContainer];
    
    _mayorPhotoView = [[FLHorizontalPhotoView alloc] initWithFrame:CGRectMake(0, 60, 320, 180)];
    [_mayorPhotoView setPhotoDataArray:[[FLDataSource sharedDataSource] getPhotosWithUser:_mayorData inCity:_cityData]];
    [_mayorPhotoView setDelegate:self];
    [photoContainer addSubview:_mayorPhotoView];
    
    
    //Status View
    _statusContainerView = [[UIButton alloc] initWithFrame:CGRectMake(0, 246, 320, 70)];
    [_statusContainerView setBackgroundImage:[UIImage imageWithSize:CGSizeMake(320, 70) Color:[UIColor colorWithWhite:1 alpha:0.25f]] forState:UIControlStateNormal];
    [_statusContainerView setBackgroundImage:[UIImage imageWithSize:CGSizeMake(320, 70) Color:[UIColor colorWithWhite:0 alpha:0.05f]] forState:UIControlStateHighlighted];
    [_statusContainerView setAdjustsImageWhenHighlighted:YES];
    [_statusContainerView addTarget:self action:@selector(statusButton_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_infoContainerView addSubview:_statusContainerView];
    
    _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 16, 16)];
    [_photoIcon setImage:[UIImage imageNamed:@"content_imageIcon"]];
    [_statusContainerView addSubview:_photoIcon];
    
    _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 15, 200, 16)];
    [_photoNumLabel setText:[NSString stringWithFormat:@"Total %i Photo in %@", [_mayorPhotoView.photoDataArray count], _cityData.cityName]];
    [_photoNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [_photoNumLabel setFont:[UIFont systemFontOfSize:14]];
    [_statusContainerView addSubview:_photoNumLabel];
    
    _starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, 16, 16)];
    [_starIcon setImage:[UIImage imageNamed:@"content_starIcon"]];
    [_statusContainerView addSubview:_starIcon];
    
    int starNum = 0;
    for (FLPhotoData *photoData in _mayorPhotoView.photoDataArray) {
        starNum += [photoData.favoriteNum intValue];
    }
    
    _starNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 40, 200, 16)];
    [_starNumLabel setText:[NSString stringWithFormat:@"Earn %i Star", starNum]];
    [_starNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [_starNumLabel setFont:[UIFont systemFontOfSize:14]];
    [_statusContainerView addSubview:_starNumLabel];
    
    _levelImage = [[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 50, 50)];
    [_levelImage setImage:[UIImage imageNamed:@"level_0"]];
    [_statusContainerView addSubview:_levelImage];
    
    
    //TableView
    _districtDataArray = [[FLDataSource sharedDataSource] getInfoDistrictInCity:_cityData];
    [_contentTableView setDelegate:self];
    [_contentTableView setDataSource:self];
    
    UIView *fillView = [[UIView alloc] initWithFrame:CGRectMake(0, -400, 320, 400)];
    [fillView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15f]];
    [_contentTableView addSubview:fillView];
    
    
    //Set Content
    [_cityLabel setText:_cityData.cityName];
    [_mayorNameLabel setText:_mayorData.facebookName];
    
    if (_mayorData) {
        _mayorNameLabel.text = _mayorData.facebookName;
        
        NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=80&height=80", _mayorData.facebookID];
        NSURL *profileUrl = [NSURL URLWithString:urlString];
        [_profileImageView setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



#pragma mark - Photo View Delegate
- (void)photoView:(FLHorizontalPhotoView *)photoView didSelectAtIndex:(int)index {
    
    [self performSegueWithIdentifier:@"photo" sender:photoView.photoDataArray[index]];
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
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 19)];
    [headView setBackgroundColor:[UIColor clearColor]];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *verticleLine = [[UIView alloc] initWithFrame:CGRectMake(37, 14, 1, 400)];
    [verticleLine setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75f]];
    
    UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(33, 0, 9, 9)];
    [dotView setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [dotView.layer setCornerRadius:4.5f];
    [dotView.layer setMasksToBounds:YES];
    
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, -3, 100, 14)];
    [endLabel setText:@"End"];
    [endLabel setTextColor:[UIColor whiteColor]];
    [endLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [footView setBackgroundColor:[UIColor clearColor]];
    [footView addSubview:verticleLine];
    [footView addSubview:dotView];
    [footView addSubview:endLabel];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    FLDistrictCell *cell = (FLDistrictCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FLDistrictCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell setDistrictData:_districtDataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"district" sender:_districtDataArray[indexPath.row]];
}



#pragma mark - UIScroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    double offsetY = -scrollView.contentOffset.y +95;
    offsetY = offsetY < 33 ? 33 : offsetY;
    offsetY = offsetY > 95 ? 95 : offsetY;
    [_mayorNameLabel setFrameOrigin:CGPointMake(_mayorNameLabel.frame.origin.x, offsetY)];
    
    offsetY = -scrollView.contentOffset.y +25;
    offsetY = offsetY > 25 ? 25 : offsetY;
    [_profileBorderView setFrameOrigin:CGPointMake(_profileBorderView.frame.origin.x, offsetY)];
    
    if (scrollView.contentOffset.y <= 60) {
        [_barSeparator setHidden:YES];
    }
    else {
        [_barSeparator setHidden:NO];
    }
}


#pragma mark - UIEvents

- (IBAction)statusButton_touchUpInside:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"achievement" sender:nil];
}


#pragma mark - Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"district"]) {
        
        [(FLDistrictViewController *)segue.destinationViewController setDistrictData:sender];
    }
    else if ([segue.identifier isEqualToString:@"photo"]) {
        
        [(FLPhotoViewerViewController *)segue.destinationViewController setPhotoData:sender];
    }
}


@end
