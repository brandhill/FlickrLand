//
//  FLUserData.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLUserData.h"
#import "FLAppDelegate.h"


@implementation FLUserData

@dynamic facebookID;
@dynamic facebookName;
@dynamic flickrID;
@dynamic flickrName;
@dynamic photos;

+ (NSString *)name {
    
    return @"FLUserData";
}

+ (FLUserData *)userData {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    FLUserData *data = [NSEntityDescription
                         insertNewObjectForEntityForName:[FLUserData name]
                         inManagedObjectContext:context];
    
    return data;
}

+ (NSEntityDescription *)entity {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[FLUserData name]
                                              inManagedObjectContext:context];
    return entity;
}

- (BOOL)save {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    return [context save:nil];
}

@end
