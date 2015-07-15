//
//  CouponsVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CouponsVC.h"
#import "CouponsCell.h"

#import "XeeService.h"

@interface CouponsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *couponsArray;//所有现金券
@property (nonatomic, strong) NSMutableArray *couponsUsedArray;//使用现金券数组

@end

@implementation CouponsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的优惠券";
    
}

- (void)initUI{
    [super initUI];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setFrame:CGRectMake(kScreenWidth-60, 17, 40, 30)];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeBtn setBackgroundColor:[UIColor clearColor]];
    [completeBtn addTarget:self action:@selector(completeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *completeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBarBtn;
    
    [self  getMyCouponWithWeb];
    
    self.couponsArray = [[NSMutableArray alloc] init];//接受网络请求的所有的现金券
    
    self.couponsUsedArray = [[NSMutableArray alloc] init];//使用现金券，初始化
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyAction
- (void)completeBtnClicked{
    //将现金券数字序列化
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.couponsUsedArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //将序列化的现金券数组，传给购买页
    [self.delegate couponsUsed:text andCouponsArray:self.couponsUsedArray];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Web
- (void)getMyCouponWithWeb{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] getMyCouponWithParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.couponsArray = result[@"resultInfo"];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.couponsArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CouponsCellIdentifier";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CouponsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[CouponsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.couponsInfoDic = self.couponsArray[indexPath.section];
    
    return cell;
}



#pragma mark - UITableView Delegate
- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.coursePrice == 0) {
        [UIFactory showAlert:@"您还未选择课程"];
    }
    else{
        
        NSDictionary *selectedCoupon = self.couponsArray[indexPath.section];
        NSNumber *statusNum = selectedCoupon[@"status"];
        //获取加入这个新的现金券之后的总额
        NSInteger addOtherCouponTotalPrice = [self getCurrentTotalcouponsPriceAddOtherCoupon:self.couponsArray[indexPath.section]];
        if (addOtherCouponTotalPrice > self.coursePrice) {
            [UIFactory showAlert:@"使用该现金券将使现金券额度大于应付款总额，不被允许"];
        }
        else{
            
            if (statusNum.integerValue == 0) {
                CouponsCell *cell = (CouponsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                cell.iconButton.selected = !cell.iconButton.selected;
                
                if (cell.iconButton.selected == YES) {
                    [self.couponsUsedArray addObject:self.couponsArray[indexPath.section]];
                }
                else{
                    [self.couponsUsedArray removeObject:self.couponsArray[indexPath.section]];
                }
            }
            
        }
        
    }
    
    
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else
        return 5.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}



#pragma mark - My Action
//获取加入这个新的现金券之后的总额
-(NSInteger)getCurrentTotalcouponsPriceAddOtherCoupon:(NSDictionary *)addCouponDic{
    
    NSInteger currentTotalcouponsPrice = 0;//当前已选的现金券的总额
    
    for (int i = 0; i<self.couponsUsedArray.count; i++) {
        NSDictionary *couponDic = self.couponsUsedArray[i];
        NSString *couponPrice = [NSString stringWithFormat:@"%@",couponDic[@"price"]];
        currentTotalcouponsPrice = currentTotalcouponsPrice + [couponPrice intValue];
    }
    
    NSInteger addCouponPrice = 0;//新增的现金券额度
    NSString *addCouponPriceStr = [NSString stringWithFormat:@"%@",addCouponDic[@"price"]];
    addCouponPrice = [addCouponPriceStr intValue];
    
    NSInteger addCouponTotalPrice = 0;//新增了现金券之后的总额
    addCouponTotalPrice = currentTotalcouponsPrice + addCouponPrice;
    
    return addCouponTotalPrice;
}

@end
