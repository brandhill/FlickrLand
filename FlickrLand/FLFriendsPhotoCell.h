//
//  FLFriendsPhotoCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLUserData.h"

@interface FLFriendsPhotoCell : UITableViewCell {
    
}
@property (nonatomic, strong) UIImageView *profileBorderView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *photoContainer;

@property (nonatomic, strong) NSMutableArray *photoViewArray;
@property (nonatomic, strong) UIView *verticalLine;

@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UILabel *photoNumLabel;

@property (nonatomic, strong) FLUserData *userData;


@end
