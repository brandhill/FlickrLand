//
//  FLAppTheme.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLAppTheme.h"

@implementation FLAppTheme

+ (FLAppTheme *) sharedTheme {
    static dispatch_once_t onceToken;
    static FLAppTheme *sharedTheme;
    dispatch_once(&onceToken, ^{
        sharedTheme = [[self alloc] init];
    });
    return sharedTheme;
}

+ (void)menuButtonForViewController:(UIViewController *)viewController {
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [menuButton setImage:[UIImage imageNamed:@"navigation_menu"] forState:UIControlStateNormal];
    [menuButton setAdjustsImageWhenHighlighted:YES];
    [menuButton addTarget:[UIApplication rootViewController]  action:@selector(hideMainView) forControlEvents:UIControlEventTouchUpInside];
    [viewController.view addSubview:menuButton];
    
}

+ (void)backButtonForViewController:(UIViewController *)viewController {
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"navigation_backButton"] forState:UIControlStateNormal];
    [backButton setAdjustsImageWhenHighlighted:YES];
    [backButton addTarget:[FLAppTheme sharedTheme]  action:@selector(backButton_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [viewController.view addSubview:backButton];
    
    __weak UIViewController *viewControllerPointer = viewController;
    [backButton.layer setValue:viewControllerPointer forKey:@"viewController"];
}

- (IBAction)backButton_touchUpInside:(UIButton *)sender {
    
    UIViewController *viewController = [sender.layer valueForKey:@"viewController"];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0025; // 透视效果
    transform = CATransform3DRotate(transform, (M_PI/180*90), 0, 1, 0);
    
    NSInteger currentIndex = [[viewController.navigationController childViewControllers] count] -1;
    
    UIViewController *originViewController = [viewController.navigationController childViewControllers][currentIndex -1];
    UIViewController *currentViewController = [viewController.navigationController childViewControllers][currentIndex];
    
    UIView *originSnapView = originViewController.view;
    [originSnapView setAnchorPointWithCurrentPosition:CGPointMake(0, 0.5)];
    [originSnapView.layer setTransform:transform];
    [viewController.navigationController.view addSubview:originSnapView];
    
    UIView *currentSnapView = [currentViewController.view snapshotViewAfterScreenUpdates:YES];
    [viewController.navigationController.view addSubview:currentSnapView];
    
    //[originViewController.view setHidden:YES];
    [currentViewController.view setHidden:YES];
    
    [UIView animateWithDuration:0.75f
                          delay:0
         usingSpringWithDamping:0.8 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         
                         CATransform3D transform = CATransform3DIdentity;
                         transform.m34 = -0.0025; // 透视效果
                         transform = CATransform3DRotate(transform, (M_PI/180*0), 0, 1, 0);
                         [originSnapView.layer setTransform:transform];
                         
                         
                         [currentSnapView setFrameOrigin:CGPointMake(320, 0)];
                         
                     } completion:^(BOOL finished) {
                         
                         [currentSnapView removeFromSuperview];
                         //[originSnapView removeFromSuperview];
                         [originSnapView setAnchorPointWithCurrentPosition:CGPointMake(0.5, 0.5)];
                         
                         //[originViewController.view setHidden:NO];
                         [currentViewController.view setHidden:NO];
                         
                         [viewController.navigationController popViewControllerAnimated:NO];
                     }];
}

@end

#pragma mark - UIView Category
@implementation UIView (AppTheme)

- (void)setFrameOrigin:(CGPoint)origin {
    
    [self setFrame:(CGRect){origin, self.frame.size}];
}
- (void)setFrameSize:(CGSize)size {
    
    [self setFrame:(CGRect){self.frame.origin, size}];
}

- (void)setAnchorPointWithCurrentPosition:(CGPoint)anchorPoint {
    
    CGPoint newPoint = CGPointMake(self.bounds.size.width * anchorPoint.x, self.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint position = self.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    self.layer.position = position;
    self.layer.anchorPoint = anchorPoint;
}

@end


#pragma mark - UIColor Category
@implementation UIColor (AppTheme)

+ (UIColor *)colorWithAppColor:(FLAppColor)colorCode {
    
    return [UIColor colorWithAppColor:colorCode alpha:1];
}

+ (UIColor *)colorWithAppColor:(FLAppColor)colorCode alpha:(double)alpha {
    
    NSInteger blue = colorCode%256;
    NSInteger green = ((colorCode -blue)/256)%256;
    NSInteger red = (((colorCode -blue)/256) -green)/256;
    
    return [UIColor colorWithR:red G:green B:blue A:alpha];
}

+ (UIColor *)colorWithR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B A:(double)A {
    
    return [UIColor colorWithRed:(float)R/255.0f green:(float)G/255.0f blue:(float)B/255.0f alpha:A];
}

- (BOOL) isEqualToColor:(UIColor *) otherColor
{
    return CGColorEqualToColor(self.CGColor, otherColor.CGColor);
}

@end


@implementation UIImage (AppTheme)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    return [UIImage imageWithSize:CGSizeMake(1, 1) Color:color];
}

+ (UIImage *)imageWithSize:(CGSize)size Color:(UIColor *)color {
    
    CGRect rect = (CGRect){0, 0, size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithSize:(CGSize)size Color:(UIColor *)color radius:(CGFloat)radius {
    
    CGRect rect = (CGRect){0, 0, size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, radius, 0);
    CGContextAddLineToPoint(context, size.width -radius, 0);
    
    CGContextAddArcToPoint(context, size.width, 0, size.width, radius, radius);
    CGContextAddLineToPoint(context, size.width, size.height -radius);
    
    CGContextAddArcToPoint(context, size.width, size.height, size.width -radius, size.height, radius);
    CGContextAddLineToPoint(context, radius, size.height);
    
    CGContextAddArcToPoint(context, 0, size.height, 0, size.height -radius, radius);
    CGContextAddLineToPoint(context, 0, radius);
    
    
    CGContextAddArcToPoint(context, 0, 0, radius, 0, radius);
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end


@implementation NSLayoutConstraint (AppTheme)

+ (void)addConstraint:(NSString *)constraint views:(NSDictionary *)views toView:(UIView *)targetView {
    
    [targetView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraint
                                                                       options:NSLayoutFormatAlignAllBaseline
                                                                       metrics:nil
                                                                         views:views]];
}
@end


@implementation UIApplication (AppTheme)

+ (FLRootViewController *)rootViewController {
    
    return (FLRootViewController *)[[[UIApplication sharedApplication] windows][0] rootViewController];
}

@end
