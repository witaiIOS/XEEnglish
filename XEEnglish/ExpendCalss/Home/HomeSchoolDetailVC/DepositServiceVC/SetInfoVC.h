//
//  SetInfoVC.h
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SetInfoVCDelegate <NSObject>

@optional
- (void)SetInfoVCInputInfo:(id) sender index:(NSInteger)index;

@end

@interface SetInfoVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *infoTF;
@property (strong, nonatomic) NSString *nTitle;
@property (strong, nonatomic) NSString *nplaceholder;
@property (strong, nonatomic) NSString *index;//公共界面，标记更改哪个cell

@property (assign, nonatomic) id<SetInfoVCDelegate>delegate;
@end
