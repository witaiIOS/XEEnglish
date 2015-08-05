//
//  OrderPayVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/7/19.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderPayVC.h"

@interface OrderPayVC ()

@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)nextBtnClicked:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    
    if (indexPath.row == 1) {//微信支付
        [self wxPayWithOutTradeNo:self.out_trade_no];
    }
    else {//支付宝支付
        
        [self aliyPayWithOutTradeNo:self.out_trade_no];
    }
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 2;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"PaymoneyCell";
    static NSString *reuse2 = @"PayMethodCell";
    static NSString *reuse3 = @"BaseCell";
    
    if (indexPath.section == 0) {
        PaymoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[PaymoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            cell.myLabel.text = @"支付金额";
            cell.myMoneyLabel.text = [NSString stringWithFormat:@"%i",self.payMoney];
            cell.cellEdge = 10;
        }
        
        return cell;
    }
    else if (indexPath.section == 1){
        PayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        if (cell == nil) {
            cell = [[PayMethodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.myPayMethodImageView.image = [UIImage imageNamed:@"pay_01.png"];
                cell.myPayMethodLabel.text = @"支付宝支付";
                break;
            }
            case 1:
            {
                cell.myPayMethodImageView.image = [UIImage imageNamed:@"pay_03.png"];
                cell.myPayMethodLabel.text = @"微信支付";
                break;
            }
                
            default:
                break;
        }
        return cell;
    }
    else{
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            cell.cellEdge = 10;
        }
        
        return cell;
    }
}

@end
