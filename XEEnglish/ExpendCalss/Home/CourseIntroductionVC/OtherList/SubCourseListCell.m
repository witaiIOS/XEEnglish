//
//  SubCourseListCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SubCourseListCell.h"

@implementation SubCourseListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.courseName = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 60, 30)];
        self.courseName.textColor = [UIColor darkGrayColor];
        self.courseName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.courseName];
        
        UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
        self.selectedImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
        [self.selectedImageView setFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        
        [self.contentView addSubview:self.selectedImageView];
    }
    
    return self;
}

@end
