//
//  FLMyDistrictCell.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLMyDistrictCell.h"
#import "FLDistrictCardCell.h"
#import "FLPhotoData.h"
#import "FLDistrictData.h"

@implementation FLMyDistrictCell

static NSString *cellReuseIdentifier = @"cell";

+ (CGFloat)height {
    
    return 230;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 16, 285, 34)];
        [_cityNameLabel setText:@"城市"];
        [_cityNameLabel setBackgroundColor:[UIColor clearColor]];
        [_cityNameLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [_cityNameLabel setFont:[UIFont systemFontOfSize:19.0f]];
        [self addSubview:_cityNameLabel];
        
        _separator = [[UIView alloc] initWithFrame:CGRectMake(35, 50, 285, 0.5f)];
        [_separator setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75f]];
        [self addSubview:_separator];
        
        
        //Collection View
        UICollectionViewFlowLayout *landscapeflowLayout = [[UICollectionViewFlowLayout alloc] init];
        [landscapeflowLayout setItemSize:[FLDistrictCardCell size]];
        [landscapeflowLayout setMinimumLineSpacing:10];
        [landscapeflowLayout setSectionInset:UIEdgeInsetsMake(10, 35, 10, 10)];
        [landscapeflowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, 320, 180) collectionViewLayout:landscapeflowLayout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView registerClass:[FLDistrictCardCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
        [self addSubview:_collectionView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setDistrictDataArray:(NSArray *)districtDataArray {
    
    _districtDataArray = districtDataArray;
    [_collectionView reloadData];
}


#pragma mark - Collection View Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_districtDataArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FLDistrictCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    FLDistrictData *districtData = _districtDataArray[indexPath.item];
    
    NSArray *photoDataArray = [[districtData photos] allObjects];
    FLPhotoData *photoData = photoDataArray[0];
    
    NSURL *photoURL = [NSURL URLWithString:photoData.sourceM];
    [cell.photoView setImageWithURL:photoURL];
    
    [cell.cityNameLabel setText:districtData.districtName];
    [cell.photoNumLabel setText:[NSString stringWithFormat:@"%i Photos", [photoDataArray count]]];
    
    return cell;
}


#pragma mark - Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_delegate respondsToSelector:@selector(districtCell:didSelectedDistrictAtIndexPath:)]) {
        [_delegate districtCell:self didSelectedDistrictAtIndexPath:indexPath];
    }
}


@end
