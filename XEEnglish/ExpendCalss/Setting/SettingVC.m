//
//  SettingVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SettingVC.h"
#import "LoginVC.h"
#import "MyAccountTVC.h"


#import "PersonInfoVC.h"
#import "StudentPhotosVC.h"
#import "CouponsVC.h"
//#import "PointsVC.h"
#import "ExchangePointsVC.h"
#import "MyScheduleVC.h"
#import "ExpendRecordVC.h"

#import "CitiesVC.h"
#import "MoreSettingVC.h"

#import "XeeService.h"

@interface SettingVC ()<UITableViewDataSource, UITableViewDelegate,SelectedCityDelegate, UIAlertViewDelegate, LoginVCDelegate>
@property (nonatomic, strong) UIButton *signBtn;//签到按钮
@property (nonatomic, strong) NSString *signMarkStr;//签到返回标记
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *personImage;//个人头像
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *loginBtnLabel;//请点击登陆
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UILabel *userPhoneNumber;

@property (nonatomic, strong) NSString *selectCity;

@property (nonatomic, strong) NSDictionary *myInfoDic;


@end

@implementation SettingVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.tableView reloadData];
    
           [self updateUserLoginUI];
        
       // [self getMyInfoFromWeb];
        
       // [self.tableView reloadData];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.selectCity = self.myInfoDic[@"city"];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self updateUserLoginUI];
    
    [self getMyInfoFromWeb];
    
    //注册刷新页面的监听者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingRefresh) name:SettingRefresh object:nil];

}

- (void)initUI{
    [super initUI];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-45-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [self tableHeaderView];
    self.tableView.tableFooterView = [self tableFooterView];
    //[self.tableView registerClass:[MyAccountTVC class] forCellReuseIdentifier:@"MyAccountTVC"];
    [self.view addSubview:self.tableView];
    
    //签到按钮
    self.signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signBtn setFrame:CGRectMake(kScreenWidth-70, 15, 60, 30)];
    [self.signBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //reservePlaceBtn.backgroundColor = [UIColor orangeColor];
    NSLog(@"sign:%@",self.signMarkStr);
//    if ([self.signMarkStr isEqualToString:@"0"]) {
//        [self.signBtn setTitle:@"签到" forState:UIControlStateNormal];
//    }else{
//        [self.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
//    }
    [self.signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signBtn.titleLabel setFont: [UIFont systemFontOfSize:16.0]];
    [self.signBtn addTarget:self action:@selector(signBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *signBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.signBtn];
    self.navigationItem.rightBarButtonItem = signBarBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My Action
//检查一下是否已签到
- (void)checkSign{
    if ([self.signMarkStr intValue] == 1) {
        [self.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
        self.signBtn.enabled = NO;
    }
    else{
        [self.signBtn setTitle:@"签到" forState:UIControlStateNormal];
        self.signBtn.enabled = YES;
    }
}


//签到按钮的功能
- (void)signBtnAction{
    //签到
    [self checkSignWithWeb];
}

#pragma mark - Web

- (void)checkSignWithWeb{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"id:%@",userInfoDic[uUserId]);
    //NSLog(@"token:%@",userInfoDic[uUserToken]);
    [self showHud];
    [[XeeService sharedInstance] signWithParentId:userInfoDic[uUserId] andPlatform_type_id:@"202" andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                [UIFactory showAlert:result[@"resultInfo"]];
                self.signMarkStr = @"1";
                //NSLog(@"signMarkStr:%@",self.signMarkStr);
                [self changeSignBtnTitle];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
                //self.signMarkStr = result[@"resultInfo"];
            }
        }
        else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}

- (void)changeSignBtnTitle{
    
    if ([self.signMarkStr isEqualToString:@"1"]) {
        [self.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
        self.signBtn.enabled = NO;
        //签到之后刷新页面，改变积分
        [self getMyInfoFromWeb];
        [self.tableView reloadData];
    }
}





#pragma mark - UserInfo
//- (BOOL)isLogin {
//    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
//    
//    NSNumber *ifLogin = userDic[uIslogin];
//    
//    return ifLogin.integerValue == 0 ? YES : NO;
//}
//
- (void)updateUserLoginUI {
    if ([[UserInfo sharedUser] isLogin]) {
        self.userPhoneNumber.hidden = NO;
        self.loginBtnLabel.hidden = YES;
        //登陆之后，tag设置成1，点击跳转到个人页面
        self.loginBtn.tag = 1;
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *userInfoDic = userDic[uUserInfoKey];
        [self.personImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,userInfoDic[uUserPhoto]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        //self.userPhoneNumber.text = [[[[UserInfo sharedUser] getUserInfoDic] objectForKey:uUserInfoKey] objectForKey:uPhoneNumber];
        self.userPhoneNumber.text = [NSString stringWithFormat:@"%@(%@)",userInfoDic[uUserName],userInfoDic[uPhoneNumber]];
        
        _exitBtn.hidden = NO;
        //登陆之后，请求“我的”信息
        [self getMyInfoFromWeb];
    }
    else {
        [self.personImage setImage:[UIImage imageNamed:@"people_ayb.png"]];
        self.userPhoneNumber.hidden = YES;
        self.loginBtnLabel.hidden = NO;
        //未登陆，tag设置成0，点击跳转到登陆页面
        self.loginBtn.tag = 0;
        
        _exitBtn.hidden = YES;

    }
}

#pragma mark - Set tableView
- (UIView *)tableHeaderView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 98)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *bakeGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 88)];
    [bakeGroundImage setImage:[UIImage imageNamed:@"SThead.png"]];
    [view addSubview:bakeGroundImage];
    
    self.personImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 50, 50)];
    //[self.personImage setImage:[UIImage imageNamed:@"people_ayb.png"]];
    [view addSubview: self.personImage];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [self.loginBtn setFrame:CGRectMake(80, 50, 80, 40)];
    //    self.loginBtn.titleLabel.text = @"请点击登陆";
    //    self.loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.loginBtn setFrame:CGRectMake(0, 0, kScreenWidth, 88)];
    //[self.loginBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
    //self.loginBtn.layer.cornerRadius =4.0;
    //self.loginBtn.hidden = NO;
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.loginBtn];
    
    self.loginBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 220, 40)];
    self.loginBtnLabel.text = @"请点击登陆";
    //self.loginBtnLabel.textAlignment =NSTextAlignmentCenter;
    self.loginBtnLabel.textColor = [UIColor whiteColor];
    self.loginBtnLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:self.loginBtnLabel];
    
    self.userPhoneNumber =[[UILabel alloc] initWithFrame:CGRectMake(70, 30, 220, 40)];
    //self.userPhoneNumber.textAlignment =NSTextAlignmentCenter;
    self.userPhoneNumber.textColor = [UIColor whiteColor];
    self.userPhoneNumber.font = [UIFont systemFontOfSize:17];
    [view addSubview:self.userPhoneNumber];
    
    return view;
    
    
}

