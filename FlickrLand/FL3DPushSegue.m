//
//  FL3DPushSegue.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FL3DPushSegue.h"
#import "FLAppTheme.h"

@implementation FL3DPushSegue

- (void)perform {
    
    UIViewController *originViewController = [self sourceViewController];
    UIViewController *destinationViewController = [self destinationViewController];
    [destinationViewController view];
    
    UIView *originSnapView = [originViewController.view snapshotViewAfterScreenUpdates:YES];
    [originSnapView setFrameOrigin:CGPointMake(0, 0)];
    [originViewController.navigationController.view addSubview:originSnapView];
    [originViewController.view setHidden:YES];
    
    UIView *snapView = [destinationViewController.view snapshotViewAfterScreenUpdates:YES];
    [snapView setFrameOrigin:CGPointMake(320, 0)];
    [originViewController.navigationController.view addSubview:snapView];
    [originSnapView setAnchorPointWithCurrentPosition:CGPointMake(0, 0.5)];
    [UIView animateWithDuration:0.75f
                          delay:0
         usingSpringWithDamping:0.8 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         
                         CATransform3D transform = CATransform3DIdentity;
                         transform.m34 = -0.0025; // 透视效果
                         transform = CATransform3DRotate(transform, (M_PI/180*90), 0, 1, 0);
                         [originSnapView.layer setTransform:transform];
                         
                         
                         [snapView setFrameOrigin:CGPointMake(0, 0)];
                         
                     } completion:^(BOOL finished) {
                         
                         [snapView removeFromSuperview];
                         [originSnapView removeFromSuperview];
                         [originViewController.view setHidden:NO];
                         
                         [originViewController.navigationController pushViewController:destinationViewController animated:NO];
                     }];
}

@end
