//
//  NeTNameAndDomicileVC.h
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol NeTNameAndDomicileDelegate <NSObject>

@optional
- (void)ChangeNeTNameAndDomicile:(id) sender index:(NSInteger)index;

@end

@interface NeTNameAndDomicileVC : BaseVC

@property (strong, nonatomic) NSString *nTitle;
@property (strong, nonatomic) NSString *nplaceholder;
@property (strong, nonatomic) NSString *index;//公共界面，标记更改哪个cell
@property (nonatomic,assign) id<NeTNameAndDomicileDelegate> delegate;

@end
