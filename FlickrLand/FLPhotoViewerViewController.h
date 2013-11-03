//
//  FLPhotoViewerViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLPhotoData.h"

@interface FLPhotoViewerViewController : UIViewController<UIScrollViewDelegate> {
    
}
//UI
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIButton *starButton;

@property (nonatomic, strong) IBOutlet UIImageView *profileBorderView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) IBOutlet UILabel *userNameLabel;


@property (nonatomic, strong) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) IBOutlet UIScrollView *photoScrollView;

@property (nonatomic, strong) IBOutlet UITextView *discriptionTextView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicatorView;


//Data
@property (nonatomic, strong) FLPhotoData *photoData;
@property (nonatomic, weak) UIViewController *originViewContoller;
@property (nonatomic, strong) UIImage *photoImage;

- (IBAction)cancelButton_touchUpInside:(UIButton *)sender;

@end
