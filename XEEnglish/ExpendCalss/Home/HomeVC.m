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
    
    [[XeeService sharedInstance] getHomeAdWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
        if (error) {
            NSLog(@"网络错误");
        }
        else{
            if ([result integerValue] == 0) {
                _adInfos = [resultInfo mutableCopy];
                [self.tableView reloadData];
            }
            else{
                NSLog(@"resultInfo = 1");
            }
            
        }

    }];
    
    [[XeeService sharedInstance] getCourseListAppHomeAndBlock:^(NSDictionary *result, NSError *error) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        ((HomeBtnCell *)cell).delegate = self;
        ((HomeBtnCell *)cell).serviceDic1 = [_serviceInfos objectAtIndex:2*(indexPath.row)];
        
        if ( (2*(indexPath.row)+1) < _serviceInfos.count) {
            ((HomeBtnCell *)cell).serviceDic2 = [_serviceInfos objectAtIndex:2*(indexPath.row)+1];
        }
        else{
            ((HomeBtnCell *)cell).serviceDic2 = nil;
        }

        return cell;
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
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        SingleCourseVC *vc = [[SingleCourseVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
