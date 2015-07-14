//
//  MyScheduleVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyScheduleVC.h"
#import "LXSegmentViewThree.h"

#import "ExpendRecordCell.h"
#import "MyActivityCell.h"
#import "MyBookSiteCell.h"

#import "XeeService.h"

@interface MyScheduleVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) LXSegmentViewThree *mySegmentView;

@property (nonatomic, strong) UITableView *courseTableView;//我预定的课程
@property (nonatomic, strong) NSMutableArray *courseArray;//

@property (nonatomic, strong) UITableView *activityTableView;//我预定的活动。
@property (nonatomic, strong) NSMutableArray *activityArray;

@property (nonatomic, strong) UITableView *bookSiteTableView;//我预定的场馆
@property (nonatomic, strong) NSMutableArray *bookSiteArray;

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
    
    self.courseArray = [NSMutableArray array];
    [self getMyCourseInfo];
    
    self.activityArray = [NSMutableArray array];
    [self getMyActivityInfo];
    
    self.bookSiteArray = [NSMutableArray array];
    [self getMyBookSiteInfo];
    
    
    self.mySegmentView = [[LXSegmentViewThree alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.mySegmentView.tabBgImageView.image = [UIImage imageNamed:@"bg_tab_selected.png"];
    self.mySegmentView.tabButtonSeclectImageView.image = [UIImage imageNamed:@"select_flag.png"];
    self.mySegmentView.tabButtonColor = [UIColor blackColor];
    self.mySegmentView.tabButtonSelectCorlor = [UIColor redColor];
    
    [self.mySegmentView setTabButton1Title:@"课程" andButton2Title:@"活动" andButton3Title:@"场馆"];
    
    [self.view addSubview:self.mySegmentView];
    
    self.courseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.courseTableView.backgroundColor = [UIColor clearColor];
    self.courseTableView.dataSource = self;
    self.courseTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.courseTableView];
    
    self.activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.activityTableView.backgroundColor = [UIColor clearColor];
    self.activityTableView.dataSource = self;
    self.activityTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.activityTableView];
    
    self.bookSiteTableView = [[UITableView alloc] initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.bookSiteTableView.backgroundColor = [UIColor clearColor];
    self.bookSiteTableView.dataSource = self;
    self.bookSiteTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.bookSiteTableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMyCourseInfo{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getVOrderByParentIdWithParentId:userInfoDic[uUserId] andSort:@"" andOrder:@"" andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                NSDictionary *courseDic = result[@"resultInfo"];
                
                self.courseArray = courseDic[@"data"];
                //NSLog(@"array:%@",self.courseArray);
                [self.courseTableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


- (void)getMyActivityInfo{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] GetActivityInfoByParentIdWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        //NSLog(@"result:%@",result);
        
        if (!error) {
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                //NSLog(@"info:%@",result[@"resultInfo"]);
                NSDictionary *activityDic = result[@"resultInfo"];
                self.activityArray = activityDic[@"data"];
                //NSLog(@"activityArray:%@",self.activityArray);
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

- (void)getMyBookSiteInfo{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getBookSiteByParent_idWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        //NSLog(@"result:%@",result);
        
        if (!error) {
            //NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                //NSLog(@"info:%@",result[@"resultInfo"]);
                NSDictionary *mybookSiteDic= result[@"resultInfo"];
                self.bookSiteArray = mybookSiteDic[@"data"];
                //NSLog(@"bookSiteArray:%@",self.bookSiteArray);
                [self.bookSiteTableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"未知错误"];
        }
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.courseTableView) {
        //NSLog(@"activityArray:%li",(unsigned long)self.activityArray.count);
        return [self.courseArray count];
    }
    else if (tableView == self.activityTableView) {
        //NSLog(@"activityArray:%li",(unsigned long)self.activityArray.count);
        return [self.activityArray count];
    }
    else if (tableView == self.bookSiteTableView){
        //NSLog(@"bookSiteArray:%li",(unsigned long)self.bookSiteArray.count);
        return [self.bookSiteArray count];
    }
    else{
        return 0;
    }
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"ExpendRecordVCCell";
    static NSString *reuse2 = @"MyActivityVCCell";
    static NSString *reuse3 = @"MyBookSiteVCCell";
    static NSString *reuse4 = @"MyCell";
    
    if (tableView == self.courseTableView) {
        
        [tableView registerNib:[UINib nibWithNibName:@"ExpendRecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse1];
        
        ExpendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[ExpendRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        }
        cell.cellEdge = 10;
        cell.expendRecordInfoDic = self.courseArray[indexPath.section];
        
        return cell;
        
    }
    
    else if (tableView == self.activityTableView) {
        
        [tableView registerNib:[UINib nibWithNibName:@"MyActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
        
        MyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        if (cell == nil) {
            cell = [[MyActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
        }
        cell.cellEdge = 10;
        cell.activityinfo = self.activityArray[indexPath.section];
        
        return cell;
        
    }
    else if (tableView == self.bookSiteTableView){
        
        [tableView registerNib:[UINib nibWithNibName:@"MyBookSiteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse3];
        
        MyBookSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        
        if (cell == nil) {
            cell = [[MyBookSiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
        }
        cell.cellEdge = 10;
        cell.bookSiteInfoDic = self.bookSiteArray[indexPath.section];
        
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
    
    if (tableView == self.courseTableView) {
        return 190.0f;
    }
    else if (tableView == self.activityTableView) {
        return 280.0f;
    }
    else if (tableView == self.bookSiteTableView){
        return 140.0f;
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
