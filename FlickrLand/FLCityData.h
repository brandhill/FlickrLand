//
//  FLCityData.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FLCityData : NSManagedObject

@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSNumber * cityID;
@property (nonatomic, retain) NSSet *districts;
@end

@interface FLCityData (CoreDataGeneratedAccessors)

- (void)addDistrictsObject:(NSManagedObject *)value;
- (void)removeDistrictsObject:(NSManagedObject *)value;
- (void)addDistricts:(NSSet *)values;
- (void)removeDistricts:(NSSet *)values;

+ (NSString *)name;
+ (FLCityData *)cityData;
+ (NSEntityDescription *)entity;
- (BOOL)save;

@end
