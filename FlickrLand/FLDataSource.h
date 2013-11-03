//
//  FLDataSource.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLUserData.h"
#import "FLPhotoData.h"
#import "FLCityData.h"
#import "FLDistrictData.h"
#import "FLCultureData.h"

__unused static NSString *FLIsSecondTimeBootKey = @"IsSecondTimeBoot";
__unused static NSString *FLVilDictionaryKey = @"VilDictionary";

__unused static NSString *FLUserFacebookIDKey = @"UserFacebookIDKey";
__unused static NSString *FLUserFlickrIDKey = @"UserFlickrIDKey";
__unused static NSString *FLUserNameKey = @"UserNameKey";
__unused static NSString *FLUserEmailKey = @"UserEmailKey";

@protocol FLDataSourceDelegate <NSObject>
- (void)userDataDidFinishedLoadingWithPercentage:(double)percentage;

@end


@interface FLDataSource : NSObject {
    
    NSUserDefaults *userDefaults;
    NSMutableDictionary *flickrNameDictionary;
}
@property (nonatomic, weak) id<FLDataSourceDelegate> dataDelegate;

#pragma mark - Class Methods
+ (FLDataSource *)sharedDataSource;
+ (NSString *)readStringFromFile:(NSString *)fileName type:(NSString *)type;
+ (id)jsonObjectFromString:(NSString *)jsonString;

#pragma mark - Culture Data
- (void)importCultureData;
- (NSArray *)getAllCulturData;

#pragma mark - Testing Data
- (void)importUserData;
- (NSDictionary *)getFBFriendsNameDictionary;

#pragma mark - City
- (NSArray *)getAllCityData;
- (NSArray *)getAllCityName;

#pragma mark - User Data
- (NSArray *)getAllFriends;
- (NSArray *)getPhotosWithUser:(FLUserData *)user;

#pragma mark - Holder
- (NSDictionary *)getMayors;
- (FLUserData *)getMayorOfCity:(FLCityData *)city;
- (NSMutableDictionary *)getFriendsPhotoNumInCity:(FLCityData *)city;
- (NSMutableArray *)getPhotosWithUser:(FLUserData *)user inCity:(FLCityData *)city;
- (NSMutableArray *)getInfoDistrictInCity:(FLCityData *)city;

- (FLUserData *)getHolderInDistrict:(FLDistrictData *)district;
- (NSArray *)getPhotosInDistrict:(FLDistrictData *)district;
- (NSArray *)getPhotosInCity:(FLCityData *)city;
- (NSArray *)getHoldingCity;
- (NSArray *)getHoldingDistrict;

#pragma mark - To Go
- (NSArray *)popularDistrict;
- (NSArray *)emptyDistrict;

#pragma mark - Achievement
- (UIImage *)bannerForPhotoNum:(int)photoNum;

@end
