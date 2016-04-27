//
//  UIImage+Resize.h
//  performance
//
//  Created by KudoCC on 16/4/27.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (CGRect)kc_frameOfImage:(UIImage *)image inContentSize:(CGSize)size withContentMode:(UIViewContentMode)contentMode;

+ (UIImage *)kc_resizeImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode size:(CGSize)size;

@end
