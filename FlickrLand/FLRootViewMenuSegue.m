//
//  FLRootViewMenuSegue.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLRootViewMenuSegue.h"
#import "FLRootViewController.h"

@implementation FLRootViewMenuSegue

- (void)perform {
    
    FLRootViewController *rootViewController = [self sourceViewController];
    [rootViewController setMenuViewController:[self destinationViewController]];
}

@end