-(UIView *)tableFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    view.backgroundColor = [UIColor clearColor];
    
     _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exitBtn setFrame: CGRectMake(20, 0, kScreenWidth-40, 40)];
    [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:[UIColor orangeColor]];
    
    _exitBtn.layer.cornerRadius = 4.0;
    [_exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_exitBtn];
    
    return view;
    
}

#pragma mark - Action
- (void)loginAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.delegate = self;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else if (btn.tag == 1){
        PersonInfoVC *vc = [[PersonInfoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)exitAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 99;
    [alert show];
}
#pragma mark - Web

- (void)getMyInfoFromWeb{
    if ([[UserInfo sharedUser] isLogin]) {
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *userInfoDic = userDic[uUserInfoKey];
        [self showHudOnlyMsg:@"载入信息..."];
        [[XeeService sharedInstance] getMyInfoWithParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
            [self hideHud];
            if (!error) {
                //NSLog(@"result:%@",result);
                
                NSNumber *isResult = result[@"result"];
                
                if (isResult.integerValue == 0) {
                    self.myInfoDic = result[@"resultInfo"];
                    self.selectCity = self.myInfoDic[@"city"];
                    //获取是否已签到的标记
                    self.signMarkStr = [NSString stringWithFormat:@"%@",self.myInfoDic[@"sign"]];
                    //根据标记改变签到按钮title
                    [self checkSign];
                    [self.tableView reloadData];
                }
                else{
                    [UIFactory showAlert:@"未知错误"];
                }
            }
            else{
                [UIFactory showAlert:@"网络错误"];
            }
        }];
    }
//    else{
//        [self showHudOnlyMsg:@"请先登录"];
//    }
    
}



