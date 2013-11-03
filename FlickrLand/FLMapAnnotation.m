//
//  FLMapAnnotation.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMapAnnotation.h"

@implementation FLMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        
        _coordinate = coordinate;
    }
    return self;
}

@end
