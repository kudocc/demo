//
//  ViewController.m
//  ImageMask
//
//  Created by KudoCC on 16/1/7.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "ImageMaskViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *arrayTitle;
@property (nonatomic, strong) NSArray *arrayClass;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrayTitle = @[@"ImageMask"];
    _arrayClass = @[[ImageMaskViewController class]];
    
    /*
    UIImage *imageNoAlpha = [UIImage imageNamed:@"image_mask"];
    CGImageRef imageAsMaskRef = imageNoAlpha.CGImage;
    CGBitmapInfo bitmapInfo = 0;
    bitmapInfo |= kCGImageAlphaPremultipliedLast;
    bitmapInfo |= kCGBitmapFloatInfoMask;
    bitmapInfo |= kCGBitmapByteOrderDefault;
    
    CGContextRef bitmapContext = CGBitmapContextCreate(nil,
                                                       CGImageGetWidth(imageAsMaskRef),
                                                       CGImageGetHeight(imageAsMaskRef),
                                                       CGImageGetBitsPerComponent(imageAsMaskRef),
                                                       CGImageGetBytesPerRow(imageAsMaskRef),
                                                       CGImageGetColorSpace(imageAsMaskRef),
                                                       bitmapInfo);
    CGContextRef context = bitmapContext;
    [[UIColor blackColor] setFill];
    CGContextFillRect(context, (CGRect){CGPointZero, imageNoAlpha.size});
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(context, 5.0);
    CGRect rectStroke = (CGRect){CGPointZero, imageNoAlpha.size};
    rectStroke = CGRectInset(rectStroke, 5, 5);
    CGContextStrokeRect(context, rectStroke);
    CGImageRef imageRes = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    CGImageRelease(imageRes);
    UIImage *image = [UIImage imageWithCGImage:imageRes];
    */
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.opaque = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = _arrayClass[indexPath.row];
    UIViewController *vc = (UIViewController *)[[class alloc] init];
    vc.title = _arrayTitle[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.textLabel.text = _arrayTitle[indexPath.row];
    return cell;
}

@end
