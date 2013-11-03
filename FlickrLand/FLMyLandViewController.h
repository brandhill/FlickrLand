//
//  FLMyLandViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "FLMyDistrictCell.h"
#import "FLCityData.h"
#import "FLDistrictData.h"
#import "FLPhotoCell.h"
#import "FLUserData.h"

@interface FLMyLandViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, FLMyDistrictCellDelegate> {
    
}
@property (nonatomic, strong) IBOutlet UIButton *cityButton;
@property (nonatomic, strong) IBOutlet UIButton *districtButton;
@property (nonatomic, strong) IBOutlet UIScrollView *cityScrollView;
@property (nonatomic, strong) IBOutlet UITableView *districtTableView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *cityDataArray;
@property (nonatomic, strong) NSArray *districtDataArray;
@property (nonatomic, strong) NSArray *contentDataArray;

- (IBAction)cityButton_touchUpInside:(UIButton *)sender;
- (IBAction)districtButton_touchUpInside:(UIButton *)sender;
@end
