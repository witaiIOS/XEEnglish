//
//  BaseTVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/18.
//  Copyright (c) 2015年 aprees. All rights reserved.
//

#import "BaseTVC.h"

@implementation BaseTVC

- (void)awakeFromNib {
    // Initialization code
}

//-(void)setFrame:(CGRect)frame
//{
//    CGRect rc =CGRectMake(frame.origin.x + self.cellEdge, frame.origin.y, frame.size.width - self.cellEdge * 2, frame.size.height);
//    [self setFrame:rc];
//}
- (void)setFrame:(CGRect)frame
{
    CGRect rc =CGRectMake(frame.origin.x + self.cellEdge, frame.origin.y, frame.size.width - self.cellEdge * 2, frame.size.height);
    [super setFrame:rc];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
