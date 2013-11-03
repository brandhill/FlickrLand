//
//  FLFavoriteViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLFavoriteViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FlickrKit.h"
#import "FLBannerCell.h"
#import "FLGalleryCell.h"
#import "FLLeftAlignFlowLayout.h"

static NSString *loginURLScheme = @"flickrLand://auth";
static NSString *cellReuseIdentifier = @"cell";
static NSString *bannerReuseIdentifier = @"banner";

@interface FLFavoriteViewController ()

@end

@implementation FLFavoriteViewController

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
    
    if ([[FlickrKit sharedFlickrKit] isAuthorized] == NO) {
        
        [[FlickrKit sharedFlickrKit] beginAuthWithCallbackURL:[NSURL URLWithString:loginURLScheme] permission:FKPermissionWrite completion:^(NSURL *flickrLoginPageURL, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _authWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
                [_authWebView loadRequest:[NSURLRequest requestWithURL:flickrLoginPageURL]];
                [_authWebView setDelegate:self];
                [self.view addSubview:_authWebView];
            });
        }];
    }
    else {
        [self fetchFavoriteList];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchFavoriteList {
    
    [[FlickrKit sharedFlickrKit] call:@"flickr.favorites.getList" args:nil maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
        
        NSArray *photoArray = response[@"photos"][@"photo"];
        _photoURLArray = [NSMutableArray array];
        for (NSDictionary *data in photoArray) {
            
            NSString *photoURLString = @"http://farm";
            photoURLString = [photoURLString stringByAppendingFormat:@"%i.staticflickr.com/", [data[@"farm"] integerValue]];
            photoURLString = [photoURLString stringByAppendingFormat:@"%@/", data[@"server"]];
            photoURLString = [photoURLString stringByAppendingFormat:@"%@_", data[@"id"]];
            photoURLString = [photoURLString stringByAppendingFormat:@"%@.jpg", data[@"secret"]];
            [_photoURLArray addObject:photoURLString];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_indicatorView stopAnimating];
            
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
        });
    }];
}


#pragma mark - Web View Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = [request.URL absoluteString];
    NSRange schemeRange = [urlString rangeOfString:@"flickrland"];
    if (schemeRange.location != NSNotFound) {
        
        [[FlickrKit sharedFlickrKit] completeAuthWithURL:request.URL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_authWebView removeFromSuperview];
                
                [[NSUserDefaults standardUserDefaults] setValue:userId forKey:FLUserFlickrIDKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self fetchFavoriteList];
            });
        }];
    }
    
    return YES;
    
}



#pragma mark - Collection View Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_photoURLArray count] +1;
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
        [cell.photoNumLabel setText:[NSString stringWithFormat:@"%i Photos", [_photoURLArray count]]];
        return cell;
    }
    
    FLGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    int index = indexPath.item;
    if (index >= 1) {
        index = index -1;
    }
    [cell setPhotoUrl:[NSURL URLWithString:_photoURLArray[index]]];
    
    
    return cell;
}


#pragma mark - Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
