//
//  FLRootViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define bounce 0
#define sidePadding 60

@interface FLRootViewController : UIViewController {

    UIPanGestureRecognizer *panGesture;
    UIView *maskView;
}
@property (nonatomic, strong) IBOutlet UIImageView *backgroundView;

@property (nonatomic, strong) UIViewController *topViewController;
@property (nonatomic, strong) UIViewController *menuViewController;
@property (nonatomic, strong) UIView *menuViewContainer;

@property (nonatomic, readwrite) BOOL enableToMove;
@property (nonatomic, readwrite) BOOL hideContent;

- (void)hideMainView;
- (void)showMainView;

@end
