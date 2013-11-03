//
//  FLRootViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLRootViewController.h"
#import <Parse/Parse.h>

@interface FLRootViewController () {
    
    BOOL mainViewIsVisible;
    CGFloat lastTransX;
}

@end

@implementation FLRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    
    _menuViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.view.frame.size.height)];
    [_menuViewContainer setClipsToBounds:YES];
    [self.view addSubview:_menuViewContainer];
    
    [self performSegueWithIdentifier:@"menu" sender:nil];
    [self performSegueWithIdentifier:@"root" sender:nil];
    
    if ([PFUser currentUser] == nil) {
        
        [self setHideContent:YES];
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([PFUser currentUser] == nil) {
        
        [self performSegueWithIdentifier:@"login" sender:nil];
    }
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - Setter
- (void)setTopViewController:(UIViewController *)topViewController {
    
    //Adding View
    [self addChildViewController:topViewController];
    [topViewController didMoveToParentViewController:self];
    [topViewController view];
    [topViewController.view setBackgroundColor:[UIColor clearColor]];
    [topViewController.view setFrame:_topViewController == nil ? self.view.frame : _topViewController.view.frame];
    if (bounce) [topViewController.view setFrame:(CGRect){self.view.frame.size.width, 0, topViewController.view.frame.size}];
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMainControllerViewPanning:)];
    [topViewController.view addGestureRecognizer:panGesture];
    [self setEnableToMove:YES];
    
    [self.view addSubview:topViewController.view];
    [self.view bringSubviewToFront:_topViewController.view];
    
    if (_topViewController.view.frame.origin.x != 0) {
        
        if (bounce) {
            [UIView animateWithDuration:0.2f animations:^{
                [_topViewController.view setFrame:(CGRect){
                    self.view.frame.size.width,
                    _topViewController.view.frame.origin.y,
                    _topViewController.view.frame.size}];
            } completion:^(BOOL finished) {
                
                //Remove Old View
                [_topViewController.view removeFromSuperview];
                [_topViewController removeFromParentViewController];
                _topViewController = topViewController;
                
                [self showMainView];
            }];
        }
        else {
            //Remove Old View
            [_topViewController.view removeFromSuperview];
            [_topViewController removeFromParentViewController];
            _topViewController = topViewController;
            [self showMainView];
        }
    }
    else {
        
        //Remove Old View
        [_topViewController.view removeFromSuperview];
        [_topViewController removeFromParentViewController];
        _topViewController = topViewController;
    }
}
- (void)setMenuViewController:(UIViewController *)menuViewController {
    
    _menuViewController = menuViewController;
    
    //Adding View
    [self addChildViewController:menuViewController];
    [menuViewController didMoveToParentViewController:self];
    [menuViewController view];
    [menuViewController.view setFrame:self.view.frame];
    [menuViewController.view setCenter:CGPointMake(0, _menuViewController.view.center.y)];
    [_menuViewContainer addSubview:_menuViewController.view];
}

#pragma  mark - Action Methods
- (void)setEnableToMove:(BOOL)enableToMove {
    
    if (_enableToMove == enableToMove) return;
    
    _enableToMove = enableToMove;
    
    if (_enableToMove == NO) {
        [_topViewController.view removeGestureRecognizer:panGesture];
    }
    else {
        [_topViewController.view addGestureRecognizer:panGesture];
    }
}

- (void)setHideContent:(BOOL)hideContent {
    
    if (_hideContent == hideContent) return;
    _hideContent = hideContent;
    
    if (_hideContent) {
        [_topViewController.view setHidden:YES];
        [_menuViewContainer setHidden:YES];
    }
    else {
        [_topViewController.view setHidden:NO];
        [_menuViewContainer setHidden:NO];
    }
}




