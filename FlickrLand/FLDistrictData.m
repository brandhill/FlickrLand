//
//  FLDistrictData.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLDistrictData.h"
#import "FLCityData.h"
#import "FLAppDelegate.h"


@implementation FLDistrictData

@dynamic districtName;
@dynamic districtID;
@dynamic parentCity;
@dynamic photos;

+ (NSString *)name {
    
    return @"FLDistrictData";
}

+ (FLDistrictData *)districtData {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    FLDistrictData *data = [NSEntityDescription
                            insertNewObjectForEntityForName:[FLDistrictData name]
                            inManagedObjectContext:context];
    
    return data;
}

+ (NSEntityDescription *)entity {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[FLDistrictData name]
                                              inManagedObjectContext:context];
    return entity;
}

- (BOOL)save {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    return [context save:nil];
}

@end
