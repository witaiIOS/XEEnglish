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


#import "FeedBackVC.h"

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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 148)];
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
    //[self.navigationController pushViewController:vc animated:YES];
    UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:nil];
}

- (void)exitAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}



#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 4;
    }
    else{
        return 4;
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
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                str =@"积分";
                break;
            case 1:
                str = @"个人信息";
                break;
            case 2:
                str =@"订单信息";
                break;
            case 3:
                str = @"消费记录";
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
                str = @"告诉朋友";
                break;
            case 1:
                str = @"意见反馈";
                break;
            case 2:
                str = @"获取开通服务城市";
                break;
            case 3:
                str = @"更多设置";
                break;
                
            default:
                break;
        }
    }
    cell.str = str;

    
      return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {}
                break;
            case 1:
            {}
                break;
            case 2:
            {}
                break;
            case 3:
            {}
                break;
                
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
            {}
                break;
            case 1:
            {
                FeedBackVC *vc = [[FeedBackVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {}
                break;
            case 3:
            {}
                break;
                
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 3.0;
    }
    else
    {
        return 20.0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 40.0;
    }
    else
    {
        return 3.0;
    }
    
}



@end
