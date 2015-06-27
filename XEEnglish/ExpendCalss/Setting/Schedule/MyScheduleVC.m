//
//  MyScheduleVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyScheduleVC.h"
#import "LXSegmentViewThree.h"

#import "MyActivityCell.h"

#import "XeeService.h"

@interface MyScheduleVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) LXSegmentViewThree *mySegmentView;

@property (nonatomic, strong) UITableView *activityTableView;//我预定的活动。

@property (nonatomic, strong) NSMutableArray *activityArray;

@end

@implementation MyScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的预定";
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.activityArray = [NSMutableArray array];
    [self getMyActivityInfo];
    
    self.mySegmentView = [[LXSegmentViewThree alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.mySegmentView.tabBgImageView.image = [UIImage imageNamed:@"bg_tab_selected.png"];
    self.mySegmentView.tabButtonSeclectImageView.image = [UIImage imageNamed:@"select_flag.png"];
    self.mySegmentView.tabButtonColor = [UIColor blackColor];
    self.mySegmentView.tabButtonSelectCorlor = [UIColor redColor];
    
    [self.mySegmentView setTabButton1Title:@"课程" andButton2Title:@"活动" andButton3Title:@"场馆"];
    
    [self.view addSubview:self.mySegmentView];
    
    
    self.activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.activityTableView.backgroundColor = [UIColor clearColor];
    self.activityTableView.dataSource = self;
    self.activityTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.activityTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMyActivityInfo{
    
    [[XeeService sharedInstance] GetActivityInfoByParentIdWithPageSize:10 andPageIndex:1 andParentId:ceShiId andToken:ceShiToken andBlock:^(NSDictionary *result, NSError *error) {
        
        NSLog(@"result:%@",result);
        
        if (!error) {
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                NSLog(@"info:%@",result[@"resultInfo"]);
                self.activityArray = result[@"resultInfo"];
                [self.activityTableView reloadData];
                
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
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.activityTableView) {
        return [self.activityArray count];
    }
    else{
        return 0;
    }
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"MyActivityVCCell";
    static NSString *reuse4 = @"MyCell";
    
    if (tableView == self.activityTableView) {
        
        [tableView registerNib:[UINib nibWithNibName:@"MyActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse1];
        
        MyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[MyActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        }
        cell.cellEdge = 10;
        cell.activityinfo = self.activityArray[indexPath.section];
        
        return cell;
        
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse4];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse4];
        }
        
        return cell;
    }
}

#pragma mark - UITableView Delegate

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.activityTableView) {
        return 280.0f;
    }
    else{
        return 44.0;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 5.0f;
    }

}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
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
