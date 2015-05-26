//
//  MoreSettingVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MoreSettingVC.h"

@interface MoreSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MoreSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多设置";
}


- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView Delegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }
    else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"MoreSettingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    NSString *str = @"";
    
    if (indexPath.section == 0 ) {
        switch (indexPath.row) {
            case 0:
            {
                str = @"常见问题";
            }
                break;
                
            case 1:
            {
                str = @"用户协议";
            }
                break;
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
            {
                str = @"版本升级";
            }
                break;
            case 1:
            {
                str = @"关于";
            }
                break;
                
            default:
                break;
        }
        
    }
    
    cell.textLabel.text = str;
    
    return cell;
    
}



#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0;
    }
    else
    {
        return 25.0;
    }
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
