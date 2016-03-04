//
//  DotView.m
//  TouchDemo
//
//  Created by KudoCC on 15/9/13.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "DotView.h"
#import <mach/time_value.h>
#import "UIColor+Util.h"

@interface DotView ()

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL highlighted;

@end

@implementation DotView

+ (instancetype)randomDotView {
    CGFloat minWidth = 12.0;
    CGFloat maxWidth = 60.0;
    CGFloat width = arc4random_uniform(maxWidth-minWidth);
    width += minWidth;
    
    DotView *v = [[DotView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, width)];
    uint32_t r = arc4random_uniform(255);
    uint32_t g = arc4random_uniform(255);
    uint32_t b = arc4random_uniform(255);
    v.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    v.color = v.backgroundColor;
    v.layer.cornerRadius = width/2;
    v.layer.masksToBounds = YES;
    return v;
}

+ (void)arrangeDotsRandomlyInView:(UIView *)view {
    CGSize size = view.bounds.size;
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[DotView class]]) {
            CGFloat width = subview.bounds.size.width;
            CGFloat x = arc4random_uniform(size.width-width);
            CGFloat y = arc4random_uniform(size.height-width);
            subview.frame = CGRectMake(x, y, width, width);
        }
    }
}

+ (void)arrangeDotsNeatlyInView:(UIView *)view {
    CGSize size = view.bounds.size;
    
    CGFloat padding = 10.0;
    CGFloat x = padding;
    CGFloat y = padding;
    CGFloat maxHeight = 0.0;
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger i = 0; i < [view.subviews count]; ++i) {
        UIView *subview = view.subviews[i];
        if (![subview isKindOfClass:[DotView class]]) {
            continue;
        }
        [mArray addObject:subview];
        if (maxHeight < subview.bounds.size.height) {
            maxHeight = subview.bounds.size.height;
        }
        x += padding + subview.bounds.size.width;
        
        UIView *nextDotView = nil;
        for (NSInteger j = i+1; j < [view.subviews count]; ++j) {
            UIView *tmpView = view.subviews[j];
            if ([tmpView isKindOfClass:[DotView class]]) {
                nextDotView = tmpView;
                break;
            }
        }
        BOOL handleThisLine = nextDotView == nil;
        if (nextDotView) {
            CGFloat widthNextView = nextDotView.bounds.size.width;
            if (x + widthNextView + padding > size.width) {
                handleThisLine = YES;
            }
        }
        if (handleThisLine) {
            x = padding;
            // adjust the y pos
            CGFloat centerY = y + maxHeight/2;
            for (UIView *sView in mArray) {
                sView.frame = CGRectMake(x,
                                         centerY-sView.bounds.size.height/2,
                                         sView.bounds.size.width,
                                         sView.bounds.size.height);
                x += sView.bounds.size.width + padding;
            }
            [mArray removeAllObjects];
            x = padding;
            y += maxHeight + padding;
            maxHeight = 0;
        }
    }
}

+ (void)arrangeDotsNeatlyWithAnimationInView:(UIView *)view {
    [UIView animateWithDuration:0.2 animations:^{
        [self arrangeDotsNeatlyInView:view];
    }];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect touchBounds = self.bounds;
    if (self.bounds.size.width/2 < 22.0) {
        CGFloat extend = 22.0 - self.bounds.size.width;
        touchBounds = CGRectInset(touchBounds, -extend, -extend);
    }
    return CGRectContainsPoint(touchBounds, point);
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    if (_highlighted) {
        self.backgroundColor = [_color darkerColorWithFactor:0.5];
    } else {
        self.backgroundColor = _color;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

@end
