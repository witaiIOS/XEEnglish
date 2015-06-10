//
//  AppConfig.h
//
//  Created by lixiang on 15-5-15.
//  Copyright 2015年 lixiang. All rights reserved.
//



#define kAPPID                  @"123456789"
#define kAPPName                [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kAPPCommentUrl          @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d"
#define kAPPUpdateUrl           @"http://itunes.apple.com/lookup?id=%d"


//----------屏幕尺寸----------
#define kScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight         ([UIScreen mainScreen].bounds.size.height)



#define MZBimageURLPrefix @"http://www.mrchabo.com/mrchabo/"
#define MZBWebURL @"http://www.mrchabo.com/houseWs/ws/houseWs?wsdl"

#define XEEimageURLPrefix @"http://218.244.143.58:604"
#define XEEWebURL @"http://218.244.143.58:604/ShaneAppWs.asmx?wsdl"


















