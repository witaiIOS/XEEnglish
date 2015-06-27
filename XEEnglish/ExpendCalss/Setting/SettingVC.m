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
//#import "CouponsVC.h"
#import "MyScheduleVC.h"

#import "CitiesVC.h"
#import "MoreSettingVC.h"

#import "XeeService.h"

@interface SettingVC ()<UITableViewDataSource, UITableViewDelegate,SelectedCityDelegate, UIAlertViewDelegate, LoginVCDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UILabel *userPhoneNumber;

@property (nonatomic, strong) NSString *selectCity;

@property (nonatomic, strong) NSDictionary *myInfoDic;

@end

@implementation SettingVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //[self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectCity = self.myInfoDic[@"city"];
    
    [self updateUserLoginUI];
    
    [self getMyInfoFromWeb];

}

- (void)initUI{
    [super initUI];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [self tableHeaderView];
    self.tableView.tableFooterView = [self tableFooterView];
    //[self.tableView registerClass:[MyAccountTVC class] forCellReuseIdentifier:@"MyAccountTVC"];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserInfo
- (BOOL)isLogin {
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    
    NSNumber *ifLogin = userDic[uIslogin];
    
    return ifLogin.integerValue == 0 ? YES : NO;
}

- (void)updateUserLoginUI {
    if ([self isLogin]) {
        self.userPhoneNumber.hidden = NO;
        self.loginBtn.hidden = YES;
        
        self.userPhoneNumber.text = [[[[UserInfo sharedUser] getUserInfoDic] objectForKey:uUserInfoKey] objectForKey:uPhoneNumber];
        
        _exitBtn.hidden = NO;
        //登陆之后，请求“我的”信息
        [self getMyInfoFromWeb];
    }
    else {
        self.userPhoneNumber.hidden = YES;
        self.loginBtn.hidden = NO;
        
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
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 31, 34)];
    [phoneImage setImage:[UIImage imageNamed:@"people_ayb.png"]];
    [view addSubview: phoneImage];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [self.loginBtn setFrame:CGRectMake(80, 50, 80, 40)];
    //    self.loginBtn.titleLabel.text = @"请点击登陆";
    //    self.loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.loginBtn setFrame:CGRectMake(50, 30, 80, 40)];
    [self.loginBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius =4.0;
    self.loginBtn.hidden = NO;
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.loginBtn];
    
    
    self.userPhoneNumber =[[UILabel alloc] initWithFrame:CGRectMake(50, 30, 220, 40)];
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
    
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    loginVC.delegate = self;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)exitAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 99;
    [alert show];
}
#pragma mark - Web

- (void)getMyInfoFromWeb{
    
    [[XeeService sharedInstance] getMyInfoWithParentId:@"17" andToken:@"yEqHDenWZHBlDIlSPE983NPkCkQsz4yU/K9ZLVS8G+RcUG0HSXerMEH2rpacH5aH53d6XsNRPWnpS/Uocat+xA==" andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                self.myInfoDic = result[@"resultInfo"];
                
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
        return 3;
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
                str = @"个人信息";
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
                detailStr = [NSString stringWithFormat:@"%@",self.myInfoDic[@"points"]];
                break;
            }
//            case 1:
//            {
//                str =@"优惠券";
//                image = [UIImage imageNamed:@"STcoupon.png"];
//                break;
//            }
            case 1:
                str =@"我的预定";
                image = [UIImage imageNamed:@"STreserve.png"];
                detailStr = [NSString stringWithFormat:@"%@/%@/%@",self.myInfoDic[@"course"],self.myInfoDic[@"activity"],self.myInfoDic[@"booksite"]];
                break;
            case 2:
                str = @"消费记录";
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
                detailStr = self.selectCity;
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
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                PersonInfoVC *vc = [[PersonInfoVC alloc] init];
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
                break;
            }
                
//            case 1:
//            {
//                CouponsVC *vc = [[CouponsVC alloc] init];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//                break;
//            }
                
            case 1:
            {
                MyScheduleVC *vc = [[MyScheduleVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2:
            {
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
    }
}

#pragma mark - LoginVC Delegate
- (void)loginVCloginSuccess {
    [self updateUserLoginUI];
}


@end
