//
//  FLAchievementCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLAchievementCell.h"

@implementation FLAchievementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 44, 44)];
        [self addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 220, 30)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:28.0f]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_titleLabel];
        
        _discriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 220, 14)];
        [_discriptionLabel setBackgroundColor:[UIColor clearColor]];
        [_discriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
        [_discriptionLabel setTextColor:[UIColor colorWithWhite:1 alpha:0.5f]];
        [self addSubview:_discriptionLabel];
        
        UIView *verticleLine = [[UIView alloc] initWithFrame:CGRectMake(57, 49, 1, 20)];
        [verticleLine setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5f]];
        [self addSubview:verticleLine];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
