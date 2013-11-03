//
//  FLHorizontalPhotoView.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLHorizontalPhotoView;
@protocol FLHorizontalPhotoViewDelegate <NSObject>
@optional
- (void)photoView:(FLHorizontalPhotoView *)photoView didSelectAtIndex:(int)index;

@end

@interface FLHorizontalPhotoView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate> {
    
    UICollectionViewFlowLayout *landscapeflowLayout;
}
//UI
@property (nonatomic, strong) UICollectionView *photoCollectionView;

//Data
@property (nonatomic, weak) id<FLHorizontalPhotoViewDelegate> delegate;
@property (nonatomic, strong) NSArray *photoDataArray;
@property (nonatomic, strong) NSArray *districtDataArray;

@end
