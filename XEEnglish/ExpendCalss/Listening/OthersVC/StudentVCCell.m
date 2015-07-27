//
//  StudentVCCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "StudentVCCell.h"

@implementation StudentVCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.studentNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
        self.studentNameLabel.font = [UIFont systemFontOfSize:14];
        self.studentNameLabel.textColor = [UIColor darkGrayColor];
        
        [self.contentView addSubview:self.studentNameLabel];
        
        UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
        self.selectImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
        
        [self.selectImageView setFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        
        [self addSubview:self.selectImageView];
        
    }
    
    return self;
}

@end
