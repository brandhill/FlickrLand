//
//  FLFavoriteEditor.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTapIndicatorView.h"
#import "FLStarView.h"

@protocol FLFavoriteEditorDelegate <NSObject>
@optional
- (NSString *)photoIDForCurrentItem;

@end


@interface FLFavoriteEditor : NSObject <UIGestureRecognizerDelegate> {
    
    double originLength;
}
//UI
@property (nonatomic, strong) UIViewController *rootView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) FLTapIndicatorView *tapIndicator;
@property (nonatomic, strong) FLStarView *starView;

//Data
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressedGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

+ (FLFavoriteEditor *) sharedEditor;
- (void)addEditorToView:(UIView *)view;

@end
