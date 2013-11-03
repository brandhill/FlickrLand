//
//  FLPhotoCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLPhotoCell.h"
#import "UIImageView+AFNetworking.h"

@implementation FLPhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            
            [self setBackgroundColor:[UIColor clearColor]];
            [[FLFavoriteEditor sharedEditor] addEditorToView:self];
            
            _photoBorderView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 310, 206)];
            [_photoBorderView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.25f]];
            [self addSubview:_photoBorderView];
            
            
            _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 306, 202)];
            [_photoView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.15f]];
            [_photoView setContentMode:UIViewContentModeScaleAspectFill];
            [_photoView setClipsToBounds:YES];
            [_photoBorderView addSubview:_photoView];
            
            _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [_indicatorView setCenter:CGPointMake(_photoBorderView.frame.size.width/2.0f, _photoBorderView.frame.size.height/2.0f)];
            [_indicatorView setHidesWhenStopped:YES];
            [_photoBorderView addSubview:_indicatorView];
        }
        return self;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPhotoURL:(NSURL *)photoURL {
    
    __weak UIImageView *photoViewPointer = _photoView;
    __weak UIActivityIndicatorView *indicatorPointer = _indicatorView;
    
    [_indicatorView startAnimating];
    [_photoView setImageWithURLRequest:[NSURLRequest requestWithURL:photoURL] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        [photoViewPointer setImage:image];
        [indicatorPointer stopAnimating];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
}

#pragma mark - Favorite Delegate
- (NSString *)photoIDForCurrentItem {
    
    return _photoID;
}

@end
