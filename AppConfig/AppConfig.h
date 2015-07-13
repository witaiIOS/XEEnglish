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

//微信 分享和支付
#define kWxAppID          @"wx462f32e9fd23eecb"
#define kWxAppSecret      @"a0be8fb9e9933e48beb1e6eb64258630"
#define kWxMCHID          @"1250430901"


//----------屏幕尺寸----------
#define kScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight         ([UIScreen mainScreen].bounds.size.height)



#define MZBimageURLPrefix @"http://www.mrchabo.com/mrchabo/"
#define MZBWebURL @"http://www.mrchabo.com/houseWs/ws/houseWs?wsdl"

//#define XEEimageURLPrefix @"http://218.244.143.58:604"

#define XEEHost  @"http://218.244.143.58:604/" //支付时试用
#define XEEimageURLPrefix [NSString stringWithFormat:@"%@files/",XEEHost]
#define XEEWebURL [NSString stringWithFormat:@"%@ShaneAppWs.asmx?wsdl",XEEHost]
//#define XEEimageURLPrefix @"http://218.244.143.58:604/files/"
//#define XEEWebURL @"http://218.244.143.58:604/ShaneAppWs.asmx?wsdl"
//#define XEEWebURL @"http://192.168.1.122:625/ShaneAppWs.asmx" //本地测试
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
#define uUserAddr                @"uUserAddr"
#define uUserInvitationCode      @"uUserInvitationCode"  //推荐码
#define uUserMemo                @"uUserMemo"            //个性签名
#define uUserPhoto               @"uUserPhoto"

#define uUserId                @"uUserId"
#define uUserToken             @"uUserToken"
#define uUserName              @"uUserName"
#define uPassword              @"uPassword"
#define uPhoneNumber           @"uPhoneNumber"


/*============================================================================*/
/*=======================支付宝支付 相关参数===================================*/
/*============================================================================*/

// 商户PID
#define alipayPARTNER  @"2088911830109459"
// 商户收款账号
#define alipaySELLER  @"info@idealangel.cn"

// 商户私钥，pkcs8格式
#define  alipayRSA_PRIVATE @"MIICdAIBADANBgkqhkiG9w0BAQEFAASCAl4wggJaAgEAAoGBAMFk7SSE0D+JmTNA8pGoPX920g3sA+Y2pN5tTgRnnYoNOMEsHd7UutHY3ckmOyvzGUXYEgQkUgPVBkf78waT9iRPv19udBIqWI0rxUD+rk1xjFXRqgV2OP46Zx1X7m/TNPnigWirzE8oTPvDTMk1eGonSNGWC16gIITFoatta9FxAgMBAAECgYA3DKKQNZoNq/5G36LsoUY4JTtvqRIHEuDlS5ncmR338QGJwyQRjN5M431mR5KqVP2JqxKdyTTrUFUEYoxv/+gdOBKUtRlI7gnQxcmB0MW0JkIQ5OfqyS3wsNopUs/7E9oSMnrT6K98tC363oNwdrEHIoON1hHZuJXRM8wWEBcmwQJBAP9M8ucZAtQYbKR9Cgxb3ByUyre9pFUSOwmbnacaDdrSpNZABWlXmTxNvaS71tM0bxHC5x4vZIKaOdeHi5uYXqkCQQDB7I94tqjdJlSnQKUjJ5LUdo9iGC/gdzGmFhSD+qhC1B8cBcw3/l9/9ha94mfyIRmDki3oUougZ+ZDs4i6foGJAj8s4FnSRZM5tRFj2JbrlTobzAvWQH+idJHsHm6X8Px+eoh/IMHSwpMtBn1Pd7VLauwbMydtJueEDZgdSrY/o4kCQFT2OLGRjZA+n+4bI36wcuMFArLel/NHJYh3ugtMwXVuDCcx3xRVLTAZ+EK/M/1gRRZg8B4ONEBV5QuaV/glPskCQFr3PwHGpXYgdtOYecLqbf3IYw1uXoBwFA3K1dgSXxx+uiYcbcjLaUIPtc8Psl04XNDNLWhY3waYlOMkz1MJKWQ="

// 支付宝公钥
#define alipayRSA_PUBLIC  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

/*============================================================================*/
/*============================================================================*/
/*============================================================================*/











