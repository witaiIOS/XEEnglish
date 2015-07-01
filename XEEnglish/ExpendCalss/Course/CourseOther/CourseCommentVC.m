//
//  CourseCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseCommentVC.h"

@interface CourseCommentVC ()//<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;
//
//@property (nonatomic, strong) UILabel *userNameLabel;



@end

@implementation CourseCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评论";
}

- (void)initUI{
    
    [super initUI];
    
//    self.tableView
//    
//    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
//    self.userNameLabel.text = @"用户名";
//    self.userNameLabel.font = [UIFont systemFontOfSize:14];
//    self.userNameLabel.textColor = [UIColor lightGrayColor];
//    
//    [self.view addSubview:self.userNameLabel];
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
