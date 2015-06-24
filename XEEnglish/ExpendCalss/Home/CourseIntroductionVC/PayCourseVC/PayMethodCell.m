//
//  PayMethodCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PayMethodCell.h"

@implementation PayMethodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.myPayMethodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 40, 30)];
        [self.contentView addSubview:self.myPayMethodImageView];
        
        self.myPayMethodLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 6, 80, 30)];
        self.myPayMethodLabel.font = [UIFont systemFontOfSize:14];
        self.myPayMethodLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.myPayMethodLabel];
        
        self.mySelectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        [self.contentView addSubview:self.mySelectedImageView];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSString *imageName = self.selected ? @"school_selected.png":@"school_unselected.png";
    self.mySelectedImageView.image = [UIImage imageNamed:imageName];
}

@end
