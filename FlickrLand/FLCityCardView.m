//
//  FLCityCardView.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLCityCardView.h"

@implementation FLCityCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 400)];
        [_containerView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.8f]];
        [_containerView setClipsToBounds:YES];
        [_containerView.layer setCornerRadius:6.0f];
        [self addSubview:_containerView];
        
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 300)];
        [_photoView setContentMode:UIViewContentModeScaleAspectFill];
        [_photoView setClipsToBounds:YES];
        [_containerView addSubview:_photoView];
        
        _levelIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"level_0"]];
        [_levelIconView setCenter:CGPointMake(_containerView.center.x, _photoView.frame.size.height)];
        [_containerView addSubview:_levelIconView];
        
        _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 322, 280, 34)];
        [_cityNameLabel setText:@"城市"];
        [_cityNameLabel setBackgroundColor:[UIColor clearColor]];
        [_cityNameLabel setTextColor:[UIColor colorWithWhite:52/255.0f alpha:1]];
        [_cityNameLabel setFont:[UIFont systemFontOfSize:21.0f]];
        [_containerView addSubview:_cityNameLabel];
        
        _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 364, 12, 12)];
        [_photoIcon setImage:[UIImage imageNamed:@"cell_imageIcon-color"]];
        [_containerView addSubview:_photoIcon];
        
        _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,364 -4, 80, 20)];
        [_photoNumLabel setText:@"0 Photos"];
        [_photoNumLabel setTextColor:[UIColor colorWithWhite:102/255.0f alpha:1]];
        [_photoNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_containerView addSubview:_photoNumLabel];
        
        _starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(120, 364, 12, 12)];
        [_starIcon setImage:[UIImage imageNamed:@"cell_starIcon-color"]];
        [_containerView addSubview:_starIcon];
        
        _starNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 364 -4, 80, 20)];
        [_starNumLabel setText:@"0 Stars"];
        [_starNumLabel setTextColor:[UIColor colorWithWhite:102/255.0f alpha:1]];
        [_starNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_containerView addSubview:_starNumLabel];
    }
    return self;
}

@end
