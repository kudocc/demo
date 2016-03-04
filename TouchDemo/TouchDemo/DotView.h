//
//  DotView.h
//  TouchDemo
//
//  Created by KudoCC on 15/9/13.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DotView : UIView

+ (instancetype)randomDotView;

+ (void)arrangeDotsRandomlyInView:(UIView *)view;
+ (void)arrangeDotsNeatlyInView:(UIView *)view;
+ (void)arrangeDotsNeatlyWithAnimationInView:(UIView *)view;

@end
