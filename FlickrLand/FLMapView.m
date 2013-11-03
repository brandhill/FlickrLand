//
//  FLMapView.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMapView.h"
#import "FLAppTheme.h"

@implementation FLMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15f]];
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 145)];
        [_mapView setUserInteractionEnabled:NO];
        [_mapView setShowsUserLocation:YES];
        [self addSubview:_mapView];
        
        _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_checkinIcon"]];
        [_locationIcon setFrameOrigin:CGPointMake(15, 145 +6)];
        [self addSubview:_locationIcon];
        
        _AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 145, 260, 28)];
        [_AddressLabel setBackgroundColor:[UIColor clearColor]];
        [_AddressLabel setText:@"Address"];
        [_AddressLabel setTextColor:[UIColor whiteColor]];
        [_AddressLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_AddressLabel];
        
        _disclosureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_disclosure-small"]];
        [_disclosureImageView setFrameOrigin:CGPointMake(320 -15, 145 +4)];
        [self addSubview:_disclosureImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
