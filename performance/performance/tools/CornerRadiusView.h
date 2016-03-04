//
//  CornerRadiusView.h
//  performance
//
//  Created by KudoCC on 16/1/21.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>


// 对CPU要求很高，iPhone6表现良好；iPhone4卡的一逼。
// 这个方法相当于使用CPU换GPU
// 使用CornerRadiusView相比UIImageView耗费内存也会更多

/**
 As set `cornerRadius` of `UIView.layer` and `maskToBounds` reduce performance seriously, so we draw it by ourselves
 
 Note:self.contentMode don't support UIViewContentModeRedraw
 */
@interface CornerRadiusView : UIView

/**
 like image property of UIImageView
 */
@property (nonatomic, strong) UIImage *image;

/**
 like layer.cornerRadius of UIView
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 like layer.borderWidth of UIView
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 like layer.borderColor of UIView
 */
@property (nonatomic, strong) UIColor *borderColor;

@end
