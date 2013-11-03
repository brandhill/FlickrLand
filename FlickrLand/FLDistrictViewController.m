//
//  FLDistrictViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLDistrictViewController.h"
#import "FLPhotoViewerViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLPhotoCell.h"

@interface FLDistrictViewController ()

@end

@implementation FLDistrictViewController

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
    
    
    _photoDataArray = [[FLDataSource sharedDataSource] getPhotosInDistrict:_districtData];
    int starNum = 0;
    for (FLPhotoData *photoData in _photoDataArray) {
        starNum += [photoData.favoriteNum intValue];
    }
    
    
    //Profile
    [_profileBorderView setImage:[UIImage imageWithSize:CGSizeMake(54, 54) Color:[UIColor colorWithWhite:1 alpha:0.75f] radius:27]];
    
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 50, 50)];
    [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    [_profileImageView.layer setCornerRadius:25.0f];
    [_profileImageView.layer setMasksToBounds:YES];
    [_profileBorderView addSubview:_profileImageView];
    
    _barSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 0.5f)];
    [_barSeparator setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75f]];
    [_barSeparator setHidden:YES];
    [self.view addSubview:_barSeparator];
    
    FLUserData *user = [[FLDataSource sharedDataSource] getHolderInDistrict:_districtData];
    if (user.facebookName) [_nameLabel setText:user.facebookName];
    else [_nameLabel setText:user.flickrName];
    
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", user.facebookID];
    NSURL *profileUrl = [NSURL URLWithString:urlString];
    [_profileImageView setImageWithURL:profileUrl];
    
    
    //Status
    _statusContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 62 -266, 320, 28)];
    [_statusContainerView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.25f]];
    [_contentTableView addSubview:_statusContainerView];
    
    _photoIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_imageIcon"]];
    [_photoIcon setFrameOrigin:CGPointMake(15, 6)];
    [_statusContainerView addSubview:_photoIcon];
    
    _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 6, 140, 16)];
    [_photoNumLabel setText:[NSString stringWithFormat:@"%i Photo in Taipei", [_photoDataArray count]]];
    [_photoNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [_photoNumLabel setFont:[UIFont systemFontOfSize:14]];
    [_statusContainerView addSubview:_photoNumLabel];
    
    _starIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_starIcon"]];
    [_starIcon setFrameOrigin:CGPointMake(195, 6)];
    [_statusContainerView addSubview:_starIcon];
    
    _starNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(223, 6, 100, 16)];
    [_starNumLabel setText:[NSString stringWithFormat:@"%i Star", starNum]];
    [_starNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [_starNumLabel setFont:[UIFont systemFontOfSize:14]];
    [_statusContainerView addSubview:_starNumLabel];
    
    
    //Map View
    _mapView = [[FLMapView alloc] initWithFrame:CGRectMake(0, 91 -266, 320, 173)];
    [_contentTableView addSubview:_mapView];
    
    
    //Table View
    [_contentTableView setDelegate:self];
    [_contentTableView setDataSource:self];
    
    UIView *colorFillView = [[UIView alloc] initWithFrame:CGRectMake(0, -266 -300, 320, 361)];
    [colorFillView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15f]];
    [_contentTableView addSubview:colorFillView];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    double offsetY = -scrollView.contentOffset.y -266 +95;
    offsetY = offsetY < 33 ? 33 : offsetY;
    offsetY = offsetY > 95 ? 95 : offsetY;
    [_nameLabel setFrameOrigin:CGPointMake(_nameLabel.frame.origin.x, offsetY)];
    
    offsetY = -scrollView.contentOffset.y -266 +30;
    offsetY = offsetY > 30 ? 30 : offsetY;
    [_profileBorderView setFrameOrigin:CGPointMake(_profileBorderView.frame.origin.x, offsetY)];
    
    if (scrollView.contentOffset.y > -202) {
        [_barSeparator setHidden:NO];
    }
    else {
        [_barSeparator setHidden:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_photoDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 211;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    FLPhotoCell *cell = (FLPhotoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FLPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    FLPhotoData *photoData = _photoDataArray[indexPath.row];
    [cell setPhotoURL:[NSURL URLWithString:photoData.sourceM]];
    [cell setPhotoID:photoData.photoID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"photo" sender:_photoDataArray[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"photo"]) {
        
        [(FLPhotoViewerViewController *)segue.destinationViewController setPhotoData:sender];
    }
}

@end
