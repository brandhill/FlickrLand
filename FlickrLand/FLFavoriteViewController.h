//
//  FLFavoriteViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLFavoriteViewController : UIViewController<UIWebViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) IBOutlet UIWebView *authWebView;
@property (nonatomic, strong) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) NSMutableArray *photoURLArray;

@end
