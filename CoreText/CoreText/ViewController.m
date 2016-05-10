//
//  ViewController.m
//  CoreText
//
//  Created by KudoCC on 16/5/4.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
#import "MarkupParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    self.view = [[CTView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64.0)];
}

- (CTView *)ctView {
    return (CTView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 360, 300)];
    [self.view addSubview:label];
    
    NSTextAttachment *attachmentImage = [[NSTextAttachment alloc] init];
    attachmentImage.image = [UIImage imageNamed:@"zombie2.jpg"];
    attachmentImage.bounds = CGRectMake(0, -10, 100, 100);
    NSAttributedString *attrImage = [NSAttributedString attributedStringWithAttachment:attachmentImage];
    NSMutableAttributedString *mAttrText = [[NSMutableAttributedString alloc] initWithString:@"an good begin"];
    [mAttrText appendAttributedString:attrImage];
    [mAttrText appendAttributedString: [[NSAttributedString alloc] initWithString:@" "]];
    [mAttrText appendAttributedString:[[NSAttributedString alloc] initWithString:@"a long long string to move to the next line"]];
    CGRect boundingRect = [mAttrText boundingRectWithSize:CGSizeMake(label.bounds.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    boundingRect = CGRectMake(label.frame.origin.x, label.frame.origin.y, ceil(boundingRect.size.width), ceil(boundingRect.size.height));
    NSLog(@"%@", NSStringFromCGRect(boundingRect));
    label.attributedText = mAttrText;
    label.numberOfLines = 0;
    label.frame = boundingRect;
    label.backgroundColor = [UIColor whiteColor];
    
    CFRange rangeFit;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)mAttrText);
    CGSize targetSize = CGSizeMake(320, CGFLOAT_MAX);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [mAttrText length]), NULL, targetSize, &rangeFit);
    NSLog(@"size:%@,range:%ld,%ld", NSStringFromCGSize(fitSize), rangeFit.location, rangeFit.length);
    
    UIGraphicsBeginImageContext(CGSizeMake(375, 1000));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, 1000);
    CGContextScaleCTM(context, 1, -1);
    
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger pos = 0; pos < [mAttrText length]; ) {
        CFRange range = CFRangeMake(pos, 0);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, label.bounds.size.width, 300));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, range, path, NULL);
        CTFrameDraw(frame, context);
        CFRange rangeVisible = CTFrameGetVisibleStringRange(frame);
        pos += rangeVisible.length;
        [mArray addObject:(__bridge_transfer id)frame];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CFRelease(framesetter);
    
    /*
    self.ctView.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGRect fra = CGRectMake(0, 0, 100, 100);
    fra = CGRectOffset(fra, 10, 10);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zombies" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    MarkupParser* p = [[MarkupParser alloc] init];
    NSAttributedString* attString = [p attrStringFromMarkup:text];
    [self.ctView setAttString:attString withImages: p.images];
    
    [self.ctView buildFrames];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
