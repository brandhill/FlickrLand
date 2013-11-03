//
//  FLMenuButtonCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMenuButtonCell.h"

@implementation FLMenuButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _selectIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_selectIndicator"]];
        [_selectIndicator setCenter:CGPointMake(70, 23)];
        [self addSubview:_selectIndicator];
        
        UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        [selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
        [self setSelectedBackgroundView:selectedBackgroundView];
        
        UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_selectIndicator1"]];
        [indicator setCenter:CGPointMake(70, 23.5)];
        [selectedBackgroundView addSubview:indicator];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 200, 44)];
        [_titleLabel setText:@"ViewController"];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

@end
