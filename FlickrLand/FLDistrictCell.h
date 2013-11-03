//
//  FLDistrictCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLDistrictData.h"
#import "UIImageView+AFNetworking.h"
#import "FLPhotoData.h"


@interface FLDistrictCell : UITableViewCell {
    
}
@property (nonatomic, strong) UIImageView *profileBorderView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) UILabel *districtLabel;
@property (nonatomic, strong) UIView *photoContainer;

@property (nonatomic, strong) NSMutableArray *photoViewArray;
@property (nonatomic, strong) UIView *verticalLine;

@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UILabel *photoNumLabel;

@property (nonatomic, strong) UIImageView *starIcon;
@property (nonatomic, strong) UILabel *starNumLabel;

@property (nonatomic, strong) FLDistrictData *districtData;


@end
