//
//  UIColor+Util.m
//  TouchDemo
//
//  Created by KudoCC on 15/9/13.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

// translate from swift to objective-c
// source:https://github.com/tadija/TouchDemo/blob/master/TouchDemo/AEColor.swift
- (UIColor *)darkerColorWithFactor:(CGFloat)factor {
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    UIColor *darkerColor = [UIColor whiteColor];
    
    CGFloat hue = 0.0;
    CGFloat saturation = 0.0;
    CGFloat brightness = 0.0;
    CGFloat alpha = 0.0;
    CGFloat white = 0.0;
    
    switch (colorSpaceModel) {
        case kCGColorSpaceModelRGB: {
            if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
                brightness -= brightness * factor;
                saturation += (1.0 - saturation) * factor;
                darkerColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
            }
        }
            break;
        case kCGColorSpaceModelMonochrome:
            if ([self getWhite:&white alpha:&alpha]) {
                white -= factor;
                white = (white < 0.0) ? 0.0 : white; // set min white
                darkerColor = [UIColor colorWithWhite:white alpha:alpha];
            }
            break;
        default:
            NSLog(@"CGColorSpaceModel: \(colorSpaceModel) is not implemented");
            break;
    }
    return darkerColor;
}

@end
