//
//  FLTaiwanGraphView.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLTaiwanGraphView.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"

@implementation FLTaiwanGraphView

- (id)initWithPosition:(CGPoint)position {
    
    self = [self initWithFrame:(CGRect){position, 203, 380}];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _selectedIndex = 0;
        
        NSString *jsonString = [FLDataSource readStringFromFile:@"FL Taiwan Graph" type:@"txt"];
        self.graphDataArray = [FLDataSource jsonObjectFromString:jsonString];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapEvent:)];
        tapGesture.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setGraphDataArray:(NSArray *)graphDataArray {
    
    _graphDataArray = graphDataArray;
    [self setNeedsDisplay];
}

- (void)setSelectedIndex:(int)selectedIndex {
    
    _selectedIndex = selectedIndex;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int index =0; index < [_graphDataArray count]; index ++) {
        
        NSDictionary *data = _graphDataArray[index];
        
        CGContextBeginPath(context);
        NSArray *XArray = data[FLGraphKeyXArray];
        NSArray *YArray = data[FLGraphKeyYArray];
        for (int index =0; index < [XArray count]; index++) {
            
            double x = [XArray[index] doubleValue];
            double y = [YArray[index] doubleValue];
            
            if (index == 0) {
                CGContextMoveToPoint(context, x, y);
            }
            else {
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextClosePath(context);
        
        //Fill Color
        FLAppColor color =  FLAppColorCountryColorLevel0;
        switch ([data[FLGraphKeyColor] intValue]) {
            case 1: color = FLAppColorCountryColorLevel1;
                break;
            case 2: color = FLAppColorCountryColorLevel2;
                break;
            case 3: color = FLAppColorCountryColorLevel3;
                break;
            default: color =  FLAppColorCountryColorLevel0;
                break;
        }
        
        if (index == _selectedIndex) {
            color = FLAppColorCountryColorSelected;
        }
        
        CGContextSetFillColorWithColor(context, [[UIColor colorWithAppColor:color] CGColor]);
        CGContextFillPath(context);
    }
}

- (void)handleTapEvent:(UITapGestureRecognizer *)sender {
    
    CGPoint position = [sender locationInView:self];
    
    //NSLog(@"x: %f, y: %f", position.x, position.y);
    
    for (int index =0; index < [_graphDataArray count]; index ++) {
        
        NSDictionary *data = _graphDataArray[index];
        NSArray *XArray = data[FLGraphKeyXArray];
        NSArray *YArray = data[FLGraphKeyYArray];
        
        if ([self isTouchPosition:position insideOfPathXArray:XArray YArray:YArray]) {
            
            if ([_delegate respondsToSelector:@selector(didSelectAtIndex:)]) {
                [_delegate didSelectAtIndex:index];
                break;
            }
        }
    }
}

- (BOOL)isTouchPosition:(CGPoint)position insideOfPathXArray:(NSArray *)XArray YArray:(NSArray *)YArray {
    
    int crossNum = 0;
    
    for (int index =0; index < [XArray count] -1; index++) {
        
        CGPoint point1 = CGPointMake([XArray[index] doubleValue], [YArray[index] doubleValue]);
        CGPoint point2 = CGPointMake([XArray[index +1] doubleValue], [YArray[index +1] doubleValue]);
        
        if (point1.y == point2.y) {
            continue;
        }
        
        if (position.y < MIN(point1.y, point2.y)) {
            continue;
        }
        
        if (position.y >= MAX(point1.y, point2.y)) {
            continue;
        }
        
        double crossX = (position.y - point1.y) * (point2.x - point1.x) / (point2.y - point1.y) + point1.x;
        
        if (crossX > position.x) {
            crossNum ++;
        }
    }
    return crossNum % 2;
}


@end
