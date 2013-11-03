//
//  FLAchievementViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLAchievementViewController.h"
#import "FLAppTheme.h"

@interface FLAchievementViewController ()

@end

@implementation FLAchievementViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [FLAppTheme backButtonForViewController:self];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:(CGRectMake(0 ,64,320,504))];
    [view setContentSize:view.frame.size];
    [view setAlwaysBounceVertical:YES];
    [self.view addSubview:view];
    
    NSMutableArray *iconArray = [[NSMutableArray alloc] init];
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    NSMutableArray *subTitleArray = [[NSMutableArray alloc] init];
    
    UIView *lastBar = nil;
    
    for(NSInteger i=0;i<5;i++)
    {
        
        UIView *bar =[[UIView alloc] initWithFrame:((CGRectMake(60, 95+i*95, 1, 25)))];
        [bar setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5f]];
        [view addSubview:bar];
        lastBar = bar;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:(CGRectMake(30,95*i +30,60,60))];
        [icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"city_level%i", i]]];
        [iconArray addObject:icon];
        
        UILabel *title = [[UILabel alloc] initWithFrame:((CGRectMake(110, 39+i*95, 180, 30)))];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextColor:[UIColor whiteColor]];
        [title setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:34.0f]];
        [titleArray addObject:title];
        
        UILabel *subTitle = [[UILabel alloc] initWithFrame:(CGRectMake(110, 72+i*95, 180, 15))];
        [subTitle setText:@"subTitle"];
        [subTitle setTextColor:[UIColor colorWithWhite:1 alpha:0.75]];
        [subTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
        [subTitleArray addObject:subTitle];
    }
    [lastBar setFrameSize:CGSizeMake(1, 568)];
    
    [[titleArray objectAtIndex:0] setText:@"Novice"];
    [[titleArray objectAtIndex:1] setText:@"Senior"];
    [[titleArray objectAtIndex:2] setText:@"Expert"];
    [[titleArray objectAtIndex:3] setText:@"Master"];
    [[titleArray objectAtIndex:4] setText:@"Super Star"];
    
    [[subTitleArray objectAtIndex:0] setText:@"Total 0 Photos in the city."];
    [[subTitleArray objectAtIndex:1] setText:@"Total 10 Photos in the city."];
    [[subTitleArray objectAtIndex:2] setText:@"Total 50 Photos in the city."];
    [[subTitleArray objectAtIndex:3] setText:@"Total 100 Photos in the city."];
    [[subTitleArray objectAtIndex:4] setText:@"Total 250 Photos in the city."];
    
    
    
    
    for(NSInteger i=0;i<5;i++){
        
        [view addSubview:[subTitleArray objectAtIndex:i]];
        [view addSubview:[titleArray objectAtIndex:i]];
        [view addSubview:[iconArray objectAtIndex:i]];
    }}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
