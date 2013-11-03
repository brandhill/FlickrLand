//
//  FLTaiwanGraphView.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLTaiwanGraphViewDelegate <NSObject>

@optional
- (void)didSelectAtIndex:(int)index;

@end

__unused static NSString *FLGraphKeyXArray = @"x";
__unused static NSString *FLGraphKeyYArray = @"y";
__unused static NSString *FLGraphKeyColor = @"color";

@interface FLTaiwanGraphView : UIView {
    
    BOOL isMoved;
}
@property (nonatomic, strong) NSArray *graphDataArray;
@property (nonatomic, readwrite) int selectedIndex;
@property (nonatomic, weak) id<FLTaiwanGraphViewDelegate> delegate;

- (id)initWithPosition:(CGPoint)position;

@end