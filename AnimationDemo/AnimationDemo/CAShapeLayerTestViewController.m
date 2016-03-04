//
//  CAShapeLayerTestViewController.m
//  AnimationDemo
//
//  Created by KudoCC on 15/10/26.
//  Copyright © 2015年 KudoCC. All rights reserved.
//

#import "CAShapeLayerTestViewController.h"

@interface CAShapeLayerTestViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CAShapeLayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    _shapeLayer = [CAShapeLayer layer];
    [self.view.layer addSublayer:_shapeLayer];
    _shapeLayer.frame = CGRectMake(0.0, 64.0, 200.0, 200.0);
    _shapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _shapeLayer.lineWidth = 50.0;
    _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    _shapeLayer.fillColor = [UIColor blueColor].CGColor;
    _shapeLayer.strokeEnd = 0.0;
    
    // create the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 51.0, 51.0);
    CGPathAddLineToPoint(path, NULL, 100.0, 51.0);
//    CGPathMoveToPoint(path, NULL, 100.0, 1.0);
//    CGPathAddLineToPoint(path, NULL, 100.0, 100.0);
//    CGPathMoveToPoint(path, NULL, 100.0, 100.0);
//    CGPathAddLineToPoint(path, NULL, 150.0, 150.0);
    
    _shapeLayer.path = path;
    CGPathRelease(path);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = 2.0;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_shapeLayer addAnimation:animation forKey:@"animatePath"];
    
    _shapeLayer.strokeEnd = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
