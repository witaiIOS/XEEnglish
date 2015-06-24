//
//  PaymoneyCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PaymoneyCell.h"

@implementation PaymoneyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 80, 20)];
        self.myLabel.textColor = [UIColor blackColor];
        self.myLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myLabel];
        
        self.myMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 180, 20)];
        self.myMoneyLabel.textAlignment = NSTextAlignmentCenter;
        self.myMoneyLabel.textColor = [UIColor blackColor];
        self.myMoneyLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myMoneyLabel];
        
        UILabel *myUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 12, 20, 20)];
        myUnitLabel.text = @"元";
        myUnitLabel.textColor = [UIColor blackColor];
        myUnitLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:myUnitLabel];
        
        UILabel *myLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, 180, 1)];
        myLineLabel.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:myLineLabel];
    }
    return self;
}

@end
