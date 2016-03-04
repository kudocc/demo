//
//  TestView.m
//  performance
//
//  Created by KudoCC on 16/1/22.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "TestView.h"

@implementation TestView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, self.bounds);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5.0];
    [path addClip];
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillRect(context, self.bounds);
}

@end