#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else if(section == 1){
        return 4;
    }
    else{
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"MyAccountTVC";
    MyAccountTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell ==nil) {
        cell = [[MyAccountTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *str = nil;
    UIImage *image = nil;
    NSString *detailStr = nil;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                str = @"宝宝相册";
                image = [UIImage imageNamed:@"STpersonal.png"];
                break;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                str =@"积分";
                image = [UIImage imageNamed:@"STintegral.png"];
                if ([[UserInfo sharedUser] isLogin]) {
                    detailStr = [NSString stringWithFormat:@"%@",self.myInfoDic[@"points"]];
                }
                break;
            }
            case 1:
            {
                str =@"现金券";
                image = [UIImage imageNamed:@"STcoupon.png"];
                break;
            }
            case 2:
                str =@"我的预定";
                image = [UIImage imageNamed:@"STreserve.png"];
                if ([[UserInfo sharedUser] isLogin]){
                    detailStr = [NSString stringWithFormat:@"%@/%@/%@",self.myInfoDic[@"course"],self.myInfoDic[@"activity"],self.myInfoDic[@"booksite"]];
                }
                break;
            case 3:
                str = @"订单";
                //detailStr = [NSString stringWithFormat:@"%@",self.myInfoDic[@"coupon"]];
                image = [UIImage imageNamed:@"STexpense.png"];
                break;
                
            default:
                break;
        }
    }

    else{
        
        switch (indexPath.row) {
            case 0:
            {
                str = @"城市";
                image = [UIImage imageNamed:@"STcity.png"];
                if ([[UserInfo sharedUser] isLogin]){
                    detailStr = self.selectCity;
                }
                break;
            }
                
            case 1:
            {
                str = @"更多设置";
                image = [UIImage imageNamed:@"STset.png"];
                break;
            }
                
            default:
                break;
        }
    }
    cell.myLabel.text = str;
    cell.myImageView.image = image;
    cell.mydetailLabel.text = detailStr;
    
    
    return cell;
}



#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[UserInfo sharedUser] isLogin]) {
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
                    StudentPhotosVC *vc = [[StudentPhotosVC alloc] init];
                    //PersonInfoVC *vc = [[PersonInfoVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                default:
                    break;
            }
        }
        else if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                {
                    ExchangePointsVC *vc = [[ExchangePointsVC alloc] init];
                    vc.pointTotal = [NSString stringWithFormat:@"%@",self.myInfoDic[@"points"]];
                    vc.pointExam = [NSString stringWithFormat:@"%@",self.myInfoDic[@"points_exam"]];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                case 1:
                {
                    CouponsVC *vc = [[CouponsVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.superView = 0;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                case 2:
                {
                    MyScheduleVC *vc = [[MyScheduleVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3:
                {
                    ExpendRecordVC *vc = [[ExpendRecordVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                    
                default:
                    break;
            }
        }
        
        else{
            switch (indexPath.row) {
                case 0:
                {
                    CitiesVC *vc = [[CitiesVC alloc] init];
                    vc.selectedCity = self.selectCity;
                    vc.delegate = self;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                case 1:
                {
                    MoreSettingVC *vc = [[MoreSettingVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                default:
                    break;
            }
        }
    }else{
//        LoginVC *vc = [[LoginVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        //[self showHudOnlyMsg:@"请先登录"];
        [UIFactory showAlert:@"请先登录"];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5.0f;
    }
    else
    {
        return 10.0f;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 40.0f;
    }
    else
    {
        return 3.0f;
    }
    
}

#pragma mark - SelectedCity Delegate
- (void)SelectedCity:(id)sender{
    
    self.selectCity = sender;
    [self.tableView reloadData];
}

#pragma mark - AlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 99 && buttonIndex == 0) {
        [[UserInfo sharedUser] initUserInfoDic];
        [self updateUserLoginUI];
        //退出后刷新数据
        [self.tableView reloadData];
//        //发送通知
//        NSDictionary *dic = [[UserInfo sharedUser] getUserInfoDic];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingVCToReloadCourseVC" object:self userInfo:dic];
    }
}

#pragma mark - LoginVC Delegate
- (void)loginVCloginSuccess {
    [self updateUserLoginUI];
}

#pragma mark - NSNotification 监听刷新页面的通知
- (void)settingRefresh{
    
    //刷新页面
    [self getMyInfoFromWeb];
    [self.tableView reloadData];
}


@end
