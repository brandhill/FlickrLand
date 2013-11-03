//
//  FLPlaceCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLPlaceCell.h"
#import "FLAppTheme.h"
#import "UIImageView+AFNetworking.h"

@implementation FLPlaceCell

+(CGFloat)height {
    
    return 220;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIImage *containerBackground = [UIImage imageWithSize:CGSizeMake(290, 205) Color:[UIColor colorWithWhite:1 alpha:0.15f] radius:3.0f];
        _containerView = [[UIImageView alloc] initWithImage:containerBackground];
        [_containerView setFrameOrigin:CGPointMake(15, 10)];
        [self addSubview:_containerView];
        
        _photoViewContainer = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 280, 170)];
        [_photoViewContainer setBackgroundColor:[UIColor whiteColor]];
        [_containerView addSubview:_photoViewContainer];
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 276, 166)];
        //[_photoImageView setBackgroundColor:[UIColor colorWithWhite:247/255.0f alpha:1]];
        [_photoImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_photoImageView setClipsToBounds:YES];
        [_photoViewContainer addSubview:_photoImageView];
        
        _placeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 175, 150, 30)];
        [_placeNameLabel setText:@"城市名"];
        [_placeNameLabel setBackgroundColor:[UIColor clearColor]];
        [_placeNameLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [_placeNameLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_containerView addSubview:_placeNameLabel];
        
        _photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(190, 180 +4, 12, 12)];
        [_photoIcon setImage:[UIImage imageNamed:@"cell_imageIcon"]];
        [_containerView addSubview:_photoIcon];
        
        _photoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 180, 80, 20)];
        [_photoNumLabel setText:@"0 Photos"];
        [_photoNumLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [_photoNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_containerView addSubview:_photoNumLabel];
        
        _disclosureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_disclosure-small"]];
        [_disclosureImageView setFrameOrigin:CGPointMake(290 -15, 180)];
        [_containerView addSubview:_disclosureImageView];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView setCenter:CGPointMake(_photoViewContainer.frame.size.width/2.0f, _photoViewContainer.frame.size.height/2.0f)];
        [_indicatorView setHidesWhenStopped:YES];
        [_photoViewContainer addSubview:_indicatorView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPhotoUrl:(NSURL *)photoUrl {
    
    __weak UIImageView *photoViewPointer = _photoImageView;
    __weak UIActivityIndicatorView *indicatorPointer = _indicatorView;
    __weak UIView *photoViewContainerPointer = _photoViewContainer;
    
    [_indicatorView startAnimating];
    [_photoViewContainer setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.15f]];
    [_photoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:photoUrl] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        [photoViewPointer setImage:image];
        [indicatorPointer stopAnimating];
        [photoViewContainerPointer setBackgroundColor:[UIColor whiteColor]];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
}

@end
