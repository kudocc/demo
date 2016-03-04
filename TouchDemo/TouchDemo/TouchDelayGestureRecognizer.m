//
//  TouchDelayGestureRecognizer.m
//  TouchDemo
//
//  Created by KudoCC on 15/9/13.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "TouchDelayGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation TouchDelayGestureRecognizer {
    NSTimer *_timer;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.delaysTouchesBegan = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(fail) userInfo:nil repeats:NO];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self fail];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self fail];
}

- (void)fail {
    self.state = UIGestureRecognizerStateFailed;
}

- (void)reset {
    [_timer invalidate];
    _timer = nil;
}

@end
