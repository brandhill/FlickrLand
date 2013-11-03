//
//  FLDataSource.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLDataSource.h"
#import "FLAppDelegate.h"
#import "FlickrKit.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FLDataSource

+ (FLDataSource *)sharedDataSource {
    
    static dispatch_once_t onceToken;
    static FLDataSource *sharedDatasource;
    dispatch_once(&onceToken, ^{
        sharedDatasource = [[FLDataSource alloc] init];
    });
    return sharedDatasource;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        userDefaults = [NSUserDefaults standardUserDefaults];
        
        if ([userDefaults boolForKey:FLIsSecondTimeBootKey] == NO) {
            [self importDistrictData];
            [self importCultureData];
            [userDefaults setBool:YES forKey:FLIsSecondTimeBootKey];
            [userDefaults synchronize];
        }
    }
    return self;
}

#pragma Class Methods

+ (NSString *)readStringFromFile:(NSString *)fileName type:(NSString *)type {
    
    NSString *sportFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSString* content = [NSString stringWithContentsOfFile:sportFilePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return content;
}

+ (id)jsonObjectFromString:(NSString *)jsonString {
    
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    if (result == nil) {
        NSLog(@"%@", error);
    }
    
    return result;
}


#pragma mark - Culture Data

- (void)importCultureData {
    
    NSString *cultureDataString = [FLDataSource readStringFromFile:@"icultureData" type:@"txt"];
    NSArray *cultureDataArray = [FLDataSource jsonObjectFromString:cultureDataString];
    
    for (NSDictionary *data in cultureDataArray) {
    
        FLCultureData *culture = [FLCultureData cultureData];
        [culture setPlaceName:data[@"name"]];
        [culture setLatitude:@([data[@"latitude"] doubleValue])];
        [culture setLongitude:@([data[@"longitude"] doubleValue])];
        [culture save];
    }
}

- (NSArray *)getAllCulturData {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLCultureData entity]];
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    return fetchedObjects;
}


#pragma mark - City Data

- (void)importDistrictData {
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingString:@"/districtData.csv"];
    NSString *fileDataString=[NSString
                              stringWithContentsOfFile:filePath
                              encoding:NSUTF8StringEncoding
                              error:nil];
    
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    NSMutableDictionary *createdCityDictionary = [NSMutableDictionary dictionary];
    for (NSString *lineString in linesArray) {
        
        if (lineString.length <= 0) continue;
        NSArray *lineObjects = [lineString componentsSeparatedByString:@","];
        
        NSString *cityID = lineObjects[3];
        FLCityData *cityData = nil;
        if (createdCityDictionary[cityID] == nil) {
            
            cityData = [FLCityData cityData];
            cityData.cityID = @([cityID integerValue]);
            cityData.cityName = lineObjects[2];
            [cityData save];
            
            createdCityDictionary[cityID] = cityData;
        }
        else {
            cityData = createdCityDictionary[cityID];
        }
        
        FLDistrictData *districtData = [FLDistrictData districtData];
        districtData.districtName = lineObjects[0];
        districtData.districtID = @([lineObjects[4] integerValue]);
        districtData.parentCity = cityData;
        [districtData save];
    }
}

- (NSArray *)getAllCityData {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLCityData entity]];
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    //Sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cityID" ascending:YES];
    NSArray *resultArray = [fetchedObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return resultArray;
}

- (NSArray *)getAllCityName {
    
    NSMutableDictionary *cityNameDic = [NSMutableDictionary dictionary];
    NSMutableArray *cityArray = [NSMutableArray array];
    
    NSArray *allCityDataArray = [self getAllCityData];
    for (FLCityData *data in allCityDataArray) {
        
        if (cityNameDic[data.cityName] == nil) {
            [cityArray addObject:data.cityName];
            cityNameDic[data.cityName] = @YES;
        }
    }
    
    return cityArray;
}


#pragma mark - User Data

- (NSArray *)getAllFriends {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLUserData entity]];
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    return fetchedObjects;
}

- (NSArray *)getPhotosWithUser:(FLUserData *)user {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"owner == %@", user];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLPhotoData entity]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    return [fetchedObjects mutableCopy];
}


#pragma mark - Testing Data

