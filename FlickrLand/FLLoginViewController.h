//
//  FLLoginViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "FLDataSource.h"

@interface FLLoginViewController : UIViewController<FLDataSourceDelegate> {
    
}
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) IBOutlet UIProgressView *progressView;

- (IBAction)loginButton_touchUpInside:(UIButton *)sender;

@end
