//
//  ApplyProtocolVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ApplyProtocolVC.h"

@interface ApplyProtocolVC ()

@end

@implementation ApplyProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请假补课章程";
}

- (void)initUI{
    
    [super initUI];
    
    [self footView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)footView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    UIButton *refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refuseBtn setFrame:CGRectMake(20, 10, kScreenWidth/2-40, 40)];
    [refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refuseBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [refuseBtn setBackgroundColor:[UIColor grayColor]];
    refuseBtn.layer.cornerRadius = 4.0f;
    [refuseBtn addTarget:self action:@selector(refuseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:refuseBtn];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setFrame:CGRectMake(kScreenWidth/2+20, 10, kScreenWidth/2-40, 40)];
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agreeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [agreeBtn setBackgroundColor:[UIColor orangeColor]];
    agreeBtn.layer.cornerRadius = 4.0f;
    [agreeBtn addTarget:self action:@selector(agreeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:agreeBtn];
}

- (void)refuseBtnClicked{
    [self.delegate changeSelectedBtn:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)agreeBtnClicked{
    
    [self.delegate changeSelectedBtn:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
