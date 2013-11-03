//
//  FLCultureData.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLCultureData.h"
#import "FLAppDelegate.h"


@implementation FLCultureData

@dynamic placeName;
@dynamic latitude;
@dynamic longitude;

+ (NSString *)name {
    
    return @"FLCultureData";
}

+ (FLCultureData *)cultureData {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    FLCultureData *data = [NSEntityDescription
                        insertNewObjectForEntityForName:[FLCultureData name]
                        inManagedObjectContext:context];
    
    return data;
}

+ (NSEntityDescription *)entity {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[FLCultureData name]
                                              inManagedObjectContext:context];
    return entity;
}

- (BOOL)save {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    return [context save:nil];
}

@end
