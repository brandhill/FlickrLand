//
//  FLUserData.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FLUserData : NSManagedObject

@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * facebookName;
@property (nonatomic, retain) NSString * flickrID;
@property (nonatomic, retain) NSString * flickrName;
@property (nonatomic, retain) NSSet *photos;
@end

@interface FLUserData (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(NSManagedObject *)value;
- (void)removePhotosObject:(NSManagedObject *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

+ (NSString *)name;
+ (FLUserData *)userData;
+ (NSEntityDescription *)entity;
- (BOOL)save;


@end
