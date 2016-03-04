//
//  CAActionTestViewController.m
//  AnimationDemo
//
//  Created by yuanrui on 15/4/27.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "CAActionTestViewController.h"
#import <objc/runtime.h>

@interface CAActionTestViewController ()

@property (nonatomic, strong) CALayer *layer ;

@end

@implementation CAActionTestViewController

- (void)dealloc
{
    _layer.delegate = nil ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _layer = [[CALayer alloc] init] ;
    _layer.frame = CGRectMake(10.0, 64.0, 170.0, 179.0) ;
    UIImage *image = [UIImage imageNamed:@"conan1.png"] ;
    _layer.contents = (__bridge id)image.CGImage ;
    _layer.delegate = self ;
    [self.view.layer addSublayer:_layer] ;
}

- (id<CAAction>)actionForLayer:(CALayer *)theLayer
                        forKey:(NSString *)theKey
{
    CATransition *theAnimation = nil ;
    if ([theKey isEqualToString:@"contents"]) {
        theAnimation = [[CATransition alloc] init] ;
        theAnimation.duration = 1.0 ;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] ;
        theAnimation.type = kCATransitionPush ;
        theAnimation.subtype = kCATransitionFromRight ;
    }
    return theAnimation ;
}

- (void)tapClick:(UITapGestureRecognizer *)gr
{
    UIImage *image = [UIImage imageNamed:@"conan2.png"] ;
    _layer.contents = (__bridge id)image.CGImage ;
}

@end
