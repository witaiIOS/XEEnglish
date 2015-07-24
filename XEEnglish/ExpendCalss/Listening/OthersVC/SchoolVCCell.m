//
//  SchoolVCCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchoolVCCell.h"

@implementation SchoolVCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.schoolNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
        self.schoolNameLabel.font = [UIFont systemFontOfSize:14];
        self.schoolNameLabel.textColor = [UIColor darkGrayColor];
        
        [self.contentView addSubview:self.schoolNameLabel];
        
        self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
        self.selectImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
        
        [self addSubview:self.selectImageView];
        
    }
    
    return self;
}

@end
