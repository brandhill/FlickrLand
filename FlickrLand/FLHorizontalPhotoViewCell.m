//
//  FLHorizontalPhotoViewCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLHorizontalPhotoViewCell.h"

@implementation FLHorizontalPhotoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width -4, self.frame.size.height -4)];
        [_photoImageView setBackgroundColor:[UIColor colorWithWhite:245/255.0f alpha:1]];
        [_photoImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_photoImageView setClipsToBounds:YES];
        [self addSubview:_photoImageView];
        
        [[FLFavoriteEditor sharedEditor] addEditorToView:self];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    [_photoImageView setFrame:CGRectMake(2, 2, self.frame.size.width -4, self.frame.size.height -4)];
}

- (NSString *)photoIDForCurrentItem {
    
    return _photoID;
}

@end
