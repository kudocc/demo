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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 370, 300)];
    [self.view addSubview:label];
    NSTextAttachment *attachmentImage = [[NSTextAttachment alloc] init];
    attachmentImage.image = [UIImage imageNamed:@"zombie2.jpg"];
    attachmentImage.bounds = CGRectMake(0, -10, 100, 100);
    NSAttributedString *attrImage = [NSAttributedString attributedStringWithAttachment:attachmentImage];
    NSMutableAttributedString *mAttrText = [[NSMutableAttributedString alloc] initWithString:@"an"];
    [mAttrText appendAttributedString:attrImage];
    [mAttrText appendAttributedString:[[NSAttributedString alloc] initWithString:@"a long long string to move to the next line, a long long string to move to the next line, a long long string to move to the next line, a long long string to move to the next line"]];
    label.attributedText = mAttrText;
    label.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
