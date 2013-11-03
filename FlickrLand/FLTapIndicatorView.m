//
//  FLTapIndicatorView.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLTapIndicatorView.h"
#import "FLAppTheme.h"

@implementation FLTapIndicatorView

- (id)initWithCenter:(CGPoint)center {
    
    self = [self initWithFrame:CGRectMake(center.x -40.5, center.y -40.5, 81, 81)];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *centerPoint = [UIImage imageWithSize:CGSizeMake(26, 26) Color:[UIColor colorWithWhite:1 alpha:0.75] radius:13];
        _centerPointView = [[UIImageView alloc] initWithImage:centerPoint];
        _centerPointView.hidden = YES;
        _centerPointView.center = CGPointMake(40.5f, 40.5f);
        [self addSubview:_centerPointView];
        
        _ArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_tapIndicator"]];
        _ArrowImageView.hidden = YES;
        _ArrowImageView.center = CGPointMake(40.5f, 40.5f);
        [self addSubview:_ArrowImageView];
    }
    return self;
}

- (void)setTargetPoint:(CGPoint)targetPoint {
    
    _targetPoint = targetPoint;
    [self setCenter:self.center];
}

- (void)setCenter:(CGPoint)center {
    
    [super setCenter:center];
    
    CGPoint targetVector = CGPointMake(_targetPoint.x - center.x, _targetPoint.y - center.y);
    double vectorLength = sqrt(pow(targetVector.x, 2) +pow(targetVector.y, 2));
    
    double angle = acos((0*targetVector.x +-1*targetVector.y)/(vectorLength *1));
    if (center.x > _targetPoint.x) {
        angle = -angle;
    }
    _ArrowImageView.transform = CGAffineTransformMakeRotation(angle);
}

- (void)show {
    
    _centerPointView.hidden = NO;
    _ArrowImageView.hidden = NO;
    
    _centerPointView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    _ArrowImageView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _centerPointView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.35f delay:0.075f usingSpringWithDamping:0.65 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _ArrowImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _centerPointView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        
    } completion:^(BOOL finished) {
        _centerPointView.hidden = NO;
        
    }];
    
    [UIView animateWithDuration:0.4f delay:0.075f usingSpringWithDamping:0.65 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _ArrowImageView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        
    } completion:^(BOOL finished) {
        _ArrowImageView.hidden = NO;
    }];
}

@end
