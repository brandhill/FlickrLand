//
//  FLPhotoModalSegue.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLPhotoModalSegue.h"
#import "FLPhotoViewerViewController.h"

@implementation FLPhotoModalSegue

- (void)perform {
    
    UIViewController *originViewController = [self sourceViewController];
    FLPhotoViewerViewController *destinationViewController = [self destinationViewController];
    [destinationViewController setOriginViewContoller:originViewController];
    [destinationViewController view];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:originViewController.navigationController.view.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithWhite:68/255.0f alpha:1]];
    [backgroundView setAlpha:0];
    [originViewController.navigationController.view addSubview:backgroundView];
    
    UIView *originSnapShot = [originViewController.view snapshotViewAfterScreenUpdates:YES];
    [originViewController.view setHidden:YES];
    [originViewController.navigationController.view addSubview:originSnapShot];
    
    [originViewController presentViewController:destinationViewController animated:YES completion:nil];
    [UIView animateWithDuration:0.45f delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [backgroundView setAlpha:0.25];
        [originSnapShot setTransform:CGAffineTransformMakeScale(0.8f, 0.8f)];
        
    } completion:^(BOOL finished) {
        
        [originSnapShot removeFromSuperview];
        [originViewController.view setHidden:NO];
        [backgroundView removeFromSuperview];
    }];
}

@end
