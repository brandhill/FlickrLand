//
//  FLGalleryCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLFavoriteEditor.h"


@interface FLGalleryCell : UICollectionViewCell<FLFavoriteEditorDelegate> {
    
}
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, readwrite) BOOL isAddEnable;
@property (nonatomic, strong) NSString *photoID;

@end
