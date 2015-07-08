//
//  CourseReviewCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseReviewCell.h"

@implementation CourseReviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.courseimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 280, 170)];
        [self.contentView addSubview:self.courseimage];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //NSLog(@"info:%@",self.coursePhotoDic);
    //NSLog(@"url:%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.coursePhotoDic[@"pic_url"]]]);
    [self.courseimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.coursePhotoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
}

@end
