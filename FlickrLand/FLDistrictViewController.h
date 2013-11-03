//
//  FLDistrictViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "FLMapView.h"
#import "FLDistrictData.h"

@interface FLDistrictViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    
}
//UI
@property (nonatomic, strong) IBOutlet UIImageView *profileBorderView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;

@property (nonatomic, strong) IBOutlet UILabel *districtLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIView *barSeparator;

@property (nonatomic, strong) UIView *statusContainerView;
@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UIImageView *starIcon;
@property (nonatomic, strong) UILabel *photoNumLabel;
@property (nonatomic, strong) UILabel *starNumLabel;

@property (nonatomic, strong) FLMapView *mapView;

@property (nonatomic, strong) IBOutlet UITableView *contentTableView;


//Data
@property (nonatomic, strong) NSArray *photoDataArray;
@property (nonatomic, strong) FLDistrictData *districtData;


@end
