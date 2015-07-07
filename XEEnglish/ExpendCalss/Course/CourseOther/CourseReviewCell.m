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
        self.courseimage = [[UIImageView alloc] initWithFrame:self.frame];
        NSLog(@"info:%@",self.coursePhotoDic);
        [self.courseimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.coursePhotoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        
        [self.contentView addSubview:self.courseimage];
    }
    return self;
}

@end
