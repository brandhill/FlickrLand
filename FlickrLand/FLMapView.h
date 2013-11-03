//
//  FLMapView.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FLMapView : UIView<MKMapViewDelegate> {
    
}
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UILabel *AddressLabel;
@property (nonatomic, strong) UIImageView *disclosureImageView;

@end
