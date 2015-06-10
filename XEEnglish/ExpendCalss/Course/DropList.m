//
//  DropList.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DropList.h"

@implementation DropList
- (void)initiation:(CGRect)frame andTextField:(NSString*)text{
    
    self.frame = frame;
    
    self.showTable = NO;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x, 0,frame.size.width,kTFHeight )];
    //self.textField.placeholder = @"请选择姓名";
    self.textField.textColor = [UIColor grayColor];
    self.textField.text = text;
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.font = [UIFont systemFontOfSize:kFont];
    self.textField.borderStyle = UITextBorderStyleNone;
    [self.textField addTarget:self action:@selector(DropDown) forControlEvents:UIControlEventAllTouchEvents];
    self.textField.delegate = self;
    //self.textField.enabled = NO;
    [self addSubview:self.textField];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.backgroundColor = [UIColor grayColor];
    //self.tableView.separatorColor = [UIColor lightGrayColor];
    
    [self addSubview:self.tableView];
    
    self.backgroundColor = [UIColor orangeColor];
}

- (void)DropDown {
    
    self.showTable = !self.showTable;
    
    if (!self.showTable) {//收起
        //self.tableView.frame = CGRectZero;
        self.tableView.hidden = YES;
        return;
    }
    else{//展示
        //[self.textField resignFirstResponder];
        self.tableView.hidden = NO;
        
        
        CGFloat tableHeight = kCellHeight *[self.tableList count];
        
        self.tableView.frame = CGRectMake(0, self.textField.frame.size.height, self.textField.frame.size.width, tableHeight);
        NSLog(@"%f", self.textField.frame.size.width);
        
        
        [self.superview bringSubviewToFront:self];
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
        
        CGRect selfFrame = self.frame;
        selfFrame.size.height = tableHeight + kTFHeight;
        self.frame = selfFrame;
        
        [UIView commitAnimations];//提交动画
        
    }
    
}

#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.tableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
       
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:kFont];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
     cell.textLabel.text = self.tableList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.textField.text = self.tableList[indexPath.row];
    
    
}


#pragma mark - UItextFielddelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

@end
