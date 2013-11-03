//
//  FLDistrictData.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLCityData;

@interface FLDistrictData : NSManagedObject

@property (nonatomic, retain) NSString * districtName;
@property (nonatomic, retain) NSNumber * districtID;
@property (nonatomic, retain) FLCityData *parentCity;
@property (nonatomic, retain) NSSet *photos;
@end

@interface FLDistrictData (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(NSManagedObject *)value;
- (void)removePhotosObject:(NSManagedObject *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

+ (NSString *)name;
+ (FLDistrictData *)districtData;
+ (NSEntityDescription *)entity;
- (BOOL)save;


@end