#pragma  mark - UI Events
- (IBAction)handleMainControllerViewPanning:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if (sender.view.frame.origin.x != 0)
            mainViewIsVisible = NO;
        else mainViewIsVisible = YES;
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (mainViewIsVisible) {
            
            double veloX = [sender velocityInView:sender.view].x;
            
            if (veloX > 0) {
                
                if (sender.view.frame.origin.x > sidePadding) {
                    [self hideMainView];
                }
                else [self showMainView];
            }
            else [self showMainView];
        }
        else {
            [self showMainView];
        }
    }
    else {
        CGPoint transCoor = [sender translationInView:sender.view];
        
        double newPositionX = sender.view.center.x +transCoor.x;
        if (newPositionX < self.view.center.x) {
            
            [sender.view setCenter:CGPointMake(self.view.center.x, sender.view.center.y)];
        }
        else {
            
            [sender.view setCenter:CGPointMake(sender.view.center.x +transCoor.x, sender.view.center.y)];
            [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
            
            double actionPercentage = sender.view.frame.origin.x / (self.view.frame.size.width -sidePadding);
            double offsetY = (1 -actionPercentage)* -160;
            offsetY = offsetY > 0 ? 0 : offsetY;
            [_menuViewController.view setFrame:(CGRect){offsetY, 0, _menuViewController.view.frame.size}];
            
            double containerWidth = _topViewController.view.frame.origin.x;
            [_menuViewContainer setFrame:CGRectMake(0, 0, containerWidth, _menuViewContainer.frame.size.height)];
        }
        
        lastTransX = transCoor.x;
    }
    
    
}
- (IBAction)handleMaskViewPanning:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if (sender.view.frame.origin.x != 0)
            mainViewIsVisible = NO;
        else mainViewIsVisible = YES;
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (mainViewIsVisible) {
            
            double veloX = [sender velocityInView:sender.view].x;
            
            if (veloX > 0) {
                
                if (sender.view.frame.origin.x > sidePadding) {
                    [self hideMainView];
                }
                else [self showMainView];
            }
            else [self showMainView];
        }
        else {
            [self showMainView];
        }
    }
    else {
        CGPoint transCoor = [sender translationInView:sender.view];
        
        double newPositionX = _topViewController.view.center.x +transCoor.x;
        if (newPositionX < self.view.center.x) {
            
            [_topViewController.view setCenter:CGPointMake(self.view.center.x, _topViewController.view.center.y)];
            double containerWidth = _topViewController.view.frame.origin.x;
            [_menuViewContainer setFrame:CGRectMake(0, 0, containerWidth, _menuViewContainer.frame.size.height)];
        }
        else {
            
            [_topViewController.view setCenter:CGPointMake(_topViewController.view.center.x +transCoor.x, _topViewController.view.center.y)];
            [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
            
            double actionPercentage = _topViewController.view.frame.origin.x / (self.view.frame.size.width -sidePadding);
            double offsetY = (1 -actionPercentage)* -160;
            offsetY = offsetY > 0 ? 0 : offsetY;
            [_menuViewController.view setFrame:(CGRect){offsetY, 0, _menuViewController.view.frame.size}];
            
            double containerWidth = _topViewController.view.frame.origin.x;
            [_menuViewContainer setFrame:CGRectMake(0, 0, containerWidth, _menuViewContainer.frame.size.height)];
        }
        
        lastTransX = transCoor.x;
    }
    
    
}
- (IBAction)handleMaskViewOnTap:(UITapGestureRecognizer *)sender {
    
    [self showMainView];
}

- (void)hideMainView {
    
    [self addMaskViewOnMainView];
    [UIView animateWithDuration:0.35f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [_topViewController.view setFrame:CGRectMake(self.view.frame.size.width -sidePadding, _topViewController.view.frame.origin.y, _topViewController.view.frame.size.width, _topViewController.view.frame.size.height)];
                         
                         double containerWidth = _topViewController.view.frame.origin.x;
                         [_menuViewContainer setFrame:CGRectMake(0, 0, containerWidth, _menuViewContainer.frame.size.height)];
                         [_menuViewController.view setFrame:(CGRect){0, 0, _menuViewController.view.frame.size}];
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)showMainView {
    
    [UIView animateWithDuration:0.35f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [_topViewController.view setFrame:CGRectMake(0, _topViewController.view.frame.origin.y, _topViewController.view.frame.size.width, _topViewController.view.frame.size.height)];
                         
                         double containerWidth = _topViewController.view.frame.origin.x;
                         [_menuViewContainer setFrame:CGRectMake(0, 0, containerWidth, _menuViewContainer.frame.size.height)];
                         [_menuViewController.view setFrame:(CGRect){-160, 0, _menuViewController.view.frame.size}];
                     } completion:^(BOOL finished) {
                         
                         [self removeMaskViewFromMainView];
                     }];
}

- (void)addMaskViewOnMainView {
    
    if (maskView == nil) {
        maskView = [[UIView alloc] init];
        [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        
        UIPanGestureRecognizer *maskPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskViewPanning:)];
        
        UITapGestureRecognizer *maskTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskViewOnTap:)];
        
        [maskView addGestureRecognizer:maskPanGesture];
        [maskView addGestureRecognizer:maskTapGesture];
    }
    
    [maskView setFrame:(CGRect){0, 0, _topViewController.view.frame.size}];
    [_topViewController.view addSubview:maskView];
}

- (void)removeMaskViewFromMainView {
    
    [maskView removeFromSuperview];
}

@end
