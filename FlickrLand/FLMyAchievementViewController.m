//
//  FLMyAchievementViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMyAchievementViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLAchievementCell.h"


@interface FLMyAchievementViewController ()

@end

@implementation FLMyAchievementViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    [FLAppTheme menuButtonForViewController:self];
    
    _beginnerDataArray = @[
                           @{@"icon":@"achive-firstPlace", @"title":@"First Land",@"discrip":@"It's so good to have own land."},
                           @{@"icon":@"achieve-firstPhoto", @"title":@"First Upload",@"discrip":@"Taking the first step is not that hard, right?"},
                           @{@"icon":@"achieve-apologize1", @"title":@"Visit Landlord",@"discrip":@"That is your oath."},
                           @{@"icon":@"achive-threeStar", @"title":@"Favorite Lover",@"discrip":@"Keep collecting more photos"}];
    
    _cityDataArray = @[
                           @{@"icon":@"achieve-101", @"title":@"New Taipei",@"discrip":@"Your First Land"},
                           @{@"icon":@"achieve-airport", @"title":@"Taoyuan",@"discrip":@"Your Second Land"},
                           @{@"icon":@"achieve-windＭill", @"title":@"Hsinchu",@"discrip":@"Your Third Land"},
                           @{@"icon":@"achieve-bud", @"title":@"Nantou",@"discrip":@"Your Fourth Land"},
                           @{@"icon":@"achieve-lightHouse", @"title":@"Pingtung",@"discrip":@"Your Fifth Land"},
                           
                           @{@"icon":@"icon_blank", @"title":@"Kaohsiung",@"discrip":@"Try to claim it"},
                           @{@"icon":@"icon_blank", @"title":@"Hualien",@"discrip":@"Try to claim it"},
                           @{@"icon":@"icon_blank", @"title":@"Yunlin",@"discrip":@"Try to claim it"},
                           @{@"icon":@"icon_blank", @"title":@"Chiayi",@"discrip":@"Try to claim it"}];
    
    _cultureDataArray = @[
                           @{@"icon":@"achieve-Yahoo", @"title":@"Hack Yahoo!",@"discrip":@"I want Macbook air"},
                           @{@"icon":@"culture-gugu", @"title":@"Ku Ku Follower",@"discrip":@"We don't sleep at night"},
                           @{@"icon":@"icon_blank", @"title":@"Brave Man",@"discrip":@"Discover every place"},
                           @{@"icon":@"icon_blank", @"title":@"Athena",@"discrip":@"Knowledge Lover"}];
    
    _contentArray = _beginnerDataArray;
    [_contentTableView setDataSource:self];
    [_contentTableView setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 74;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    [headView setBackgroundColor:[UIColor clearColor]];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *verticleLine = [[UIView alloc] initWithFrame:CGRectMake(37 +20, 14, 1, 400)];
    [verticleLine setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75f]];
    
    UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(33 +20, 0, 9, 9)];
    [dotView setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [dotView.layer setCornerRadius:4.5f];
    [dotView.layer setMasksToBounds:YES];
    
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 +20, -3, 100, 14)];
    [endLabel setText:@"End"];
    [endLabel setTextColor:[UIColor whiteColor]];
    [endLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0 +20, 0, 320, 20)];
    [footView setBackgroundColor:[UIColor clearColor]];
    [footView addSubview:verticleLine];
    [footView addSubview:dotView];
    [footView addSubview:endLabel];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    FLAchievementCell *cell = (FLAchievementCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[FLAchievementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.iconImageView setImage:[UIImage imageNamed:_contentArray[indexPath.row][@"icon"]]];
    [cell.titleLabel setText:_contentArray[indexPath.row][@"title"]];
    [cell.discriptionLabel setText:_contentArray[indexPath.row][@"discrip"]];
    return cell;
}


#pragma mark - UIEvents
- (IBAction)beginnerButton_touchUpInside:(UIButton *)sender {
    
    [_beginnerbutton setSelected:YES];
    [_citybutton setSelected:NO];
    [_culturebutton setSelected:NO];
    
    _contentArray = _beginnerDataArray;
    [_contentTableView reloadData];
}
- (IBAction)citybutton_touchUpInside:(UIButton *)sender {
    
    [_beginnerbutton setSelected:NO];
    [_citybutton setSelected:YES];
    [_culturebutton setSelected:NO];
    
    _contentArray = _cityDataArray;
    [_contentTableView reloadData];
}
- (IBAction)culturebutton_touchUpInside:(UIButton *)sender {
    
    
    [_beginnerbutton setSelected:NO];
    [_citybutton setSelected:NO];
    [_culturebutton setSelected:YES];
    
    _contentArray = _cultureDataArray;
    [_contentTableView reloadData];
}

@end
