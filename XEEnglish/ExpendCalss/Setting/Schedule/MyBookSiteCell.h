//
//  MyBookSiteCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface MyBookSiteCell : BaseTVC
@property (nonatomic, strong) NSDictionary *bookSiteInfoDic;
@property (weak, nonatomic) IBOutlet UILabel *bookSiteState;
@property (weak, nonatomic) IBOutlet UILabel *bookSiteSchollZone;
@property (weak, nonatomic) IBOutlet UILabel *bookSiteStateTime;
@property (weak, nonatomic) IBOutlet UILabel *bookSiteEndTime;
@property (weak, nonatomic) IBOutlet UIImageView *bookSiteProjectorImageview;
@property (weak, nonatomic) IBOutlet UIImageView *bookSiteTeacherImageView;

@end
