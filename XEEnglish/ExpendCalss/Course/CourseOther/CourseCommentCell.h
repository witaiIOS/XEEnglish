//
//  CourseCommentCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface CourseCommentCell : BaseTVC
@property (nonatomic, strong) NSDictionary *commentInfoDic;

@property (weak, nonatomic) IBOutlet UIImageView *commentPersonImage;//用户图片
@property (weak, nonatomic) IBOutlet UILabel *commentPersonName;//用户名
@property (weak, nonatomic) IBOutlet UILabel *commentCreateTime;//评论创建时间
@property (weak, nonatomic) IBOutlet UILabel *commentContent;//评论内容






@end
