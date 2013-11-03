//
//  FLCountryViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLTaiwanGraphView.h"
#import "UIImageView+AFNetworking.h"

@interface FLCountryViewController : UIViewController <FLTaiwanGraphViewDelegate, UIScrollViewDelegate> {
    
    BOOL isTapOnGraphView;
    NSArray *cloudPositionArray;
}
@property (nonatomic, strong) FLTaiwanGraphView *countryGraphView;
@property (nonatomic, strong) NSMutableArray *cloudArray;

@property (nonatomic, strong) IBOutlet UIImageView *profileBorderView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *mayorNameLabel;

@property (nonatomic, strong) IBOutlet UIView *separatorLine;
@property (nonatomic, strong) IBOutlet UIButton *cityButton;

@property (nonatomic, strong) IBOutlet UIScrollView *cityNameScrollView;

@property (nonatomic, strong) NSArray *cityNameArray;
@property (nonatomic, strong) NSDictionary *mayorDictionary;
@property (nonatomic, strong) NSMutableArray *cityNameButtonArray;
@end
