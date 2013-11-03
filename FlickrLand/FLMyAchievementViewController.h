//
//  FLMyAchievementViewController.h
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLMyAchievementViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
}
@property (nonatomic, strong) IBOutlet UIButton *beginnerbutton;
@property (nonatomic, strong) IBOutlet UIButton *citybutton;
@property (nonatomic, strong) IBOutlet UIButton *culturebutton;
@property (nonatomic, strong) IBOutlet UITableView *contentTableView;

@property (nonatomic, strong) NSArray *beginnerDataArray;
@property (nonatomic, strong) NSArray *cityDataArray;
@property (nonatomic, strong) NSArray *cultureDataArray;
@property (nonatomic, strong) NSArray *contentArray;

- (IBAction)beginnerButton_touchUpInside:(UIButton *)sender;
- (IBAction)citybutton_touchUpInside:(UIButton *)sender;
- (IBAction)culturebutton_touchUpInside:(UIButton *)sender;

@end
