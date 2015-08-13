//
//  SetCommunityVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SetCommunityVC.h"
#import "SetCommunityCell.h"
#import "XeeService.h"

@interface SetCommunityVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *communityArray;
@end

@implementation SetCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置小区";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化数组
    self.communityArray = [NSMutableArray array];
    
    //请求数据
    [self getCommunityWithSearchContent:@""];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Web
- (void)getCommunityWithSearchContent:(NSString *)search_content{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"载入中"];
    [[XeeService sharedInstance] getCommunityWithParentId:userInfoDic[uUserId] andSearchContent:search_content andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //NSLog(@"result:%@",result);
                NSDictionary *comminutyDic = result[@"resultInfo"];
                self.communityArray = comminutyDic[@"data"];
                
                [self.tableView reloadData];
            }else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.communityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"SetCommunityVCCell";
    
    SetCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[SetCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.communityNameLabel.text = [self.communityArray[indexPath.row] objectForKey:@"name"];
    NSNumber *cellId = [self.communityArray[indexPath.row] objectForKey:@"community_id"];
    if ([self.selectedCommunityId integerValue] == cellId.integerValue) {
        cell.selectedImageView.highlighted = YES;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate setCommunityVCSelectedCommunity:self.communityArray[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}


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
