//
//  BuyCoursePaymentAmountCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BuyCoursePaymentAmountCell.h"

@implementation BuyCoursePaymentAmountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, 80, 30)];
        self.myLabel.textColor = [UIColor blackColor];
        self.myLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myLabel];
        
        
        self.myPriceLabel = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth-100, 6, 60, 30)];
        self.myPriceLabel.textColor = [UIColor grayColor];
        self.myPriceLabel.font = [UIFont systemFontOfSize:14];
        self.myPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.myPriceLabel];
        
        self.myLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 39, 60, 1)];
        self.myLineLabel.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:self.myLineLabel];
        
    }
    
    return self;
}


@end
