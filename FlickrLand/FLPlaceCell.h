//
//  FLPlaceCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPlaceCell : UITableViewCell {
    
}
//UI
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) UIView      *photoViewContainer;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel     *placeNameLabel;
@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UILabel     *photoNumLabel;
@property (nonatomic, strong) UIImageView *disclosureImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) NSURL *photoUrl;

+ (CGFloat)height;


@end
