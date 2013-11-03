//
//  FLGalleryCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLGalleryCell.h"
#import "UIImageView+AFNetworking.h"

@implementation FLGalleryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5f]];
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 236, 156)];
        [_photoImageView setBackgroundColor:[UIColor colorWithWhite:240/255.0f alpha:1]];
        [_photoImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_photoImageView setClipsToBounds:YES];
        [self addSubview:_photoImageView];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView setCenter:CGPointMake(_photoImageView.frame.size.width/2.0f, _photoImageView.frame.size.height/2.0f)];
        [_indicatorView setHidesWhenStopped:YES];
        [_photoImageView addSubview:_indicatorView];
    }
    return self;
}

- (void)setPhotoUrl:(NSURL *)photoUrl {
    
    __weak UIImageView *photoViewPointer = _photoImageView;
    __weak UIActivityIndicatorView *indicatorPointer = _indicatorView;
    
    [_indicatorView startAnimating];
    [_photoImageView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.15f]];
    [_photoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:photoUrl] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        [photoViewPointer setImage:image];
        [indicatorPointer stopAnimating];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
}

- (void)setIsAddEnable:(BOOL)isAddEnable {
    
    if (_isAddEnable == isAddEnable) return;
    
    _isAddEnable = isAddEnable;
    if (_isAddEnable) {
        [[FLFavoriteEditor sharedEditor] addEditorToView:self];
    }
}

- (NSString *)photoIDForCurrentItem {
    
    return _photoID;
}

@end
