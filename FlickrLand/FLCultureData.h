//
//  FLCultureData.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FLCultureData : NSManagedObject

@property (nonatomic, retain) NSString * placeName;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

+ (NSString *)name;
+ (FLCultureData *)cultureData;
+ (NSEntityDescription *)entity;
- (BOOL)save;


@end
