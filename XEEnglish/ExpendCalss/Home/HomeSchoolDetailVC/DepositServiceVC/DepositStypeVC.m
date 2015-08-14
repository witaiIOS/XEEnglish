//
//  DepositStypeVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//
#define IsTransfer   @"IsTransfer"  //是否接送
#define DepositStype @"DepositStype"  //托管类型

#import "DepositStypeVC.h"
#import "DepositStypeCell.h"

@interface DepositStypeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *stypeArray;

@end

@implementation DepositStypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _nTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    [super initUI];
    
    if ([_index isEqualToString:IsTransfer]) {
        self.stypeArray = @[@"是",@"否"];
    }
    else if ([_index isEqualToString:DepositStype]){
        self.stypeArray = @[@"半托",@"全托"];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"DepositStypeCell";
    
    DepositStypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[DepositStypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.cellEdge = 10;
    }
    
    cell.stypeLabel.text = self.stypeArray[indexPath.section];
    if ([self.selectedStype isEqualToString:cell.stypeLabel.text]) {
        cell.selectImageView.highlighted = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate DepositStypeVCSelectedDepositStype:self.stypeArray[indexPath.section] index:_index];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5.0f;
    }
    else{
        return 2.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

@end
