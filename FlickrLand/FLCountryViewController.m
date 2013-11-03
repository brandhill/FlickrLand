//
//  FLCountryViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLCountryViewController.h"
#import "FLCityViewController.h"
#import "FLDataSource.h"
#import "FLAppTheme.h"

@interface FLCountryViewController ()

@end

@implementation FLCountryViewController

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
    
    _countryGraphView = [[FLTaiwanGraphView alloc] initWithPosition:CGPointMake(80, 165)];
    [_countryGraphView setDelegate:self];
    [self.view addSubview:_countryGraphView];
    
    //Cloud
    UIImageView *cloud;
    _cloudArray = [NSMutableArray array];
    
    cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"country_cloud1"]];
    [cloud setFrameOrigin:CGPointMake(105, 180)];
    [self.view addSubview:cloud];
    [_cloudArray addObject:cloud];
    
    cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"country_cloud1"]];
    [cloud setFrameOrigin:CGPointMake(70, 200)];
    [self.view addSubview:cloud];
    [_cloudArray addObject:cloud];
    
    cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"country_cloud3"]];
    [cloud setFrameOrigin:CGPointMake(250, 460)];
    [self.view addSubview:cloud];
    [_cloudArray addObject:cloud];
    
    cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"country_cloud2"]];
    [cloud setFrameOrigin:CGPointMake(230, 490)];
    [self.view addSubview:cloud];
    [_cloudArray addObject:cloud];
    
    cloudPositionArray = @[@[@105,@180,@135,@180,@6],@[@80,@200,@115,@200,@4],
                           @[@230,@460,@270,@460,@7.5],@[@215,@490,@245,@490,@4]];
    
    
    //Profile
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 50, 50)];
    [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    [_profileImageView.layer setCornerRadius:25.0f];
    [_profileImageView.layer setMasksToBounds:YES];
    [_profileBorderView addSubview:_profileImageView];
    
    
    //Button
    [_cityButton setBackgroundImage:[UIImage imageWithSize:CGSizeMake(320, 80) Color:[UIColor colorWithWhite:0 alpha:0.15f]] forState:UIControlStateHighlighted];
    
    //City Name
    _cityNameButtonArray = [NSMutableArray array];
    _cityNameArray = [[FLDataSource sharedDataSource] getAllCityName];
    //_currentIndex = 0;
    
    double positionY = 0;
    for (NSString *cityName in _cityNameArray) {
        UIButton *nameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, positionY, 76, 30)];
        [nameButton setTitle:cityName forState:UIControlStateNormal];
        [nameButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5f] forState:UIControlStateNormal];
        [nameButton setAdjustsImageWhenHighlighted:YES];
        [nameButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_cityNameScrollView addSubview:nameButton];
        
        [_cityNameButtonArray addObject:nameButton];
        positionY += 30;
    }
    [_cityNameScrollView setContentSize:CGSizeMake(_cityNameScrollView.frame.size.width, positionY + _cityNameScrollView.frame.size.height)];
    [_cityNameScrollView setDelegate:self];
    [_cityNameScrollView setDecelerationRate:0.75];
    [_cityNameScrollView setContentOffset:CGPointMake(0, 21)];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[UIApplication rootViewController] setEnableToMove:YES];
    
    int currentIndex = [self currentViewingIndex];
    
    _mayorDictionary = [[FLDataSource sharedDataSource] getMayors];
    FLUserData *user = _mayorDictionary[[NSString stringWithFormat:@"%i", currentIndex +1]];
    
    if (user) {
        _mayorNameLabel.text = [NSString stringWithFormat:@"Mayor : %@", user.facebookName];
        
        NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=80&height=80", user.facebookID];
        NSURL *profileUrl = [NSURL URLWithString:urlString];
        [_profileImageView setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Taiwan Graph Delegate
- (void)didSelectAtIndex:(int)index {
    
    isTapOnGraphView = YES;
    
    _cityNameLabel.text = _cityNameArray[index];
    if (index != _countryGraphView.selectedIndex) {
        [_countryGraphView setSelectedIndex:index];
        
        FLUserData *user = _mayorDictionary[[NSString stringWithFormat:@"%i", index +1]];
        
        if (user) {
            _mayorNameLabel.text = [NSString stringWithFormat:@"Mayor : %@", user.facebookName];
            
            NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=80&height=80", user.facebookID];
            NSURL *profileUrl = [NSURL URLWithString:urlString];
            [_profileImageView setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
        }
        else {
            
            _mayorNameLabel.text = @"Mayor : nobody";
            [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
        }
    }
    
    [_cityNameScrollView setContentOffset:CGPointMake(0, 30*index +20) animated:YES];
}


#pragma mark - UI Events
- (IBAction)cityButton_touchUpInside:(UIButton *)sender {
    
    
}


#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int index = [self currentViewingIndex];
    
    index = index < 0 ? 0 : index;
    index = index >= [_cityNameArray count] ? [_cityNameArray count] -1 : index;
    
    for (UIButton *button in _cityNameButtonArray) {
        
        double alpha = (scrollView.contentOffset.y -button.frame.origin.y)/30;
        alpha = alpha < 0 ? 0 : alpha;
        alpha = alpha > 1 ? 1 : alpha;
        
        [button setTransform:CGAffineTransformMakeScale((1-alpha), (1-alpha))];
        [button setAlpha:(1-alpha)];
    }
    
    if (!isTapOnGraphView) {
        _cityNameLabel.text = _cityNameArray[index];
        if (index != _countryGraphView.selectedIndex) {
            [_countryGraphView setSelectedIndex:index];
            
            FLUserData *user = _mayorDictionary[[NSString stringWithFormat:@"%i", index +1]];
            
            if (user) {
                _mayorNameLabel.text = [NSString stringWithFormat:@"Mayor : %@", user.facebookName];
                
                NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=80&height=80", user.facebookID];
                NSURL *profileUrl = [NSURL URLWithString:urlString];
                [_profileImageView setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
            }
            else {
                
                _mayorNameLabel.text = @"Mayor : nobody";
                [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (decelerate == NO) {
        [self fixScrollViewPosition:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self fixScrollViewPosition:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    isTapOnGraphView = NO;
}

- (void)fixScrollViewPosition:(UIScrollView *)scrollView {
    
    double positionY = (int)round((scrollView.contentOffset.y +8)/30) *30 -8;
    [scrollView setContentOffset:CGPointMake(0, positionY) animated:YES];
}

- (int)currentViewingIndex {
    
    return (int)(((_cityNameScrollView.contentOffset.y +20)/30) -1);
}



#pragma mark - Storyboard Delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"city"]) {
        [[UIApplication rootViewController] setEnableToMove:NO];
        
        int index = [self currentViewingIndex];
        
        FLCityData *cityData = [[FLDataSource sharedDataSource] getAllCityData][index];
        FLUserData *mayor = _mayorDictionary[[NSString stringWithFormat:@"%i", index +1]];
        
        [(FLCityViewController *)segue.destinationViewController setCityData:cityData];
        [(FLCityViewController *)segue.destinationViewController setMayorData:mayor];
    }
}




@end
