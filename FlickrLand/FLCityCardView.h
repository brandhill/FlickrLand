//
//  FLCityCardView.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface FLCityCardView : UIView {
    
}
@property (nonatomic, strong) UIView      *containerView;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIImageView *levelIconView;
@property (nonatomic, strong) UILabel     *cityNameLabel;
@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UIImageView *starIcon;
@property (nonatomic, strong) UILabel     *photoNumLabel;
@property (nonatomic, strong) UILabel     *starNumLabel;

@end
