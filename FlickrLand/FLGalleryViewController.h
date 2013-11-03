//
//  FLGalleryViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLUserData.h"

@interface FLGalleryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    int index;
}
@property (nonatomic, strong) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic, strong) FLUserData *userData;

@end
