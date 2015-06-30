//
//  PointsVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PointsVC.h"
#import "ExchangePointsVC.h"
#import "PointSRuleVC.h"

@interface PointsVC ()

@end

@implementation PointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分交易记录";
}

- (void)initUI{
    
    [super initUI];
    
    
    
    //增加一个“积分规则”的按钮
    UIButton *pointsRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pointsRuleBtn setFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    [pointsRuleBtn setBackgroundColor:[UIColor grayColor]];
    [pointsRuleBtn setTitle:@"积分规则..." forState:UIControlStateNormal];
    [pointsRuleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pointsRuleBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [pointsRuleBtn addTarget:self action:@selector(pointsRuleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pointsRuleBtn];
    
    //在导航栏右边增加一个“积分兑换”的按钮
    UIButton *exchangePointsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exchangePointsBtn setFrame:CGRectMake(kScreenWidth-70, 15, 60, 30)];
    [exchangePointsBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [exchangePointsBtn setTitle:@"积分兑换" forState:UIControlStateNormal];
    [exchangePointsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exchangePointsBtn addTarget:self action:@selector(exchangePointsBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *exchangePointsBarBtn = [[UIBarButtonItem alloc] initWithCustomView:exchangePointsBtn];
    self.navigationItem.rightBarButtonItem = exchangePointsBarBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My Action
- (void)exchangePointsBtnClicked{
    
    ExchangePointsVC *vc = [[ExchangePointsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pointsRuleBtnClicked{
    
    PointSRuleVC *vc = [[PointSRuleVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
