//
//  UIImage+ImageMask.h
//  ImageMask
//
//  Created by KudoCC on 16/1/7.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageMask)

+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

@end
