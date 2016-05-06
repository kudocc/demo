//
//  CTView.h
//  CoreText
//
//  Created by KudoCC on 16/5/4.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CTView : UIScrollView <UIScrollViewDelegate>

@property (strong, nonatomic) NSAttributedString* attString;
@property (strong, nonatomic) NSMutableArray *frames;
@property (strong, nonatomic) NSArray* images;

-(void)setAttString:(NSAttributedString *)attString withImages:(NSArray*)imgs;

- (void)buildFrames;

@end
