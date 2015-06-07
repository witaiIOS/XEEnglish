//
//  StudentList.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "StudentList.h"

@implementation StudentList

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showTable = NO;
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,frame.size.width/2 ,kTFHeight )];
        self.textField.placeholder = @"请选择姓名";
        self.textField.textColor = [UIColor grayColor];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.font = [UIFont systemFontOfSize:kFont];
        self.textField.borderStyle = UITextBorderStyleNone;
        [self.textField addTarget:self action:@selector(DropDown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:self.textField];
    
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 0)style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor grayColor];
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.hidden = YES;
        [self addSubview:self.tableView];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;

}
- (void)DropDown

{
    [self.tableView reloadData];
    
    if (self.showTable) {
        return;
    }
    else{
        [self.textField resignFirstResponder];
        
        
        CGFloat tableHeight = kCellHeight *[self.tableList count];
        CGFloat frameHeight = 42 + tableHeight;
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        CGRect frame = self.tableView.frame;
        frame.size.height = tableHeight;
        
        [self.superview bringSubviewToFront:self];
        self.tableView.hidden = NO;
        self.showTable = YES;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
        self.frame = sf;
        self.tableView.frame = frame;
        [UIView commitAnimations];//提交动画
        
    }
    
}
@end
