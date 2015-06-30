//
//  PointsVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PointsVC.h"

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
