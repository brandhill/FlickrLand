//
//  FLDistrictCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLDistrictCell.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"

@implementation FLDistrictCell

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
        
        _districtLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 210, 30)];
        [_districtLabel setText:@"District Name"];
        [_districtLabel setTextColor:[UIColor whiteColor]];
        [_districtLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_containerView addSubview:_districtLabel];
        
        _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(150, 215, 12, 12)];
        [_photoIcon setImage:[UIImage imageNamed:@"cell_imageIcon"]];
        [self addSubview:_photoIcon];
        
        _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 211, 80, 20)];
        [_photoNumLabel setText:@"0 Photos"];
        [_photoNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [_photoNumLabel setFont:[UIFont systemFontOfSize:10]];
        [self addSubview:_photoNumLabel];
        
        _starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(240, 215, 12, 12)];
        [_starIcon setImage:[UIImage imageNamed:@"cell_starIcon"]];
        [self addSubview:_starIcon];
        
        _starNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 211, 80, 20)];
        [_starNumLabel setText:@"0 Stars"];
        [_starNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [_starNumLabel setFont:[UIFont systemFontOfSize:10]];
        [self addSubview:_starNumLabel];
        
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
            [photoImageView setImageWithURL:[NSURL URLWithString:@"http://www.camping-simuni.hr/datastore/imagestore/original/1360675095golden_beach.jpg"]];
            [photoContainerView addSubview:photoImageView];
            [_photoViewArray addObject:photoImageView];
        }
    }
    return self;
}

- (void)setDistrictData:(FLDistrictData *)districtData {
    
    _districtData = districtData;
    NSArray *photoArray = [_districtData.photos allObjects];
    
    int index = 0;
    for (UIImageView *photoImageView in _photoViewArray) {
        
        FLPhotoData *photoData = photoArray[index%[photoArray count]];
        index ++;
        
        [photoImageView setImage:nil];
        [photoImageView setImageWithURL:[NSURL URLWithString:photoData.sourceM]];
    }
    
    [_districtLabel setText:_districtData.districtName];
    
    //Set Profile
    FLUserData *holder = [[FLDataSource sharedDataSource] getHolderInDistrict:_districtData];
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", holder.facebookID];
    NSURL *profileUrl = [NSURL URLWithString:urlString];
    [_profileImageView setImageWithURL:profileUrl];
    
    int starNum = 0;
    for (FLPhotoData *photoData in photoArray) {
        starNum += [photoData.favoriteNum intValue];
    }
    
    [_photoNumLabel setText:[NSString stringWithFormat:@"%i Photos", [photoArray count]]];
    [_starNumLabel setText:[NSString stringWithFormat:@"%i Stars", starNum]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

@end