- (void)importUserData {
    
    NSArray *fileStringArray = @[@"/data.txt"];
    for (NSString *fileName in fileStringArray) {
        
        NSArray *photoDataArray = [self getTestingDataWithFileName:fileName];
        NSMutableDictionary *friendsMappingDictionary = [[self getMappingFriendDictionary] mutableCopy];
        NSDictionary *facebookNameDictionary = [self getFBFriendsNameDictionary];
        NSArray *allFBID = [facebookNameDictionary allKeys];
        NSMutableDictionary *userDictionary = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *reverseFriendsMappingDictionary = [NSMutableDictionary dictionary];
        NSArray *flNameArray = [friendsMappingDictionary allKeys];
        for (NSString *name in flNameArray) {
            NSString *fbID = friendsMappingDictionary[name];
            reverseFriendsMappingDictionary[fbID] = name;
        }
        int index = 0;
        int totalDataNum = [photoDataArray count];
        for (NSDictionary *data in photoDataArray) {
            
            index ++;
            NSLog(@"index = %i", index);
            if ([_dataDelegate respondsToSelector:@selector(userDataDidFinishedLoadingWithPercentage:)]) {
                [_dataDelegate userDataDidFinishedLoadingWithPercentage:(double)index/(double)totalDataNum];
            }
            
            NSString *userFLID = data[@"userID"];
            FLUserData *user = userDictionary[userFLID];
            if (user == nil) {
                
                user = [FLUserData userData];
                user.flickrID = userFLID;
                user.flickrName = [self getFlckrNameWithID:userFLID];
                
                if ([userFLID isEqualToString:@"30222664@N00"]) {
                    
                    user.facebookID = [userDefaults valueForKey:FLUserFacebookIDKey];
                    user.facebookName = [userDefaults valueForKey:FLUserNameKey];
                    [user save];
                    
                    userDictionary[userFLID] = user;
                }
                else {
                    
                    NSString *facebookID = friendsMappingDictionary[user.flickrName];
                    NSLog(@"%@", facebookID);
                    if (facebookID == nil) {
                        while (facebookID == nil) {
                            NSString *tempID = allFBID[arc4random()%[allFBID count]];
                            if (reverseFriendsMappingDictionary[tempID] == nil) {
                                facebookID = tempID;
                            }
                        }
                    }
                    
                    user.facebookID = facebookID;
                    user.facebookName = facebookNameDictionary[facebookID];
                    [user save];
                    
                    userDictionary[userFLID] = user;
                }
            }
            
            FLPhotoData *photoData = [FLPhotoData photoData];
            photoData.owner = user;
            
            photoData.creatTime = data[@"creatTime"];
            photoData.photoID = data[@"id"];
            photoData.favoriteNum = data[@"favoriteNum"];
            
            photoData.latitude = @([data[@"latitude"] doubleValue]);
            photoData.longitude = @([data[@"longitude"] doubleValue]);
            
            photoData.heightM = @([data[@"heightM"] doubleValue]);
            photoData.widthM = @([data[@"widthM"] doubleValue]);
            
            photoData.sourceL = data[@"srcL"];
            photoData.sourceM = data[@"srcM"];
            
            FLDistrictData *district = [self districtFromPlaceString:data[@"placeString"]];
            if (district == nil) continue;
            
            photoData.place = district;
            [photoData save];
        }
    }
}

- (FLDistrictData *)districtFromPlaceString:(NSString *)placeString {
    
    NSArray *jsonArray = [placeString componentsSeparatedByString:@","];
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    for (NSString *place in jsonArray) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"districtName == %@", place];
        
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[FLDistrictData entity]];
        [fetchRequest setPredicate:predicate];
        
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
        
        if ([fetchedObjects count] > 0) {
            
            return fetchedObjects[0];
        }
    }
    return nil;
}

- (NSDictionary *)getFBFriendsNameDictionary {
    
    __block BOOL isRequestFinished = NO;
    __block NSMutableArray *friendsArray = [NSMutableArray array];
    NSString *path = @"me/friends";
    [FBRequestConnection startWithGraphPath:path completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            friendsArray = result[@"data"];
        }
        else {
            NSLog(@"Request friends faild, error : %@",error);
        }
        isRequestFinished = YES;
    }];
    
    while (isRequestFinished == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *data in friendsArray) {
        resultDictionary[data[@"id"]] = data[@"name"];
    }
    return resultDictionary;
}

