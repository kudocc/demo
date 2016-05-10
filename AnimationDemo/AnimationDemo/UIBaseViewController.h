//
//  UIBaseViewController.h
//  AnimationDemo
//
//  Created by yuanrui on 15/4/27.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UIBaseViewController : UIViewController

// override
- (void)tapClick:(UITapGestureRecognizer *)gr;

@end
