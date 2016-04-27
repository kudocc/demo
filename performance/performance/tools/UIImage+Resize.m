//
//  UIImage+Resize.m
//  performance
//
//  Created by KudoCC on 16/4/27.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (CGRect)kc_frameOfImage:(UIImage *)image inContentSize:(CGSize)size withContentMode:(UIViewContentMode)contentMode {
    CGSize imageSize = image.size;
    
    CGFloat (^centerImageOriX)(void) = ^{
        return size.width/2 - imageSize.width/2;
    };
    CGFloat (^centerImageOriY)(void) = ^{
        return size.height/2 - imageSize.height/2;
    };
    
    CGRect frameImage = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    switch (contentMode) {
        case UIViewContentModeScaleToFill:
            frameImage = CGRectMake(0, 0, size.width, size.height);
            break;
        case UIViewContentModeScaleAspectFit: {
            CGFloat ratioW = size.width/imageSize.width;
            CGFloat ratioH = size.height/imageSize.height;
            CGFloat ratio = MIN(ratioW, ratioH);
            frameImage.size = CGSizeMake(floor(ratio * imageSize.width), floor(ratio * imageSize.height));
            frameImage.origin.x = size.width/2 - frameImage.size.width/2;
            frameImage.origin.y = size.height/2 - frameImage.size.height/2;
        }
            break;
        case UIViewContentModeScaleAspectFill: {
            CGFloat ratioW = size.width/imageSize.width;
            CGFloat ratioH = size.height/imageSize.height;
            CGFloat ratio = MAX(ratioW, ratioH);
            frameImage.size = CGSizeMake(floor(ratio * imageSize.width), floor(ratio * imageSize.height));
            frameImage.origin.x = size.width/2 - frameImage.size.width/2;
            frameImage.origin.y = size.height/2 - frameImage.size.height/2;
        }
            break;
            
        case UIViewContentModeCenter: {
            frameImage.origin.x = centerImageOriX();
            frameImage.origin.y = centerImageOriY();
        }
            break;
            
        case UIViewContentModeTop: {
            frameImage.origin.x = centerImageOriX();
            frameImage.origin.y = 0.0;
        }
            break;
            
        case UIViewContentModeBottom: {
            frameImage.origin.x = centerImageOriX();
            frameImage.origin.y = size.height - imageSize.height;
        }
            break;
            
        case UIViewContentModeLeft: {
            frameImage.origin.x = 0.0;
            frameImage.origin.y = centerImageOriY();
        }
            break;
            
        case UIViewContentModeRight: {
            frameImage.origin.x = size.width - imageSize.width;
            frameImage.origin.y = centerImageOriY();
        }
            break;
            
        case UIViewContentModeTopLeft: {
            frameImage.origin.x = 0.0;
            frameImage.origin.y = 0.0;
        }
            break;
            
        case UIViewContentModeTopRight: {
            frameImage.origin.x = size.width - imageSize.width;
            frameImage.origin.y = centerImageOriY();
        }
            break;
            
        case UIViewContentModeBottomLeft: {
            frameImage.origin.x = 0.0;
            frameImage.origin.y = size.height - imageSize.height;
        }
            break;
            
        case UIViewContentModeBottomRight: {
            frameImage.origin.x = size.width - imageSize.width;
            frameImage.origin.y = size.height - imageSize.height;
        }
            break;
            
        default:
            break;
    }
    return frameImage;
}

+ (UIImage *)kc_resizeImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGRect frameImage = [self kc_frameOfImage:image inContentSize:size withContentMode:contentMode];
    [image drawInRect:frameImage];
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

@end
