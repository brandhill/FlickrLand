//
//  FLFriendsPhotoViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLFriendsPhotoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) IBOutlet UITableView *contentTableView;

@property (nonatomic, strong) NSArray *friendsDataArray;

@end
