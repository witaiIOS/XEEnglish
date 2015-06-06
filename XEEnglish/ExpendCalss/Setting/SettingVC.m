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

#import "CouponsVC.h"
#import "PersonInfoVC.h"



#import "MoreSettingVC.h"

@interface SettingVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *userPhoneNumber;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)initUI{
    [super initUI];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStyleGrouped];
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

#pragma mark - Set tableView
- (UIView *)tableHeaderView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 138)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *bakeGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 128)];
    [bakeGroundImage setImage:[UIImage imageNamed:@"mybgpic"]];
    [view addSubview:bakeGroundImage];
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 31, 34)];
    [phoneImage setImage:[UIImage imageNamed:@"people_ayb.png"]];
    [view addSubview: phoneImage];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [self.loginBtn setFrame:CGRectMake(80, 50, 80, 40)];
    //    self.loginBtn.titleLabel.text = @"请点击登陆";
    //    self.loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.loginBtn setFrame:CGRectMake(80, 50, 80, 40)];
    [self.loginBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius =4.0;
    self.loginBtn.hidden = NO;
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.loginBtn];
    
    
    self.userPhoneNumber =[[UILabel alloc] initWithFrame:CGRectMake(80, 50, 220, 40)];
    self.userPhoneNumber.textAlignment =NSTextAlignmentCenter;
    self.userPhoneNumber.textColor = [UIColor darkGrayColor];
    self.userPhoneNumber.font = [UIFont systemFontOfSize:14];
    [view addSubview:self.userPhoneNumber];
    
    return view;
    
    
}

-(UIView *)tableFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setFrame: CGRectMake(20, 0, kScreenWidth-40, 40)];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitBtn setBackgroundColor:[UIColor orangeColor]];
    
    exitBtn.layer.cornerRadius = 4.0;
    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:exitBtn];
    
    return view;
    
}

#pragma mark - Action
- (void)loginAction:(id)sender{
    
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)exitAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
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
    NSString *str = nil;
    UIImage *image = nil;
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
                break;
            }
            case 1:
            {
                str =@"优惠券";
                image = [UIImage imageNamed:@"STcoupon.png"];
                break;
            }
            case 2:
                str =@"我的预定";
                image = [UIImage imageNamed:@"STreserve.png"];
                break;
            case 3:
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
    cell.str = str;
    cell.imageView.image = image;
    
    
    return cell;
}



#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
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
                CouponsVC *vc = [[CouponsVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 1:
            {
                PersonInfoVC *vc = [[PersonInfoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 2:
            {
                break;
            }
            case 3:
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

#pragma mark - My Action


@end
