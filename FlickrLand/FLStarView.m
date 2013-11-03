//
//  FLStarView.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLStarView.h"
#import "FLAppTheme.h"

@implementation FLStarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clearsContextBeforeDrawing = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _progress = 0;
        
        UIImage *backgroundImage = [UIImage imageWithSize:CGSizeMake(50, 50) Color:[UIColor colorWithWhite:1 alpha:0.25f] radius:25];
        _starBackground = [[UIImageView alloc] initWithImage:backgroundImage];
        _starBackground.center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
        _starBackground.hidden = YES;
        [self addSubview:_starBackground];
        
        _starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_starButton"]];
        _starImageView.center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
        _starImageView.hidden = YES;
        [self addSubview:_starImageView];
    }
    return self;
}

- (void)setProgress:(double)progress {
    
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    double endAngle = 8.0f *_progress;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddArc(context, self.frame.size.width/2.0f, self.frame.size.height/2.0f, progressingBorderRadius, 0, endAngle, NO);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 2.0f);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

- (void)show {
    
    _starBackground.hidden = NO;
    _starImageView.hidden = NO;
    
    _starBackground.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    _starImageView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _starBackground.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3f delay:0.075f usingSpringWithDamping:0.65 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _starImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setIsInCircle:(BOOL)isInCircle {
    
    if (_isInCircle == isInCircle) return;
    
    _isInCircle = isInCircle;
    if (_isInCircle) {
        
        UIImage *backgroundImage = [UIImage imageWithSize:CGSizeMake(100, 100) Color:[UIColor colorWithWhite:1 alpha:0.25f] radius:50];
        [_starBackground setImage:backgroundImage];
        [UIView animateWithDuration:0.25f animations:^{
            [_starBackground setFrame:CGRectMake(5, 5, 100, 100)];
        }];
    }
    else {
        
        UIImage *backgroundImage = [UIImage imageWithSize:CGSizeMake(40, 40) Color:[UIColor colorWithWhite:1 alpha:0.25f] radius:20];
        [_starBackground setImage:backgroundImage];
        [UIView animateWithDuration:0.25f animations:^{
            [_starBackground setFrame:CGRectMake(35, 35, 40, 40)];
        }];
    }
    
    
}

- (void)playStarAnimation {
    
    UIImageView *bigStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_starIcon-large"]];
    [bigStar setFrameSize:CGSizeMake(28, 28)];
    [bigStar setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
    [self addSubview:bigStar];
    
    //[bigStar setTransform:CGAffineTransformMakeScale(0.001f, 0.001f)];
    
    [_starImageView setAlpha:0];
    [UIView animateWithDuration:0.25f animations:^{
        
        [bigStar setFrame:CGRectMake(15, 15, 80, 80)];
        [bigStar setAlpha:1];
        [bigStar setTransform:CGAffineTransformMakeRotation(1.5f)];
    } completion:^(BOOL finished) {
        [bigStar removeFromSuperview];
        [_starImageView setAlpha:1];
    }];
    
}

@end