- (NSArray *)getTestingDataWithFileName:(NSString *)fileName {
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingString:fileName];
    NSString *fileDataString=[NSString
                              stringWithContentsOfFile:filePath
                              encoding:NSUTF8StringEncoding
                              error:nil];
    NSArray *result = [FLDataSource jsonObjectFromString:fileDataString];
    return result;
}

- (NSDictionary *)getMappingFriendDictionary {
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *friendFilePath = [resourcePath stringByAppendingString:@"/FriendsMatchFinal.txt"];
    NSString *friendDataString = [NSString
                                  stringWithContentsOfFile:friendFilePath
                                  encoding:NSUTF8StringEncoding
                                  error:nil];
    NSArray *friendDataArray = [[FLDataSource jsonObjectFromString:friendDataString] valueForKey:@"data"];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *friendDictionary in friendDataArray) {
        
        dictionary[friendDictionary[@"name"]] = friendDictionary[@"id"];
    }
    return dictionary;
}

- (NSString *)getFlckrNameWithID:(NSString *)flickrID {
    
    if (flickrNameDictionary == nil) flickrNameDictionary = [NSMutableDictionary dictionary];
    
    if (flickrNameDictionary[flickrID] == nil) {
        
        __block BOOL isFinishedFectching = NO;
        
        [[FlickrKit sharedFlickrKit] call:@"flickr.people.getInfo" args:@{@"user_id":flickrID} maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (response) {
                    NSString *realName = response[@"person"][@"realname"][@"_content"];
                    if (realName) {
                        flickrNameDictionary[flickrID] = realName;
                    }
                }
                isFinishedFectching = YES;
            });
        }];
        while (isFinishedFectching == NO) [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return flickrNameDictionary[flickrID];
}


#pragma mark - Holder Data

- (NSDictionary *)getMayors {
    
    NSArray *cityDataArray = [self getAllCityData];
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    for (FLCityData *cityData in cityDataArray) {
        
        NSMutableDictionary *numData = [self getFriendsPhotoNumInCity:cityData];
        NSInteger maxNum = 0;
        FLUserData *user = nil;
        for (NSString *key in [numData allKeys]) {
            
            NSInteger num = [numData[key][@"num"] integerValue];
            if (num > maxNum) {
                user = numData[key][@"user"];
            }
        }
        if (user) resultDictionary[[cityData.cityID stringValue]] = user;
    }
    return resultDictionary;
}

- (FLUserData *)getMayorOfCity:(FLCityData *)city {
    
    NSMutableDictionary *numData = [self getFriendsPhotoNumInCity:city];
    NSInteger maxNum = 0;
    FLUserData *user = nil;
    for (NSString *key in [numData allKeys]) {
        
        NSInteger num = [numData[key][@"num"] integerValue];
        if (num > maxNum) {
            user = numData[key][@"user"];
        }
    }
    return user;
}

- (NSMutableDictionary *)getFriendsPhotoNumInCity:(FLCityData *)city {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"place.parentCity == %@", city];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLPhotoData entity]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    for (FLPhotoData *photoData in fetchedObjects) {
        
        
        FLUserData *userData = photoData.owner;
        if (resultDictionary[userData.facebookID] == nil) {
            resultDictionary[userData.facebookID] = @{@"user":userData, @"num":@(1)};
        }
        else {
            NSInteger num = [resultDictionary[userData.facebookID][@"num"] integerValue];
            resultDictionary[userData.facebookID] = @{@"user":userData, @"num":@(num +1)};
        }
    }
    return resultDictionary;
}

- (NSMutableArray *)getPhotosWithUser:(FLUserData *)user inCity:(FLCityData *)city {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"place.parentCity == %@ AND owner == %@", city, user];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLPhotoData entity]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    return [fetchedObjects mutableCopy];
}

- (NSMutableArray *)getInfoDistrictInCity:(FLCityData *)city {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentCity == %@", city];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLDistrictData entity]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (FLDistrictData *data in fetchedObjects) {
        
        if ([data.photos count] > 0) {
            [resultArray addObject:data];
        }
    }
    
    return resultArray;
}

