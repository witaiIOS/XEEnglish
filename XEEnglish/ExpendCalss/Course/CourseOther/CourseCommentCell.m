//
//  CourseCommentCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseCommentCell.h"

@implementation CourseCommentCell

- (void)layoutSubviews{
    
    //NSLog(@"commentInfoDic:%@",self.commentInfoDic);
    
    [self.commentPersonImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.commentInfoDic[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    
    self.commentPersonName.text = self.commentInfoDic[@"parent_name"];
    self.commentCreateTime.text = self.commentInfoDic[@"create_time"];
    self.commentContent.text = self.commentInfoDic[@"parent_comment"];
    
    NSNumber *starNum = self.commentInfoDic[@"star"];
    [self setStarImage:starNum.integerValue];
}

- (void)setStarImage:(NSInteger )num{
    //NSLog(@"num:%li",(long)num);
    for (int i = 0; i<num; i++) {
        UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:i+1];
        imageView.image = [UIImage imageNamed:@"star_1_normal.png"];
        
    }
}

@end
