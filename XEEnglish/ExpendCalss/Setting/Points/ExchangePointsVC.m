//
//  ExchangePointsVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ExchangePointsVC.h"
#import "ExchangePointsCell.h"

#import "PointsVC.h"
#import "PointSRuleVC.h"
#import "XeeService.h"

@interface ExchangePointsVC ()<UITableViewDataSource,UITableViewDelegate,ExchangePointsCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *giftArray;

@property (nonatomic, assign) NSInteger currentGiftPageIndex;//当前礼品页
@property (nonatomic, assign) NSInteger totleGiftPageIndex;//总的页数

@property (nonatomic, strong) UILabel *pointTotalLabel;//总积分
@property (nonatomic, strong) UILabel *pointExamLabel;//待审核积分
@property (nonatomic, strong) UILabel *pointAvailableLabel;//可用积分

@end

@implementation ExchangePointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"兑换详情";
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.giftArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40+64, kScreenWidth, kScreenHeight-40-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self getGiftInfo];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    self.pointTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    self.pointTotalLabel.text = [NSString stringWithFormat:@"积分余额:%@",self.pointTotal];
    self.pointTotalLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:self.pointTotalLabel];
    
    self.pointExamLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 100, 20)];
    self.pointExamLabel.text = [NSString stringWithFormat:@"待审核:%@",self.pointExam];
    self.pointExamLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:self.pointExamLabel];
    
    self.pointAvailableLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 20)];
    NSString *pointAvailableStr = [NSString stringWithFormat:@"%i",(int)([self.pointTotal intValue]-[self.pointExam intValue])];
    self.pointAvailableLabel.text = [NSString stringWithFormat:@"可用余额:%@",pointAvailableStr];
    self.pointAvailableLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:self.pointAvailableLabel];
    
    UILabel *pointsRuleLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, kScreenWidth-210, 40)];
    pointsRuleLabel.text = @"点击查看积分规则...";
    pointsRuleLabel.textColor = [UIColor blueColor];
    pointsRuleLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:pointsRuleLabel];
    
    //增加一个“积分规则”的按钮
    UIButton *pointsRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pointsRuleBtn setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    //[pointsRuleBtn setBackgroundColor:[UIColor grayColor]];
    //[pointsRuleBtn setTitle:@"积分规则..." forState:UIControlStateNormal];
    //[pointsRuleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[pointsRuleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [pointsRuleBtn addTarget:self action:@selector(pointsRuleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:pointsRuleBtn];
    
    //在导航栏右边增加一个“积分兑换”的按钮
    UIButton *exchangePointsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exchangePointsBtn setFrame:CGRectMake(kScreenWidth-70, 15, 60, 30)];
    [exchangePointsBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [exchangePointsBtn setTitle:@"积分记录" forState:UIControlStateNormal];
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
    
    PointsVC *vc = [[PointsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pointsRuleBtnClicked{
    
    PointSRuleVC *vc = [[PointSRuleVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getGiftInfo{
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getGiftAndBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                
                self.giftArray = result[@"resultInfo"];
                
                //NSLog(@"giftArray:%@",self.giftArray);
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.giftArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"ExchangePointsVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"ExchangePointsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    ExchangePointsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[ExchangePointsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.delegate = self;
    cell.giftInfoDic = self.giftArray[indexPath.section];
    
    return cell;
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 2.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105.0f;
}


#pragma mark - ExchangePointsCellDelegate
- (void)ExchangePointsCellBuyGift:(id)sender{
    NSDictionary *giftInfoDic = sender;
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] buyGiftWithParentId:userInfoDic[uUserId] andPlatformTypeId:@"202" andGiftId:giftInfoDic[@"id"] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result111:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //[UIFactory showAlert:result[@"resultInfo"]];
                [UIFactory showAlert:@"操作成功"];
                NSDictionary *giftInfoDic = result[@"resultInfo"];
                self.pointTotalLabel.text = [NSString stringWithFormat:@"积分余额:%@",giftInfoDic[@"points"]];
                self.pointExamLabel.text = [NSString stringWithFormat:@"待审核:%@",giftInfoDic[@"points_exam"]];
                NSString *pointAvailableStr = [NSString stringWithFormat:@"%i",(int)([giftInfoDic[@"points"] intValue]-[giftInfoDic[@"points_exam"] intValue])];
                self.pointAvailableLabel.text = [NSString stringWithFormat:@"可用余额:%@",pointAvailableStr];
                //发送通知，刷新我的页面
                [[NSNotificationCenter defaultCenter] postNotificationName:SettingRefresh object:self];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }
        else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}



@end
