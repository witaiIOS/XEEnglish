//
//  payCompleteVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "payCompleteVC.h"

@interface payCompleteVC ()

@end

@implementation payCompleteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"爱迪天才";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //提示成功
    UILabel *tipFinishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 40)];
    tipFinishLabel.text = @"提交成功";
    tipFinishLabel.textColor = [UIColor orangeColor];
    tipFinishLabel.textAlignment = NSTextAlignmentCenter;
    tipFinishLabel.font = [UIFont systemFontOfSize:24];
    
    [view addSubview:tipFinishLabel];
    
    UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, 40)];
    otherLabel.text = @"我们会尽快联系您，请稍等";
    otherLabel.textColor = [UIColor blackColor];
    otherLabel.textAlignment = NSTextAlignmentCenter;
    otherLabel.font = [UIFont systemFontOfSize:14];
    
    [view addSubview:otherLabel];
}


@end
