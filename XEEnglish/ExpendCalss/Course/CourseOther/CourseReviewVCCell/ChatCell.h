//
//  ChatCell.h
//  XEEnglish
//
//  Created by houjing on 15/8/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface ChatCell : BaseTVC
@property (nonatomic, strong) NSDictionary *chatInfoDic;//聊天的dic

@property (nonatomic, strong) UILabel *bubbleTime;//聊天时间
@property (nonatomic, strong) UIImageView *photo;//创建头像
@end
