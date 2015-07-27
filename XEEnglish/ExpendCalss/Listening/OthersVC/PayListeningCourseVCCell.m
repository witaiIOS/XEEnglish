//
//  PayListeningCourseVCCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PayListeningCourseVCCell.h"

@implementation PayListeningCourseVCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.courseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
        self.courseNameLabel.font = [UIFont systemFontOfSize:14];
        self.courseNameLabel.textColor = [UIColor darkGrayColor];
        
        [self.contentView addSubview:self.courseNameLabel];
        
        UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
        self.selectImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
        
        [self.selectImageView setFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        
        [self addSubview:self.selectImageView];
        
    }
    
    return self;
}


@end
