//
//  FLGalleryViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLGalleryViewController.h"
#import "FLPhotoViewerViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLLeftAlignFlowLayout.h"
#import "FLGalleryCell.h"
#import "FLBannerCell.h"
#import "UIImageView+AFNetworking.h"

#import "FlickrKit.h"

static NSString *cellReuseIdentifier = @"cell";
static NSString *bannerReuseIdentifier = @"banner";

@interface FLGalleryViewController ()

@end

@implementation FLGalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
//    FlickrKit *auth = [FlickrKit sharedFlickrKit];
//	[auth beginAuthWithCallbackURL:[NSURL URLWithString:@"devedupflickrpro://auth"] onSuccess:^(NSURL *authURL) {
//		//STAssertNotNil(authURL, @"We must have a url returned");
//		dispatch_semaphore_signal(semaphore);
//	} onError:^(NSError *error) {
//		//STFail(@"The auth shouldn't fail");
//		dispatch_semaphore_signal(semaphore);
//	}];
    
//    [[FlickrKit sharedFlickrKit] beginAuthWithCallbackURL:[NSURL URLWithString:@"devedupflickrpro://auth"] permission:FKPermissionWrite completion:^(NSURL *flickrLoginPageURL, NSError *error) {
//        
//        NSLog(@"%@", flickrLoginPageURL);
//    }];
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setHidden:YES];
    
    [FLAppTheme backButtonForViewController:self];
    
    index = 0;
    _photoArray = [[FLDataSource sharedDataSource] getPhotosWithUser:_userData];
    
    
    //Collection View
    FLLeftAlignFlowLayout *landscapeflowLayout = [[FLLeftAlignFlowLayout alloc] init];
    [landscapeflowLayout setMinimumLineSpacing:6];
    [landscapeflowLayout setMinimumInteritemSpacing:6];
    [landscapeflowLayout setSectionInset:UIEdgeInsetsMake(6, 6, 0, 0)];
    [landscapeflowLayout setItemSize:CGSizeMake(240, 160)];
    [landscapeflowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [_contentCollectionView setCollectionViewLayout:landscapeflowLayout];
    [_contentCollectionView setDataSource:self];
    [_contentCollectionView setDelegate:self];
    [_contentCollectionView registerClass:[FLGalleryCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
    [_contentCollectionView registerClass:[FLBannerCell class] forCellWithReuseIdentifier:bannerReuseIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSLog(@"%i", [[NSNumber numberWithBool: [[FlickrKit sharedFlickrKit] isAuthorized]] intValue]);
    
    [[FlickrKit sharedFlickrKit] beginAuthWithCallbackURL:[NSURL URLWithString:@"devedupflickrpro://auth"] permission:FKPermissionWrite completion:^(NSURL *flickrLoginPageURL, NSError *error) {

        NSLog(@"%@", flickrLoginPageURL);
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - Collection View Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_photoArray count];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 1) {
        return CGSizeMake(120, 160);
    }
    else {
        return CGSizeMake(240, 160);
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 1) {
        FLBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerReuseIdentifier forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor colorWithR:95 G:138 B:214 A:0.75f]];
        [cell.titleLabel setText:_userData.facebookName];
        [cell.photoNumLabel setText:[NSString stringWithFormat:@"%i Photos", [_photoArray count]]];
        return cell;
    }
    
    FLGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    [cell setIsAddEnable:YES];
    index ++;
    
    FLPhotoData *photoData = _photoArray[indexPath.row];
    [cell setPhotoUrl:[NSURL URLWithString:photoData.sourceM]];
    [cell setPhotoID:photoData.photoID];
    
    
    return cell;
}


#pragma mark - Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"photo" sender:_photoArray[indexPath.item]];
}


#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"photo"]) {
        
        [(FLPhotoViewerViewController *)segue.destinationViewController setPhotoData:sender];
    }
}


@end
