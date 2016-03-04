//
//  ViewController.m
//  TouchDemo
//
//  Created by KudoCC on 15/9/13.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "DotView.h"
#import "OverlayScrollView.h"
#import "TouchDelayGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIView *_canvasView;
    UIScrollView *_scrollView;
    UIVisualEffectView *_drawerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect bounds = self.view.bounds;
    
    _canvasView = [[UIView alloc] initWithFrame:bounds];
    _canvasView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_canvasView];
    
    TouchDelayGestureRecognizer *gesture = [[TouchDelayGestureRecognizer alloc] initWithTarget:nil action:nil];
    [_canvasView addGestureRecognizer:gesture];
    
    [self addDots:25 toView:_canvasView];
    [DotView arrangeDotsRandomlyInView:_canvasView];
    
    _scrollView = [[OverlayScrollView alloc] initWithFrame:bounds];
    [self.view addSubview:_scrollView];
    
    _drawerView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    _drawerView.frame = CGRectMake(0.0, 0.0, bounds.size.width, 460.0);
    [_scrollView addSubview:_drawerView];
    
    [self addDots:20 toView:_drawerView];
    [DotView arrangeDotsNeatlyInView:_drawerView];
    
    _scrollView.contentSize = CGSizeMake(bounds.size.width, bounds.size.height + _drawerView.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(0.0, _drawerView.frame.size.height);
    [self.view addGestureRecognizer:_scrollView.panGestureRecognizer];
}

- (void)addDots:(NSInteger)count toView:(UIView *)view {
    for (NSUInteger i = 0; i < count; ++i) {
        DotView *v = [DotView randomDotView];
        [view addSubview:v];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handleLongPress:)];
        longPress.cancelsTouchesInView = NO;
        [v addGestureRecognizer:longPress];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    UIView *dot = gesture.view;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self grapDot:dot withGesture:gesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self moveDot:dot withGesture:gesture];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            [self dropDot:dot withGesture:gesture];
            break;
        default:
            break;
    }
}

- (void)grapDot:(UIView *)dot withGesture:(UIGestureRecognizer *)gesture {
    dot.center = [dot.superview convertPoint:dot.center toView:self.view];
    [self.view addSubview:dot];
    
    [UIView animateWithDuration:0.2 animations:^{
        dot.transform = CGAffineTransformMakeScale(1.2, 1.2);
        dot.alpha = 0.8;
        [self moveDot:dot withGesture:gesture];
    }];
    
    [DotView arrangeDotsNeatlyWithAnimationInView:_drawerView];
}

- (void)moveDot:(UIView *)dot withGesture:(UIGestureRecognizer *)gesture {
    dot.center = [gesture locationInView:self.view];
}

- (void)dropDot:(UIView *)dot withGesture:(UIGestureRecognizer *)gesture {
    [UIView animateWithDuration:0.2 animations:^{
        dot.transform = CGAffineTransformIdentity;
        dot.alpha = 0.8;
    }];
    
    CGPoint locationInDrawer = [gesture locationInView:_drawerView];
    if (CGRectContainsPoint(_drawerView.bounds, locationInDrawer)) {
        [_drawerView addSubview:dot];
    } else {
        [_canvasView addSubview:dot];
    }
    dot.center = [dot.superview convertPoint:dot.center fromView:self.view];
    
    [DotView arrangeDotsNeatlyWithAnimationInView:_drawerView];
}

@end
