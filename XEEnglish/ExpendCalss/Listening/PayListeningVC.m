//
//  PayListeningVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PayListeningVC.h"

#import "BaseTVC.h"
#import "SwicthCell.h"
#import "PriceCell.h"

@interface PayListeningVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PayListeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上门送课";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }
    else if(section == 2){
        return 1;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"BaseTVC";
    static NSString *reuse2 = @"SwicthCell";
    static NSString *reuse3 = @"PriceCell";
    
    if (indexPath.section == 0) {
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.cellEdge = 10;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"课程";
                break;
            }
            case 1:
            {
                cell.textLabel.text = @"校区选择";
                break;
            }
                
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section == 2){
        
        if (indexPath.row) {
            [tableView registerNib:[UINib nibWithNibName:@"SwicthCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
            
            SwicthCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
            
            cell.myTipLabel.text = @"选择或输入小孩";
            cell.myDetailLabel.text = @"选择";
            
            return cell;
            
        }
        else{
            BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
            if (cell == nil) {
                cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.detailTextLabel.textColor = [UIColor grayColor];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.cellEdge = 10;
            cell.textLabel.text = @"选择小孩";
            return cell;
            
        }
    }else if (indexPath.section == 2){
        [tableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse3];
        
        PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        
        cell.myTipLabel.text = @"选择或输入小孩";
        cell.myDetailLabel.text = @"选择";
        
        return cell;
    }else{
        
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        }
        cell.cellEdge = 10;
        return cell;
        
    }
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





@end
