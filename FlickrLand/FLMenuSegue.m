//
//  FLMenuSegue.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMenuSegue.h"
#import "FLRootViewController.h"

@implementation FLMenuSegue

- (void)perform {
    
    FLRootViewController *rootViewController = (FLRootViewController *)[[self sourceViewController] parentViewController];
    [rootViewController setTopViewController:[self destinationViewController]];
}

@end
