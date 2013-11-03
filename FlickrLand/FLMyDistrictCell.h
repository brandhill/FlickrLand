//
//  FLMyDistrictCell.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@class FLMyDistrictCell;
@protocol FLMyDistrictCellDelegate <NSObject>
@optional
- (void)districtCell:(FLMyDistrictCell *)cell didSelectedDistrictAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FLMyDistrictCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id<FLMyDistrictCellDelegate> delegate;
@property (nonatomic, strong) NSArray *districtDataArray;
@end
