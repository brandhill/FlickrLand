//
//  FLCityViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLHorizontalPhotoView.h"
#import "FLCityData.h"
#import "FLUserData.h"
#import "UIImageView+AFNetworking.h"

@interface FLCityViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, FLHorizontalPhotoViewDelegate>  {
    
    
}
@property (nonatomic, strong) IBOutlet UIImageView *profileBorderView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;

@property (nonatomic, strong) IBOutlet UILabel *cityLabel;
@property (nonatomic, strong) IBOutlet UILabel *mayorNameLabel;
@property (nonatomic, strong) IBOutlet UIView *barSeparator;

@property (nonatomic, strong) IBOutlet UITableView *contentTableView;

@property (nonatomic, strong) UIView *infoContainerView;
@property (nonatomic, strong) FLHorizontalPhotoView *mayorPhotoView;

@property (nonatomic, strong) UIButton *statusContainerView;
@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UIImageView *starIcon;
@property (nonatomic, strong) UILabel *photoNumLabel;
@property (nonatomic, strong) UILabel *starNumLabel;
@property (nonatomic, strong) UIImageView *levelImage;

@property (nonatomic, strong) FLCityData *cityData;
@property (nonatomic, strong) FLUserData *mayorData;
@property (nonatomic, strong) NSArray *districtDataArray;

@end
