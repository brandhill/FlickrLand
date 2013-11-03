//
//  FLMenuViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@interface FLMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    
}
@property (nonatomic, strong) IBOutlet UIView *profileViewContainer;
@property (nonatomic, strong) IBOutlet UIImageView *profileContainer;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) IBOutlet UILabel *userNameLabel;


@property (nonatomic, strong) NSArray *sectionDataArray;


@end
