//
//  UIImage+CornerRadius.m
//  performance
//
//  Created by KudoCC on 16/3/8.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "UIImage+CornerRadius.h"

@implementation UIImage (CornerRadius)

+ (UIImage *)imageWithSize:(CGSize)size cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor {
    return [self imageWithSize:size cornerRadius:radius backgroundColor:bgColor borderWidth:0 borderColor:nil];
}

+ (UIImage *)imageWithSize:(CGSize)size cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    // 如果opaque为YES，背景全黑了
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, size.width, size.height));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0, 0.0, size.width, size.height) cornerRadius:radius];
    [path addClip];
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    if (borderWidth > 0 && borderColor) {
        path.lineWidth = borderWidth*2;
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
