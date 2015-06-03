//
//  ActivityVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityVC.h"
#import "ActivityCell.h"

#import "SchedulePlace.h"

@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)initUI{
    [super initUI];
    NSString *leftString = @"当前活动";
    NSString *rightString = @"历史活动";
    
    
    UISegmentedControl *mySegmented = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:leftString,rightString, nil]];
    [mySegmented setFrame:CGRectMake(0, 65, kScreenWidth, 40)];
    mySegmented.selectedSegmentIndex = 0;
    mySegmented.backgroundColor = [UIColor whiteColor];
    [mySegmented addTarget:self action:@selector(SegmentedAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:mySegmented];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 110, kScreenWidth-20, kScreenHeight-110) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.rowHeight = 140;
    
    [self.view addSubview: self.tableView];
    
    UIButton *reservePlaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reservePlaceBtn setFrame:CGRectMake(kScreenWidth-90, 15, 80, 30)];
    reservePlaceBtn.backgroundColor = [UIColor orangeColor];
    [reservePlaceBtn setTitle:@"场馆预定" forState:UIControlStateNormal];
    [reservePlaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reservePlaceBtn addTarget:self action:@selector(reservePlaceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *reservePlaceBarBtn = [[UIBarButtonItem alloc] initWithCustomView:reservePlaceBtn];
    self.navigationItem.rightBarButtonItem = reservePlaceBarBtn;
    
}

- (void)reservePlaceBtnAction{
    
    SchedulePlace *vc = [[SchedulePlace alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}


#pragma mark - UITableView DataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"CellActivityIdentifier";
    
    //    static BOOL nibsRegistered = NO;
    //    if (!nibsRegistered) {
    //        UINib *nib = [UINib nibWithNibName:@"ActivityCell" bundle:nil];
    //        [tableView registerNib:nib forCellReuseIdentifier:reuse];
    //        nibsRegistered = YES;
    //    }
    [tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[ActivityCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:reuse];
    }
    
    return cell;
}



#pragma mark - My Action
- (void)SegmentedAction:(UISegmentedControl *)seg{
    
    
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
