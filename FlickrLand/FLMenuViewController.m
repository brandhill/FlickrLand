//
//  FLMenuViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMenuViewController.h"
#import "FLDataSource.h"
#import "FLAppTheme.h"
#import "FLMenuButtonCell.h"

@interface FLMenuViewController ()

@end

@implementation FLMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.25f]];
    [self.menuTableView setDataSource:self];
    [self.menuTableView setDelegate:self];
    
    
    
    
    //Section Data
    _sectionDataArray = @[
                          @[
                              @{@"title":@"Flickr Land", @"segue":@"FlickrLand"},
                              @{@"title":@"My Land", @"segue":@"MyLand"},
                              @{@"title":@"Place To Go", @"segue":@"PlaceToGo"}
                              ],
                          @[
                              @{@"title":@"Friends Pic", @"segue":@"FriendsPic"},
                              @{@"title":@"Favorite", @"segue":@"Favorite"},
                              @{@"title":@"Achievement", @"segue":@"Achievement"}
                              ],
                          @[
                              @{@"title":@"Settings", @"segue":@"Settings"}
                              ]
                          ];
    
    
    //Setup UI
    _profileViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, -195, 320, 195)];
    [_menuTableView addSubview:_profileViewContainer];
    
    UIImage *borderImage = [UIImage imageWithSize:CGSizeMake(84, 84) Color:[UIColor colorWithWhite:1 alpha:0.75f] radius:42.0f];
    _profileContainer = [[UIImageView alloc] initWithImage:borderImage];
    [_profileContainer setCenter:CGPointMake(130, 90)];
    [_profileViewContainer addSubview:_profileContainer];
    
    _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    [_profileImageView setCenter:CGPointMake(42, 42)];
    [_profileImageView setClipsToBounds:YES];
    [_profileImageView.layer setCornerRadius:40.0f];
    [_profileContainer addSubview:_profileImageView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 134, 260, 40)];
    [_userNameLabel setText:@"UserName"];
    [_userNameLabel setTextColor:[UIColor whiteColor]];
    [_userNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_userNameLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_profileViewContainer addSubview:_userNameLabel];
    
    //MenuTable
    UIView *verticleline = [[UIView alloc] initWithFrame:CGRectMake(69.5, 218 -_menuTableView.contentInset.top, 1, 568*1.5f)];
    [verticleline setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.25f]];
    [_menuTableView addSubview:verticleline];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_menuTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    //Set Data
    if ([[NSUserDefaults standardUserDefaults] valueForKey:FLUserFacebookIDKey]) {
        
        NSString *fbID = [[NSUserDefaults standardUserDefaults] valueForKey:FLUserFacebookIDKey];
        NSString *fbName = [[NSUserDefaults standardUserDefaults] valueForKey:FLUserNameKey];
        
        NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", fbID];
        NSURL *profileUrl = [NSURL URLWithString:urlString];
        [_profileImageView setImageWithURL:profileUrl];
        
        [_userNameLabel setText:fbName];
    }
}


#pragma mark - Table View Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_sectionDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_sectionDataArray[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 -60, 1)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 -60, 36)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *FLCellReuseIdentifier = @"cell";
    FLMenuButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:FLCellReuseIdentifier];
    if (cell == nil) {
        
        cell = [[FLMenuButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FLCellReuseIdentifier];
    }
    [cell.titleLabel setText:_sectionDataArray[indexPath.section][indexPath.row][@"title"]];
    
    return cell;
    
}


#pragma mark Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 36.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:_sectionDataArray[indexPath.section][indexPath.row][@"segue"] sender:nil];
}

#pragma mark - Scroll View Delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y <= -195) {
        [_profileViewContainer setFrameOrigin:CGPointMake(0, scrollView.contentOffset.y)];
    }
}


@end
