//
//  FLPhotoData.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLPhotoData.h"
#import "FLDistrictData.h"
#import "FLUserData.h"
#import "FLAppDelegate.h"


@implementation FLPhotoData

@dynamic creatTime;
@dynamic favoriteNum;
@dynamic heightM;
@dynamic latitude;
@dynamic longitude;
@dynamic photoID;
@dynamic sourceL;
@dynamic sourceM;
@dynamic widthM;
@dynamic place;
@dynamic owner;

+ (NSString *)name {
    
    return @"FLPhotoData";
}

+ (FLPhotoData *)photoData {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    FLPhotoData *data = [NSEntityDescription
                            insertNewObjectForEntityForName:[FLPhotoData name]
                            inManagedObjectContext:context];
    
    return data;
}

+ (NSEntityDescription *)entity {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[FLPhotoData name]
                                              inManagedObjectContext:context];
    return entity;
}

- (BOOL)save {
    
    FLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    return [context save:nil];
}

@end
