//
//  StudentPhotosVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "StudentPhotosVC.h"

@interface StudentPhotosVC ()<UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, strong) DropDown *tabButton;
@property (strong, nonatomic) DropButton *dropButton;
@property (strong, nonatomic) UITableView *dropTableView;
@property (strong, nonatomic) NSArray *dropTableList;

@property (nonatomic, assign) BOOL showList;

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
    
   /* NSArray *array = [[UserStudent sharedUser] getUserStudentArray];
    //NSLog(@"array:%@",array);
    self.tabButton = [[DropDown alloc] initWithFrame:CGRectMake(kScreenWidth-80, 14, 70, 35*array.count+40)];
    //self.mydd.textField.placeholder = @"请输入联系方式";
    self.tabButton.tableArray = array;
    [self.tabButton.tabBtn setTitle:[array[0] objectForKey:@"name"] forState:UIControlStateNormal];
    
    UIBarButtonItem *tabBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.tabButton];
    self.navigationItem.rightBarButtonItem = tabBarButton;*/
    
    
    _dropTableList = [[UserStudent sharedUser] getUserStudentArray];
    
    /*********************************dropButton***********************************/
    _dropButton = [DropButton buttonWithType:UIButtonTypeCustom];
    [_dropButton setFrame:CGRectMake(0, 2, 70, 40)];
    [_dropButton setImage:[UIImage imageNamed:@"ic_arrow_down_black.png"] forState:UIControlStateNormal];
    [_dropButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
    [_dropButton setTitle:[_dropTableList[0] objectForKey:@"name"] forState:UIControlStateNormal];
    
    UIBarButtonItem *tabBarButton = [[UIBarButtonItem alloc] initWithCustomView:_dropButton];
    self.navigationItem.rightBarButtonItem = tabBarButton;
    
    /*********************************dropTableView***********************************/
    _dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 0) style:UITableViewStyleGrouped];
    _dropTableView.delegate = self;
    _dropTableView.dataSource = self;
    _dropTableView.backgroundColor = [UIColor clearColor];
    _dropTableView.separatorColor = [UIColor lightGrayColor];
    _dropTableView.hidden = YES;
    [self.view addSubview:_dropTableView];

}

#pragma mark - action
- (void)dropdown {
    if (self.showList) {
        return;
    }
    else{
        
        _dropTableView.hidden = NO;
        self.showList = YES;
        
        CGRect frame = _dropTableView.frame;
        //frame.size.height = 0;//看着没用
        //self.tableView.frame = frame;//看着没用
        frame.size.height = kScreenHeight-64;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
    
        _dropTableView.frame = frame;
        [UIView commitAnimations];//提交动画
    }

}

#pragma mark - tableView datasouce delegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dropTableList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.accessoryType = UITableViewCellAccessoryNone;
        //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSDictionary *dic = [_dropTableList objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = dic[@"name"];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0f;
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [_dropTableList objectAtIndex:[indexPath row]];
    
    [_dropButton setTitle:dic[@"name"] forState:UIControlStateNormal];
    self.showList = NO;
    _dropTableView.hidden =YES;
    
    CGRect frame = _dropTableView.frame;
    frame.size.height = 0;
    _dropTableView.frame = frame;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

@end
