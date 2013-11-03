//
//  FLFavoriteEditor.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLFavoriteEditor.h"
#import "FLAppTheme.h"
#import "FlickrKit.h"


@implementation FLFavoriteEditor

+ (FLFavoriteEditor *) sharedEditor {
    static dispatch_once_t onceToken;
    static FLFavoriteEditor *sharedEditor;
    dispatch_once(&onceToken, ^{
        sharedEditor = [[self alloc] init];
    });
    
    return sharedEditor;
}

- (void)addEditorToView:(UIView *)view {
    
    //Gesture
    _longPressedGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewLongPress:)];
    [_longPressedGesture setDelegate:self];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewPanning:)];
    [_panGesture setDelegate:self];
    
    [view addGestureRecognizer:_longPressedGesture];
    [view addGestureRecognizer:_panGesture];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        _rootView = [UIApplication rootViewController];
        _maskView = [[UIView alloc] initWithFrame:_rootView.view.frame];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35f];
        _maskView.userInteractionEnabled = NO;
        _maskView.hidden = YES;
        [_rootView.view addSubview:_maskView];
        
        _tapIndicator = [[FLTapIndicatorView alloc] initWithCenter:_maskView.center];
        [_tapIndicator show];
        [_maskView addSubview:_tapIndicator];
        
        _starView = [[FLStarView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
        _starView.center = CGPointMake(_maskView.frame.size.width/2.0f, _maskView.frame.size.height/2.0f);
        [_maskView addSubview:_starView];
    }
    return self;
}


#pragma mark - UI Events
- (IBAction)handleViewLongPress:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        _delegate = sender.view;
        
        
        CGPoint touchCoord   = [sender locationInView:_rootView.view];
        
        //Reset self to top of the root view
        [_rootView.view bringSubviewToFront:_maskView];
        
        
        //Setup UI
        originLength = [self distanceFromPoint:touchCoord toPoint:_starView.center];
        
        _maskView.userInteractionEnabled = YES;
        _maskView.hidden = NO;
        _maskView.alpha = 0;
        _tapIndicator.targetPoint = _maskView.center;
        _tapIndicator.center = touchCoord;
        _starView.progress = 0;
        _starView.isInCircle = NO;
        
        [_tapIndicator show];
        [_starView show];
        [UIView animateWithDuration:0.35f animations:^{
            _maskView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
                _tapIndicator.center = touchCoord;
            }];
        }];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        
        if (_starView.isInCircle) {
            [_starView playStarAnimation];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                
                NSString *photoID = @"";
                if ([_delegate respondsToSelector:@selector(photoIDForCurrentItem)]) {
                    photoID = [_delegate photoIDForCurrentItem];
                }
                [self addToFavoriteWithPhotoID:photoID];
            });
        }
        [self endAnimation];
    }
}
- (IBAction)handleViewPanning:(UIPanGestureRecognizer *)sender {
    
    if (_maskView.userInteractionEnabled == NO) return;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
    else {
        CGPoint transCoor = [sender translationInView:_rootView.view];
        [_tapIndicator setCenter:CGPointMake(_tapIndicator.center.x +transCoor.x, _tapIndicator.center.y +transCoor.y)];
        [sender setTranslation:CGPointMake(0, 0) inView:_rootView.view];
        
        double distance = [self distanceFromPoint:_starView.center toPoint:_tapIndicator.center];
        double progress = (originLength -distance)/(originLength -10);
        progress = progress <= 0 ? 0 : progress;
        [_starView setProgress:progress];
        _starView.isInCircle = distance < 50 ? YES : NO;
    }
}
- (void)endAnimation {
    
    _maskView.userInteractionEnabled = NO;
    
    [_tapIndicator hide];
    [UIView animateWithDuration:0.35f animations:^{
        _maskView.alpha = 0;
    } completion:^(BOOL finished) {
        _maskView.hidden = YES;
    }];
}
- (double)distanceFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint {
    
    return sqrt(pow((startPoint.x -endPoint.x), 2) +pow((startPoint.y -endPoint.y), 2));
}


#pragma mark - Gesture Recognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
    
    if (_maskView.userInteractionEnabled == NO) {
        return YES;
    }
    
    return [gestureRecognizer.view isEqual:otherGestureRecognizer.view];
}

- (void)addToFavoriteWithPhotoID:(NSString *)photoID {
    
    if ([[FlickrKit sharedFlickrKit] isAuthorized]) {
        [[FlickrKit sharedFlickrKit] call:@"flickr.favorites.add" args:@{@"photo_id":photoID} maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
            
            NSLog(@"%@",response);
        }];
    }
}

@end
