//
//  AboutVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于";
    
}

- (void)initUI
{
    [super initUI];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"AboutCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
        
        //cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        //cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    
    NSString *aboutText = nil;
    NSString *aboutDetailText = nil;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                aboutText = @"微信关注";
                aboutDetailText = @"idealangel-shane";
            }
                break;
            case 1:
            {
                aboutText = @"新浪微博";
                aboutDetailText = @"爱迪天才宝贝学习中心";
            }
                break;
            case 2:
            {
                aboutText = @"公司网址";
                aboutDetailText = @"http://www.idealangel.cn";
            }
                break;
                
            default:
                break;
        }
    }
    
    cell.textLabel.text = aboutText;
    cell.detailTextLabel.text = aboutDetailText;
    
    return cell;
    
}

#pragma mark - UITableView Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 55.0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return kScreenHeight-178-64;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *headerString = @"关注我们的官方微信和微博,参加我们的活动,即有机会获得金币积分~";
    return headerString;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth,80)];
    UILabel *footerLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-178-64-80, kScreenWidth, 30)];
    
    footerLabel1.text = @"Copyright@2008-2013";
    footerLabel1.textAlignment = NSTextAlignmentCenter;
    footerLabel1.textColor = [UIColor darkGrayColor];
    footerLabel1.font = [UIFont systemFontOfSize:11];
    [view addSubview:footerLabel1];
    
    UILabel *footerLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-178-64-50, kScreenWidth, 30)];
    
    footerLabel2.text = @"IdealAngel China.All Rigths Reserved";
    footerLabel2.textAlignment = NSTextAlignmentCenter;
    footerLabel2.textColor = [UIColor darkGrayColor];
    footerLabel2.font = [UIFont systemFontOfSize:11];
    [view addSubview:footerLabel2];
    
    return view;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
