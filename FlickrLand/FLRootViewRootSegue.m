//
//  FLRootViewRootSegue.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLRootViewRootSegue.h"
#import "FLRootViewController.h"

@implementation FLRootViewRootSegue

- (void)perform {
    
    FLRootViewController *rootViewController = [self sourceViewController];
    [rootViewController setTopViewController:[self destinationViewController]];
}

@end
