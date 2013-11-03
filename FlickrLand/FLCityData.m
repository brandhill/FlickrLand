//
//  FLCityData.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLCityData.h"
#import "FLAppDelegate.h"


@implementation FLCityData

@dynamic cityName;
@dynamic cityID;
@dynamic districts;

+ (NSString *)name {
    
    return @"FLCityData";
}

+ (FLCityData *)cityData {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    FLCityData *data = [NSEntityDescription
                            insertNewObjectForEntityForName:[FLCityData name]
                            inManagedObjectContext:context];
    
    return data;
}

+ (NSEntityDescription *)entity {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[FLCityData name]
                                              inManagedObjectContext:context];
    return entity;
}

- (BOOL)save {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    return [context save:nil];
}

@end
