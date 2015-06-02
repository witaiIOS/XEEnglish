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
                aboutDetailText = @"xiaenyingyu";
            }
                break;
            case 1:
            {
                aboutText = @"新浪微博";
                aboutDetailText = @"xiaenyingyu@sina.com";
            }
                break;
            case 2:
            {
                aboutText = @"公司网址";
                aboutDetailText = @"http://www.xiaenyingyu.com";
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
    
    return 500.0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *headerString = @"关注我们的官方微信和微博,参加我们的活动,即有机会获得金币积分~";
    return headerString;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UILabel *footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, kScreenHeight-40, kScreenWidth/3, 40)];
    
    footerLabel.text = @"@ 2015 夏恩英语";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor darkGrayColor];
    footerLabel.font = [UIFont systemFontOfSize:11];
    
    return footerLabel;
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
