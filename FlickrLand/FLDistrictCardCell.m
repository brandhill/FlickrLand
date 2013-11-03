//
//  FLDistrictCardCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLDistrictCardCell.h"

@implementation FLDistrictCardCell


+ (CGSize)size {
    
    return CGSizeMake(120, 160);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 160)];
        [_containerView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.85f]];
        [_containerView setClipsToBounds:YES];
        [_containerView.layer setCornerRadius:4.0f];
        [self addSubview:_containerView];
        
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 110)];
        [_photoView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1f]];
        [_photoView setContentMode:UIViewContentModeScaleAspectFill];
        [_photoView setClipsToBounds:YES];
        [_containerView addSubview:_photoView];
        
        _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 100, 30)];
        [_cityNameLabel setText:@"城市"];
        [_cityNameLabel setBackgroundColor:[UIColor clearColor]];
        [_cityNameLabel setTextColor:[UIColor colorWithWhite:52/255.0f alpha:1]];
        [_cityNameLabel setFont:[UIFont systemFontOfSize:19.0f]];
        [_containerView addSubview:_cityNameLabel];
        
        _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 140, 12, 12)];
        [_photoIcon setImage:[UIImage imageNamed:@"cell_imageIcon-color"]];
        [_containerView addSubview:_photoIcon];
        
        _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,140 -4, 30 +50, 20)];
        [_photoNumLabel setText:@"0"];
        [_photoNumLabel setTextColor:[UIColor colorWithWhite:102/255.0f alpha:1]];
        [_photoNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_containerView addSubview:_photoNumLabel];
        
//        _starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(60, 140, 12, 12)];
//        [_starIcon setImage:[UIImage imageNamed:@"cell_starIcon-color"]];
//        [_containerView addSubview:_starIcon];
//        
//        _starNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 140 -4, 30, 20)];
//        [_starNumLabel setText:@"0"];
//        [_starNumLabel setTextColor:[UIColor colorWithWhite:102/255.0f alpha:1]];
//        [_starNumLabel setFont:[UIFont systemFontOfSize:12]];
//        [_containerView addSubview:_starNumLabel];
    }
    return self;
}

@end