- (FLUserData *)getHolderInDistrict:(FLDistrictData *)district {

    NSMutableDictionary *numData = [self getFriendsPhotoNumInDistrict:district];
    NSInteger maxNum = 0;
    FLUserData *user = nil;
    for (NSString *key in [numData allKeys]) {
        
        NSInteger num = [numData[key][@"num"] integerValue];
        if (num > maxNum) {
            user = numData[key][@"user"];
        }
    }
    return user;
}

- (NSMutableDictionary *)getFriendsPhotoNumInDistrict:(FLDistrictData *)district {
    
    NSArray *fetchedObjects = [self getPhotosInDistrict:district];
    
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    for (FLPhotoData *photoData in fetchedObjects) {
        
        
        FLUserData *userData = photoData.owner;
        if (resultDictionary[userData.facebookID] == nil) {
            resultDictionary[userData.facebookID] = @{@"user":userData, @"num":@(1)};
        }
        else {
            NSInteger num = [resultDictionary[userData.facebookID][@"num"] integerValue];
            resultDictionary[userData.facebookID] = @{@"user":userData, @"num":@(num +1)};
        }
    }
    return resultDictionary;
}

- (NSArray *)getPhotosInDistrict:(FLDistrictData *)district {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"place == %@", district];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLPhotoData entity]];
    [fetchRequest setPredicate:predicate];
    
    return [context executeFetchRequest:fetchRequest error:nil];

}

- (NSArray *)getPhotosInCity:(FLCityData *)city {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"place.parentCity == %@", city];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLPhotoData entity]];
    [fetchRequest setPredicate:predicate];
    
    return [context executeFetchRequest:fetchRequest error:nil];
    
}

- (NSArray *)getHoldingCity {
    
    NSString *userFBID = [userDefaults valueForKey:FLUserFacebookIDKey];
    
    NSArray *cityDataArray = [self getAllCityData];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (FLCityData *cityData in cityDataArray) {
        
        NSMutableDictionary *numData = [self getFriendsPhotoNumInCity:cityData];
        NSInteger maxNum = 0;
        FLUserData *user = nil;
        for (NSString *key in [numData allKeys]) {
            
            NSInteger num = [numData[key][@"num"] integerValue];
            if (num > maxNum) {
                user = numData[key][@"user"];
            }
        }
        if ([user.facebookID isEqualToString:userFBID]) [resultArray addObject:cityData];
    }
    return resultArray;
}

- (NSArray *)getHoldingDistrict {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLDistrictData entity]];
    
    NSArray *districtArray = [context executeFetchRequest:fetchRequest error:nil];
    NSString *userFBID = [userDefaults valueForKey:FLUserFacebookIDKey];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (FLDistrictData *district in districtArray) {
        
        if ([district.photos count] > 0) {
            FLUserData *holder = [self getHolderInDistrict:district];
            if ([holder.facebookID isEqualToString:userFBID]) {
                [resultArray addObject:district];
            }
        }
    }
    return resultArray;
}

#pragma mark - To Go

- (NSArray *)popularDistrict {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLDistrictData entity]];
    
    NSArray *districtArray = [context executeFetchRequest:fetchRequest error:nil];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (FLDistrictData *district in districtArray) {
        
        if ([district.photos count] > 20) {
            [resultArray addObject:district];
        }
    }
    return resultArray;
}

- (NSArray *)emptyDistrict {
    
    NSManagedObjectContext *context = [(FLAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    //Query City Photo
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[FLDistrictData entity]];
    
    NSArray *districtArray = [context executeFetchRequest:fetchRequest error:nil];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (FLDistrictData *district in districtArray) {
        
        if ([district.photos count] <= 0) {
            [resultArray addObject:district];
        }
    }
    return resultArray;
}


#pragma mark - Achievement

- (UIImage *)bannerForPhotoNum:(int)photoNum {
    
    int level = 0;
    if (photoNum > 10) level++;
    if (photoNum > 50) level++;
    if (photoNum > 100) level++;
    if (photoNum > 250) level++;
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"city_level%i", level]];
}

@end
