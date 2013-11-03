//
//  FLHorizontalPhotoView.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLHorizontalPhotoView.h"
#import "FLHorizontalPhotoViewCell.h"
#import "FLPhotoData.h"
#import "UIImageView+AFNetworking.h"


static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@implementation FLHorizontalPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        landscapeflowLayout = [[UICollectionViewFlowLayout alloc] init];
        [landscapeflowLayout setItemSize:CGSizeMake(170, 170)];
        [landscapeflowLayout setMinimumLineSpacing:10];
        [landscapeflowLayout setMinimumInteritemSpacing:10];
        [landscapeflowLayout setSectionInset:UIEdgeInsetsMake(0, 15, 10, 15)];
        [landscapeflowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:landscapeflowLayout];
        [_photoCollectionView setBackgroundColor:[UIColor clearColor]];
        [_photoCollectionView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        [_photoCollectionView setDataSource:self];
        [_photoCollectionView setDelegate:self];
        [_photoCollectionView registerClass:[FLHorizontalPhotoViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
        [self addSubview:_photoCollectionView];
    }
    return self;
}


#pragma mark - Setter

- (void)setPhotoDataArray:(NSArray *)photoDataArray {
    
    _photoDataArray = photoDataArray;
    
    [_photoCollectionView reloadData];
}


#pragma mark - Collection View Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_photoDataArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FLHorizontalPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    FLPhotoData *photoData = _photoDataArray[indexPath.row];
    
    NSURL *photoUrl = [NSURL URLWithString:photoData.sourceM];
    [cell.photoImageView setImageWithURL:photoUrl];
    [cell setPhotoID:photoData.photoID];
    
    return cell;
}


#pragma mark - Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(photoView:didSelectAtIndex:)]) {
        [self.delegate photoView:self didSelectAtIndex:indexPath.row];
    }
}

@end
