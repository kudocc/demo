//
//  CTColumnView.h
//  CoreText
//
//  Created by KudoCC on 16/5/4.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CTColumnView : UIView {
    id ctFrame;
}

@property (strong, nonatomic) NSMutableArray* images;

-(void)setCTFrame:(id)f;
@end