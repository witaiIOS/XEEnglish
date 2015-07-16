//
//  NearSchoolDetailVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NearSchoolDetailVC.h"

@interface NearSchoolDetailVC ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation NearSchoolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"校区详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.alwaysBounceVertical = YES;//纵向滑动
    self.scrollView.alwaysBounceHorizontal = NO;

    [self headView];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenWidth + self.headView.frame.size.height);
    
    
}

- (void)headView{
    //校区名
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 20)];
    titleLabel.text = self.schoolInfoDic[@"department"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //历史介绍
    UILabel *historyLabel =  [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 60)];
    historyLabel.text = self.schoolInfoDic[@"history"];
    historyLabel.numberOfLines = 0;
    historyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize historySize = [historyLabel sizeThatFits:CGSizeMake(historyLabel.frame.size.width, MAXFLOAT)];
    historyLabel.frame =CGRectMake(0, 20, kScreenWidth, historySize.height);
    historyLabel.font = [UIFont systemFontOfSize:12];
    
    //分割线
    UILabel *historyLine = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+5, kScreenWidth-20, 1)];
    historyLine.backgroundColor = [UIColor lightGrayColor];
    
    //地址
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10, kScreenWidth-20, 50)];
    addressLabel.text = [NSString stringWithFormat:@"地址：%@",self.schoolInfoDic[@"addr"]];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textAlignment = NSTextAlignmentCenter;
    
    //电话
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10 +50, kScreenWidth-20, 20)];
    phoneLabel.text = [NSString stringWithFormat:@"电话：%@",self.schoolInfoDic[@"mobile"]];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    
    //分割线
    UILabel *phoneLine = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10 +50+20+5, kScreenWidth-20, 1)];
    phoneLine.backgroundColor = [UIColor lightGrayColor];
    
    //头视图
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, historyLabel.frame.origin.y+historySize.height+10 +50+20+10)];
    self.headView.backgroundColor = [UIColor clearColor];
    
    //label都加入headView
    [self.headView addSubview:titleLabel];
    [self.headView addSubview:historyLabel];
    [self.headView addSubview:historyLine];
    [self.headView addSubview:addressLabel];
    [self.headView addSubview:phoneLabel];
    [self.headView addSubview:phoneLine];
    
    [self.scrollView addSubview:self.headView];
}



@end
