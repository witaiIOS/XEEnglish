//
//  CitiesVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CitiesVC.h"
#import "CityVCCell.h"

#import "XeeService.h"

@interface CitiesVC ()

@end

@implementation CitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择城市";
}

- (void)initUI{
//    NSArray * array = [NSArray arrayWithObjects:@"武汉市",@"北京市",@"上海市",@"南京市",@"深圳市",@"广州市",@"西安市",nil] ;
//    self.citiesArray = array;
    [self getCityInfo];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web
- (void)getCityInfo{
    [self showHudOnlyMsg:@"载入中..."];
    [[XeeService sharedInstance] getCityWithBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.citiesArray = result[@"resultInfo"];
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

- (void)setCityInfoWithDepartmentId:(NSString *)department_id{
    
    NSDictionary *userInfo = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userDetialInfo = [userInfo objectForKey:uUserInfoKey];
    [[XeeService sharedInstance] setCityWithRegionalId:department_id andParentId:userDetialInfo[uUserId] andToken:userDetialInfo[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                [UIFactory showAlert:result[@"resultInfo"]];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }
        else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableView DataSource 
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.citiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CitiesCell";
    
    CityVCCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[CityVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    NSDictionary *cityInfo = self.citiesArray[indexPath.row];
    cell.cityName.text = cityInfo[@"department"];
    if ([self.selectedCity isEqualToString:cell.cityName.text]) {
        cell.selectedImageView.highlighted = YES;
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *cityInfo = self.citiesArray[indexPath.row];
    
    [self setCityInfoWithDepartmentId:cityInfo[@"department_id"]];
    
    [self.delegate SelectedCity:cityInfo[@"department"]];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0f;
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
