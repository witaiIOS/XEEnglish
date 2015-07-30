//
//  DropDown.m
//  DropDown1
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 aprees. All rights reserved.
//
#define btnHeight 40

#import "DropDown.h"

@interface DropDown ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation DropDown

- (id)initWithFrame:(CGRect)frame{
    
    if (frame.size.height < 145) {
        self.frameHeight = 145;
    }
    else{
        self.frameHeight = frame.size.height;
    }
    
    self.tabHeight = self.frameHeight - 40;
    
    frame.size.height = 40.0f;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showList = NO;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 0)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor grayColor];
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.hidden = YES;
        [self addSubview:self.tableView];
        
        self.tabBtn = [DropButton buttonWithType:UIButtonTypeCustom];
        [self.tabBtn setFrame:CGRectMake(0, 0, frame.size.width, 40)];
        self.tabBtn.backgroundColor = [UIColor orangeColor];
        [self.tabBtn setImage:[UIImage imageNamed:@"ic_arrow_down_black.png"] forState:UIControlStateNormal];
        
        [self.tabBtn addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.tabBtn];
    }
    return self;
}

- (void)dropdown{
    
    if (self.showList) {
        return;
    }
    else{
        
        CGRect sf = self.frame;
        sf.size.height = self.frameHeight;
        [self.superview bringSubviewToFront:self];
        self.tableView.hidden = NO;
        self.showList = YES;
        
        CGRect frame = self.tableView.frame;
        //frame.size.height = 0;//看着没用
        //self.tableView.frame = frame;//看着没用
        frame.size.height = self.tabHeight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
        self.frame = sf;
        self.tableView.frame = frame;
        [UIView commitAnimations];//提交动画
    }
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSDictionary *dic = [self.tableArray objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = dic[@"name"];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 35.0f;
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [self.tableArray objectAtIndex:[indexPath row]];
    
    [self.tabBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
    self.showList = NO;
    self.tableView.hidden =YES;
    CGRect sf = self.frame;
    sf.size.height = 40.0f;
    self.frame = sf;
    CGRect frame = self.tableView.frame;
    frame.size.height = 0;
    self.tableView.frame = frame;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     // Return YES for supported orientations
     return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
