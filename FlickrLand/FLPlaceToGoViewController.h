//
//  FLPlaceToGoViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@interface FLPlaceToGoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, UIPickerViewDelegate> {
    
    UIWebView *webView;
}
@property (nonatomic, strong) IBOutlet UIButton *popularButton;
@property (nonatomic, strong) IBOutlet UIButton *targetButton;
@property (nonatomic, strong) IBOutlet UIButton *cultureButton;
@property (nonatomic, strong) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, strong) NSArray *popularDataArray;
@property (nonatomic, strong) NSArray *targetDataArray;
@property (nonatomic, strong) NSArray *cultureDataArray;
@property (nonatomic, weak) NSArray *contentDataArray;

@property (nonatomic, strong) NSArray *culturePalceArray;
@property (nonatomic, strong) NSMutableArray *annotationArray;

- (IBAction)popularButton_touchUpInside:(UIButton *)sender;
- (IBAction)targetButton_touchUpInside:(UIButton *)sender;
- (IBAction)cultureButton_touchUpInside:(UIButton *)sender;

@end
