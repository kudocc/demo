//
//  UIImage+CornerRadius.h
//  performance
//
//  Created by KudoCC on 16/3/8.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CornerRadius)

+ (UIImage *)imageWithSize:(CGSize)size cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;

+ (UIImage *)imageWithSize:(CGSize)size cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
