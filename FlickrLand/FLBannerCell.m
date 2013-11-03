//
//  FLBannerCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLBannerCell.h"
#import "FLAppTheme.h"

@implementation FLBannerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithR:216 G:102 B:93 A:1]];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 58)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f]];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_titleLabel setText:@"My\nFavorite"];
        [self addSubview:_titleLabel];
        
        _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 135, 12, 12)];
        [_photoIcon setImage:[UIImage imageNamed:@"cell_imageIcon"]];
        [_photoIcon setAlpha:0.75f];
        [self addSubview:_photoIcon];
        
        _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 135-4, 80, 20)];
        [_photoNumLabel setText:@"0 Photos"];
        [_photoNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:0.75f]];
        [_photoNumLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_photoNumLabel];
    }
    return self;
}
@end
