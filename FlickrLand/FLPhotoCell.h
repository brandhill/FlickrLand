//
//  FLPhotoCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLFavoriteEditor.h"

@interface FLPhotoCell : UITableViewCell<FLFavoriteEditorDelegate> {
    
}
@property (nonatomic, strong) UIView *photoBorderView;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSString *photoID;

@end
