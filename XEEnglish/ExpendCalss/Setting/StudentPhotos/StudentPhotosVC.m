//
//  StudentPhotosVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "StudentPhotosVC.h"

@interface StudentPhotosVC ()
@property (nonatomic, strong) DropDown *tabButton;
@end

@implementation StudentPhotosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宝宝相册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    NSArray *array = [[UserStudent sharedUser] getUserStudentArray];
    //NSLog(@"array:%@",array);
    self.tabButton = [[DropDown alloc] initWithFrame:CGRectMake(kScreenWidth-80, 14, 70, 35*array.count+40)];
    //self.mydd.textField.placeholder = @"请输入联系方式";
    self.tabButton.tableArray = array;
    [self.tabButton.tabBtn setTitle:[array[0] objectForKey:@"name"] forState:UIControlStateNormal];
    
    UIBarButtonItem *tabBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.tabButton];
    self.navigationItem.rightBarButtonItem = tabBarButton;
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
