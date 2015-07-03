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

//友盟分享
#define kUmengAppkey      @"5594990867e58ef22d00449d"

//微信
#define kWxAppID          @"wx462f32e9fd23eecb"
#define kWxAppSecret      @"a0be8fb9e9933e48beb1e6eb64258630"


//----------屏幕尺寸----------
#define kScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight         ([UIScreen mainScreen].bounds.size.height)



#define MZBimageURLPrefix @"http://www.mrchabo.com/mrchabo/"
#define MZBWebURL @"http://www.mrchabo.com/houseWs/ws/houseWs?wsdl"

//#define XEEimageURLPrefix @"http://218.244.143.58:604"


#define XEEimageURLPrefix @"http://218.244.143.58:604/files/"
#define XEEWebURL @"http://218.244.143.58:604/ShaneAppWs.asmx?wsdl"
//#define XEEWebURL @"http://192.168.1.122:625/ShaneAppWs.asmx" 本地测试
//测试Token
#define ceShiId                 @"17"
#define ceShiToken              @"yEqHDenWZHANQ08W1WF93J+t+ELfkokN0dz9KsI8kALd/GXU1pEykMyOJupHiHATpELTmg8I+XWN1mKJb8Vr+g=="
///用户信息key
#define UserInfoGlobalKey      @"UserInfoGlobalKey"

#define uIslogin               @"uIslogin" //0登陆 1未登录
#define uUserInfoKey           @"uUserInfoKey"

#define uUserAddr                @"uUserAddr"


/*
//暂时不用的数据
#define uUserIsPhotoEdit         @"uUserIsPhotoEdit"
#define uUserEmail               @"uUserEmail"
#define uUserIdentifyId          @"uUserIdentifyId"
#define uUserIsPhotoEdit         @"uUserIsPhotoEdit"
#define uUserMobile2             @"uUserMobile2"
#define uUserNationality         @"uUserNationality"
#define uUserQq                  @"uUserQq"
#define uUserSex                 @"uUserSex"
*/

#define uUserRegionalId          @"uUserRegionalId"
#define uUserBirthday            @"uUserBirthday"
#define uUserCityName            @"uUserCityName"
#define uUserInvitationCode      @"uUserInvitationCode"  //推荐码
#define uUserMemo                @"uUserMemo"            //个性签名
#define uUserPhoto               @"uUserPhoto"

#define uUserId                @"uUserId"
#define uUserToken             @"uUserToken"
#define uUserName              @"uUserName"
#define uPassword              @"uPassword"
#define uPhoneNumber           @"uPhoneNumber"



















