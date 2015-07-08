//
//  ListenZoneCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ListenZoneCell.h"

@implementation ListenZoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 90, 30)];
        self.myLabel.textColor = [UIColor blackColor];
        self.myLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myLabel];
        
        self.myPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 6, 30, 30)];
        self.myPriceLabel.textColor = [UIColor blackColor];
        self.myPriceLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myPriceLabel];
        
        self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-60, 12, 20, 20)];
        
        [self.contentView addSubview:self.selectedImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *imageName =  self.selected ? @"school_selected.png" : @"school_unselected.png";
    self.selectedImageView.image = [UIImage imageNamed:imageName];
}

@end
