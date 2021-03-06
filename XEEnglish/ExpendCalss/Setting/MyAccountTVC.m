//
//  MyAccountTVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/18.
//  Copyright (c) 2015年 aprees. All rights reserved.
//

#import "MyAccountTVC.h"

@implementation MyAccountTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
        [bottomLine setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        [self addSubview:bottomLine];
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 20, 20)];
        [self.contentView addSubview:self.myImageView];
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 6, 80, 30)];
        self.myLabel.textAlignment = NSTextAlignmentLeft;
        self.myLabel.textColor = [UIColor darkGrayColor];
        self.myLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.myLabel];
        
        self.mydetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-130, 6, 100, 30)];
        self.mydetailLabel.textAlignment = NSTextAlignmentRight;
        self.mydetailLabel.textColor = [UIColor darkGrayColor];
        self.mydetailLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.mydetailLabel];

 
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
//    self.textLabel.font = [UIFont systemFontOfSize:14];
//    self.textLabel.textColor = [UIColor darkGrayColor];
//    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    self.textLabel.text = _str;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
