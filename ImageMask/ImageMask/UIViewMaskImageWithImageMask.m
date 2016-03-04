//
//  UIViewMaskImageWithImageMask.m
//  ImageMask
//
//  Created by KudoCC on 16/1/7.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "UIViewMaskImageWithImageMask.h"
#import "UIImage+ImageMask.h"

@implementation UIViewMaskImageWithImageMask

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *imageBg = [UIImage imageNamed:@"bg"];
        UIImage *imageMask = [UIImage imageNamed:@"image_mask"];
        
        _imageViewOri = [[UIImageView alloc] initWithImage:imageBg];
        [self addSubview:_imageViewOri];
        _imageViewOri.layer.borderColor = [UIColor redColor].CGColor;
        _imageViewOri.layer.borderWidth = 1.0;
        
        _imageViewMask = [[UIImageView alloc] initWithImage:imageMask];
        [self addSubview:_imageViewMask];
        _imageViewMask.layer.borderColor = [UIColor redColor].CGColor;
        _imageViewMask.layer.borderWidth = 1.0;
        
        UIImage *imageMasked = [UIImage maskImage:imageBg withMask:imageMask];
        _imageViewResult = [[UIImageView alloc] initWithImage:imageMasked];
        [self addSubview:_imageViewResult];
        _imageViewResult.layer.borderColor = [UIColor redColor].CGColor;
        _imageViewResult.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewOri.frame = CGRectMake(0.0, 64.0, _imageViewOri.bounds.size.width, _imageViewOri.bounds.size.height);
    _imageViewMask.frame = CGRectMake(0.0, floor(_imageViewOri.frame.origin.y + _imageViewOri.bounds.size.height), _imageViewMask.bounds.size.width, _imageViewMask.bounds.size.height);
    _imageViewResult.frame = CGRectMake(0.0, floor(_imageViewMask.frame.origin.y+_imageViewMask.frame.size.height), _imageViewOri.bounds.size.width, _imageViewOri.bounds.size.height);
}

@end
