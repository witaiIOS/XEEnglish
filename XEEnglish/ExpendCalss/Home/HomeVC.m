//
//  HomeVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeVC.h"
#import "HomeBtnCell.h"
#import "HomeAdCell.h"
#import "XeeService.h"

#import "AllCoursesVC.h"
#import "SingleCourseVC.h"

@interface HomeVC ()<HomeBtnCellDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *serviceInfos;
@property (strong, nonatomic) NSArray *adInfos;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _adInfos = [[NSArray alloc] init];
    _serviceInfos = [[NSArray alloc] init];
    
//    [[XeeService sharedInstance] getHomeServiceWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
//        if (error) {
//            [UIFactory showAlert:@"网络错误"];
//        }
//        else{
//            if ([result integerValue] == 0) {
//                _serviceInfos = [resultInfo mutableCopy];
//                [self.tableView reloadData];
//            }
//            else{
//                [UIFactory showAlert:@"未知错误"];
//            }
//        }
//
//    }];
//    [self showHudWithMsg:@"载入中..."];
//    [[XeeService sharedInstance] getHomeAdWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
//        [self hideHud];
//        if (error) {
//            NSLog(@"网络错误");
//        }
//        else{
//            if ([result integerValue] == 0) {
//                _adInfos = [resultInfo mutableCopy];
//                [self.tableView reloadData];
//            }
//            else{
//                NSLog(@"resultInfo = 1");
//            }
//            
//        }
//
//    }];
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getAdAndBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                self.adInfos = result[@"resultInfo"];
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
        
    
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseListAppHomeAndBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                self.serviceInfos = result[@"resultInfo"];
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

- (void)initUI{
    
    [super initUI];
    
    UIButton *servicePhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [servicePhoneBtn setFrame:CGRectMake(kScreenWidth-40, 17, 30, 30)];
    [servicePhoneBtn setImage:[UIImage imageNamed:@"s_phone.png"] forState:UIControlStateNormal];
    [servicePhoneBtn addTarget:self action:@selector(servicePhoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *servicePhoneBarBtn = [[UIBarButtonItem alloc] initWithCustomView:servicePhoneBtn];
    self.navigationItem.rightBarButtonItem = servicePhoneBarBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyAction

- (void)servicePhoneBtnClicked{
    
    //呼叫
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4000999027"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return (_serviceInfos.count+1)/2;
    }
    else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"HomeAdCell_Identifier";
    static NSString *CellIdentifier2 = @"HomeBntCell_Identifier";
    
    UITableViewCell *cell = nil;

    
    if (indexPath.section == 0) {//ad
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[HomeAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        ((HomeAdCell *)cell).adArray = _adInfos;
        
        return cell;
        
        
    }
    else if (indexPath.section == 1){//bnt
        HomeBtnCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if(cell2 == nil){
            cell2 = [[HomeBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        cell2.delegate = self;
        cell2.serviceDic1 = [_serviceInfos objectAtIndex:2*(indexPath.row)];
        
        if ( (2*(indexPath.row)+1) < _serviceInfos.count) {
            cell2.serviceDic2 = [_serviceInfos objectAtIndex:2*(indexPath.row)+1];
        }
        else{
            cell2.serviceDic2 = nil;
        }

        return cell2;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        return cell;
    }
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return 160;
    }
    else if (indexPath.section == 1){
        return 120;
    }
    else{
        return 44;
    }
}

#pragma mark - HomeBtnCell delegate
- (void)HomeBtnCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic{
    
    //UIButton *button = (UIButton *)sender;
    //NSLog(@"button.tag:%li",(long)button.tag);
    //NSLog(@"serviceDic:%@",serviceDic);
    
    NSString *courseIdStr = [NSString stringWithFormat:@"%@",serviceDic[@"course_id"]];
    if([courseIdStr isEqualToString:@"0"]){
        AllCoursesVC *vc = [[AllCoursesVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = [serviceDic objectForKey:@"title"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        SingleCourseVC *vc = [[SingleCourseVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = [serviceDic objectForKey:@"title"];
        vc.courseId = courseIdStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
