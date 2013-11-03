//
//  FLTapIndicatorView.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTapIndicatorView : UIView {
    
}
@property (nonatomic, strong) UIImageView *centerPointView;
@property (nonatomic, strong) UIImageView *ArrowImageView;
@property (nonatomic, readwrite) CGPoint targetPoint;

- (id)initWithCenter:(CGPoint)center;
- (void)show;
- (void)hide;

@end
