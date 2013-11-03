//
//  FLStarView.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>


#define progressingBorderRadius 50

@interface FLStarView : UIView {
    
}
//UI
@property (nonatomic, strong) UIImageView *starBackground;
@property (nonatomic, strong) UIImageView *starImageView;


//Data
@property (nonatomic, readwrite) double progress;
@property (nonatomic, readwrite) BOOL isInCircle;

- (void)show;
- (void)playStarAnimation;

@end
