//
//  FLAppTheme.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLRootViewController.h"


typedef NS_ENUM(NSInteger, FLAppColor) {
    
    FLAppColorCountryColorLevel0 = 0xe3f2e8,
    FLAppColorCountryColorLevel1 = 0xd9edde,
    FLAppColorCountryColorLevel2 = 0xcee8d5,
    FLAppColorCountryColorLevel3 = 0xc3e2ce,
    FLAppColorCountryColorSelected = 0xf4ca76
};

@interface FLAppTheme : NSObject

+ (void)menuButtonForViewController:(UIViewController *)viewController;
+ (void)backButtonForViewController:(UIViewController *)viewController;

@end

@interface UIView (AppTheme)

- (void)setFrameOrigin:(CGPoint)origin;
- (void)setFrameSize:(CGSize)size;
- (void)setAnchorPointWithCurrentPosition:(CGPoint)anchorPoint;

@end

@interface UIColor (AppTheme)

+ (UIColor *)colorWithAppColor:(FLAppColor)colorCode;
+ (UIColor *)colorWithAppColor:(FLAppColor)colorCode alpha:(double)alpha;
+ (UIColor *)colorWithR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B A:(double)A;
- (BOOL) isEqualToColor:(UIColor *) otherColor;

@end


@interface UIImage (AppTheme)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithSize:(CGSize)size Color:(UIColor *)color;
+ (UIImage *)imageWithSize:(CGSize)size Color:(UIColor *)color radius:(CGFloat)radius;

@end


@interface NSLayoutConstraint (AppTheme)

+ (void)addConstraint:(NSString *)constraint views:(NSDictionary *)views toView:(UIView *)targetView;

@end


@interface UIApplication (AppTheme)

+ (FLRootViewController *)rootViewController;

@end
