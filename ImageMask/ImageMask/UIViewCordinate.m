//
//  UIViewCordinate.m
//  ImageMask
//
//  Created by KudoCC on 16/5/6.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "UIViewCordinate.h"

@implementation UIViewCordinate {
    UIImage *image;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        image = [UIImage imageNamed:@"bg"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat y = 64;
    [image drawInRect:CGRectMake(0, y, image.size.width, image.size.height)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    y += image.size.height;
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, y+image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    CGContextRestoreGState(context);
    
    // flip y
    y += image.size.height;
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
}

@end
