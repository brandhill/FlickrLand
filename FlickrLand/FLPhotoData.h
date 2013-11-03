//
//  FLPhotoData.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLDistrictData, FLUserData;

@interface FLPhotoData : NSManagedObject

@property (nonatomic, retain) NSNumber * creatTime;
@property (nonatomic, retain) NSNumber * favoriteNum;
@property (nonatomic, retain) NSNumber * heightM;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * photoID;
@property (nonatomic, retain) NSString * sourceL;
@property (nonatomic, retain) NSString * sourceM;
@property (nonatomic, retain) NSNumber * widthM;
@property (nonatomic, retain) FLDistrictData *place;
@property (nonatomic, retain) FLUserData *owner;

+ (NSString *)name;
+ (FLPhotoData *)photoData;
+ (NSEntityDescription *)entity;
- (BOOL)save;

@end
