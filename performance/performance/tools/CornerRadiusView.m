//
//  CornerRadiusView.m
//  performance
//
//  Created by KudoCC on 16/1/21.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "CornerRadiusView.h"

@implementation CornerRadiusView

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGSize size = self.bounds.size;
    
    // context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // background color
    UIColor *backgroundColor = self.backgroundColor;
    if (!backgroundColor) {
        backgroundColor = [UIColor clearColor];
    }
    
    // if there is a corner radius, set clear color as fill color, then fill background and set the clip zone
    if (_cornerRadius > 0.0) {
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, self.bounds);
        [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius] addClip];
    }
    
    // draw background
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
    
    if (self.image) {
        CGSize imageSize = self.image.size;
        
        CGFloat (^centerImageOriX)(void) = ^{
            return size.width/2 - imageSize.width/2;
        };
        CGFloat (^centerImageOriY)(void) = ^{
            return size.height/2 - imageSize.height/2;
        };
        
        CGRect frameImage = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        switch (self.contentMode) {
            case UIViewContentModeScaleToFill:
                frameImage = self.bounds;
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
        
        // draw content
        [self.image drawInRect:frameImage];
    }
    
    // draw border
    if (_borderWidth > 0.0 && _borderColor) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
        path.lineWidth = _borderWidth;
        [path stroke];
    }
}

@end
