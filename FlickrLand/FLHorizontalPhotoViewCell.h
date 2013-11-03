//
//  FLHorizontalPhotoViewCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLFavoriteEditor.h"

@interface FLHorizontalPhotoViewCell : UICollectionViewCell<FLFavoriteEditorDelegate> {
    
}
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) NSString *photoID;

@end
