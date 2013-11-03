//
//  FLLoginViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLLoginViewController.h"
#import "FLRootViewController.h"
#import "FLMenuViewController.h"
#import "FLAppTheme.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FLLoginViewController ()

@end

@implementation FLLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    
    UIImage *buttonBackgroundImage = [UIImage imageWithSize:CGSizeMake(260, 50) Color:[UIColor colorWithWhite:1 alpha:0.15f] radius:3.0f];
    [_loginButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_indicatorView setHidesWhenStopped:YES];
    [_indicatorView setCenter:CGPointMake(_loginButton.frame.size.width -25, 25)];
    [_loginButton addSubview:_indicatorView];
    
    [_progressView setProgress:0];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (IBAction)loginButton_touchUpInside:(UIButton *)sender {
    
    [_indicatorView startAnimating];
    [_loginButton setTitle:@"Loading..." forState:UIControlStateNormal];
    [[FLDataSource sharedDataSource] setDataDelegate:self];
    
    __block BOOL isFinished = NO;
    
    NSArray *permissions = @[@"email",@"basic_info", @"user_friends"];
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            
            [self setupUserDetail];
        } else {
            
            [self setupUserDetail];
        }
        
        isFinished = YES;
    }];
    
    while (isFinished == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    //isFinished = NO;
    if ([PFUser currentUser]) {
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [[FLDataSource sharedDataSource] importUserData];
            [_indicatorView stopAnimating];
            [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
            [self dismissViewControllerAnimated:YES completion:nil];
        //});
    }
//    while (isFinished == NO) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
}

- (void)setupUserDetail {
    
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            
            NSString *fbID =@"";
            if ([[result objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
                fbID = [[result objectForKey:@"id"] stringValue];
            }
            else fbID = [result objectForKey:@"id"];
            
            NSString *userName = [result objectForKey:@"name"] == nil ? @"" : [result objectForKey:@"name"];
            NSString *userEmail = [result objectForKey:@"email"] == nil ? @"" : [result objectForKey:@"email"];
            
            [[NSUserDefaults standardUserDefaults] setValue:fbID forKey:FLUserFacebookIDKey];
            [[NSUserDefaults standardUserDefaults] setValue:userName forKey:FLUserNameKey];
            [[NSUserDefaults standardUserDefaults] setValue:userEmail forKey:FLUserEmailKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            FLRootViewController *rootViewController = [UIApplication rootViewController];
            [rootViewController setHideContent:NO];
            
            FLMenuViewController *menuViewController= (FLMenuViewController *)rootViewController.menuViewController;
            
            UIImageView *menuProfile = [menuViewController profileImageView];
            
            NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", fbID];
            NSURL *profileUrl = [NSURL URLWithString:urlString];
            [menuProfile setImageWithURL:profileUrl];
            [menuViewController.userNameLabel setText:userName];
        }
    }];
}

- (void)userDataDidFinishedLoadingWithPercentage:(double)percentage {
    
//    if (percentage >= 1) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_progressView setProgress:percentage animated:YES];
    });
}


@end
