//
//  FLLeftAlignFlowLayout.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLLeftAlignFlowLayout.h"

const NSInteger kMaxCellSpacing = 6;

@implementation FLLeftAlignFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset];
    
    if (indexPath.item == 0) { // first item of section
        CGRect frame = currentItemAttributes.frame;
        frame.origin.x = sectionInset.left; // first item of the section should always be left aligned
        currentItemAttributes.frame = frame;
        
        return currentItemAttributes;
    }
    
    if (indexPath.item < 3) {
        
        currentItemAttributes.frame = (CGRect){
            self.sectionInset.left,
            self.sectionInset.top +(self.itemSize.height +self.minimumLineSpacing)*indexPath.item,
            currentItemAttributes.frame.size};
    }
    else {
        
        int maxVerticleItemNum = self.collectionViewContentSize.height/currentItemAttributes.frame.size.height;
        
        currentItemAttributes.frame = (CGRect){
            self.sectionInset.left +(int)(indexPath.item/3)*(self.itemSize.width +self.minimumInteritemSpacing) -((indexPath.item%maxVerticleItemNum)%2)*(self.itemSize.width/2),
            self.sectionInset.top +(self.itemSize.height +self.minimumLineSpacing)*(indexPath.item%3),
            currentItemAttributes.frame.size};
    }
    
    return currentItemAttributes;
}


@end
