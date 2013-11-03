//
//  FLFriendsPhotoCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLFriendsPhotoCell.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "UIImageView+AFNetworking.h"
#import "FLPhotoData.h"

@implementation FLFriendsPhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIImage *profileBorderImage = [UIImage imageWithSize:CGSizeMake(44, 44) Color:[UIColor colorWithWhite:1 alpha:0.75f] radius:22];
        _profileBorderView = [[UIImageView alloc] initWithImage:profileBorderImage];
        [_profileBorderView setFrameOrigin:CGPointMake(15, 0)];
        [self addSubview:_profileBorderView];
        
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
        [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
        [_profileImageView.layer setCornerRadius:20.0f];
        [_profileImageView.layer setMasksToBounds:YES];
        [_profileBorderView addSubview:_profileImageView];
        
        _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(37, 49, 1, 196)];
        [_verticalLine setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75f]];
        [self addSubview:_verticalLine];
        
        _containerView = [[UIImageView alloc] initWithImage:[UIImage imageWithSize:CGSizeMake(230, 210) Color:[UIColor colorWithWhite:1 alpha:0.15f] radius:2]];
        [_containerView setFrameOrigin:CGPointMake(75, 0)];
        [self addSubview:_containerView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 210, 30)];
        [_nameLabel setText:@"District Name"];
        [_nameLabel setTextColor:[UIColor whiteColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_containerView addSubview:_nameLabel];
        
        _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(225, 215, 12, 12)];
        [_photoIcon setImage:[UIImage imageNamed:@"cell_imageIcon"]];
        [self addSubview:_photoIcon];
        
        _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 211, 90, 20)];
        [_photoNumLabel setText:@"0 Photos"];
        [_photoNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [_photoNumLabel setFont:[UIFont systemFontOfSize:10]];
        [self addSubview:_photoNumLabel];
        
        _photoContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 235, 170)];
        [_photoContainer setBackgroundColor:[UIColor clearColor]];
        [_containerView addSubview:_photoContainer];
        
        _photoViewArray = [NSMutableArray array];
        for (int i =0; i <3; i++) {
            UIView *photoContainerView = [[UIView alloc] initWithFrame:CGRectMake(20*i, 0, 170, 170)];
            [photoContainerView setBackgroundColor:[UIColor whiteColor]];
            [_photoContainer addSubview:photoContainerView];
            
            UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 166, 166)];
            [photoImageView setBackgroundColor:[UIColor colorWithWhite:245/255.0f alpha:1]];
            [photoImageView setContentMode:UIViewContentModeScaleAspectFill];
            [photoImageView setClipsToBounds:YES];
            [photoContainerView addSubview:photoImageView];
            [_photoViewArray addObject:photoImageView];
        }
    }
    return self;
}

- (void)setUserData:(FLUserData *)userData {
    
    _userData = userData;
    NSArray *photoArray = [userData.photos allObjects];
    
    if ([photoArray count] > 0) {
        int index = 0;
        for (UIImageView *photoImageView in _photoViewArray) {
            
            FLPhotoData *photoData = photoArray[index%[photoArray count]];
            index ++;
            
            [photoImageView setImage:nil];
            [photoImageView setImageWithURL:[NSURL URLWithString:photoData.sourceM]];
        }
    }
    
    
    [_nameLabel setText:userData.facebookName];
    
    //Set Profile
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", userData.facebookID];
    NSURL *profileUrl = [NSURL URLWithString:urlString];
    [_profileImageView setImageWithURL:profileUrl];
    
    int starNum = 0;
    for (FLPhotoData *photoData in photoArray) {
        starNum += [photoData.favoriteNum intValue];
    }
    
    [_photoNumLabel setText:[NSString stringWithFormat:@"%i Photos", [photoArray count]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

@end
