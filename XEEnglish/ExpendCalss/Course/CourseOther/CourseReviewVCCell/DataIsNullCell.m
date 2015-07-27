//
//  DataIsNullCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DataIsNullCell.h"

@implementation DataIsNullCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, self.frame.size.height)];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.textColor = [UIColor lightGrayColor];
        self.tipLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.tipLabel];
    }
    return self;
}

@end
