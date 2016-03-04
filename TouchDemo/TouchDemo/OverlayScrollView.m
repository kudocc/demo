//
//  OverlayScrollView.m
//  TouchDemo
//
//  Created by KudoCC on 15/9/13.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "OverlayScrollView.h"

@implementation OverlayScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if (hitTestView == self) {
        return nil;
    }
    return hitTestView;
}

@end
