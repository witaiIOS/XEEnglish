//
//  SetCommunityVC.h
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SetCommunityVCDelegate <NSObject>

@optional
- (void)setCommunityVCSelectedCommunity:(id) sender;

@end

@interface SetCommunityVC : BaseVC

@property (nonatomic, strong) NSDictionary *selectedCommunityDic;
@property (nonatomic, assign) id<SetCommunityVCDelegate>delegate;

@end
