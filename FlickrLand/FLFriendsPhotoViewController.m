//
//  FLFriendsPhotoViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLFriendsPhotoViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLFriendsPhotoCell.h"
#import "FLGalleryViewController.h"

@interface FLFriendsPhotoViewController ()

@end

@implementation FLFriendsPhotoViewController

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
    
    _friendsDataArray = [[FLDataSource sharedDataSource] getAllFriends];
    
    [_contentTableView setDataSource:self];
    [_contentTableView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication rootViewController] setEnableToMove:YES];
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
    return [_friendsDataArray count];
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
    
    FLFriendsPhotoCell *cell = (FLFriendsPhotoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FLFriendsPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell setUserData:_friendsDataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"gallery" sender:_friendsDataArray[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"gallery"]) {
        
        [(FLGalleryViewController *)segue.destinationViewController setUserData:sender];
    }
    [[UIApplication rootViewController] setEnableToMove:NO];
}

@end
