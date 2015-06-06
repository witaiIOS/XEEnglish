//
//  WHSegmentView.m
//  XEEnglish
//
//  Created by houjing on 15/6/5.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "WHSegmentView.h"

#define kTFHeight 40
#define kFont 14
#define kCellHeight 35.0f

@implementation WHSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.showStudentsList = NO;
        self.showCoursesList = NO;
        
        self.tabTFImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 42)];
        
//        self.studentsArray = [[NSArray alloc] initWithObjects:@"小明",@"小华",@"小刚", nil];
//        self.coursesArray = [[NSArray  alloc] initWithObjects:@"CP",@"CK",@"CL",@"CH",@"CJ", nil];
        
        self.textFieldStudent = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,frame.size.width/2 ,kTFHeight )];
        self.textFieldStudent.placeholder = @"请选择姓名";
        self.textFieldStudent.textColor = [UIColor grayColor];
        self.textFieldStudent.textAlignment = NSTextAlignmentCenter;
        self.textFieldStudent.font = [UIFont systemFontOfSize:kFont];
        self.textFieldStudent.borderStyle = UITextBorderStyleNone;
        [self.textFieldStudent addTarget:self action:@selector(DropDown1) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:self.textFieldStudent];
        
        self.textFieldCourse = [[UITextField alloc] initWithFrame:CGRectMake(frame.size.width/2, 0,frame.size.width/2 ,kTFHeight )];
        self.textFieldCourse.placeholder = @"请选择课程";
        self.textFieldCourse.textColor = [UIColor grayColor];
        self.textFieldCourse.textAlignment = NSTextAlignmentCenter;
        self.textFieldCourse.font = [UIFont systemFontOfSize:kFont];
        self.textFieldCourse.borderStyle = UITextBorderStyleNone;
        [self.textFieldCourse addTarget:self action:@selector(DropDown2) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:self.textFieldCourse];
        
        self.tabTFSeclectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, frame.size.width/2, 4)];
        
        self.tableViewStudent = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 0)style:UITableViewStyleGrouped];
        self.tableViewStudent.delegate = self;
        self.tableViewStudent.dataSource = self;
        self.tableViewStudent.backgroundColor = [UIColor grayColor];
        self.tableViewStudent.separatorColor = [UIColor lightGrayColor];
        self.tableViewStudent.hidden = YES;
        [self addSubview:self.tableViewStudent];
        
        self.tableViewCourse = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 0)style:UITableViewStyleGrouped];
        self.tableViewCourse.delegate = self;
        self.tableViewCourse.dataSource = self;
        self.tableViewCourse.backgroundColor = [UIColor grayColor];
        self.tableViewCourse.separatorColor = [UIColor lightGrayColor];
        self.tableViewCourse.hidden = YES;
        [self addSubview:self.tableViewCourse];
        
        self.backgroundColor = [UIColor whiteColor];

    }
    
    return self;

}

- (void)DropDown1

{
    self.currentIndex = 0;
    [self.tableViewStudent reloadData];

    if (self.showStudentsList) {
        return;
    }
    else{
        [self.textFieldStudent resignFirstResponder];
        //NSLog(@"%0.0f",(self.textFieldStudent.frame.origin.x));
        //NSLog(@"%0.0f",(self.frame.size.width/2));
        
        self.tableHeight = kCellHeight *[self.studentsArray count];
        self.frameHeight = 42 + self.tableHeight;
        
        CGRect sf = self.frame;
        sf.size.height = self.frameHeight;
        CGRect frame = self.tableViewStudent.frame;
        frame.size.height = self.tableHeight;
        
        [self.superview bringSubviewToFront:self];
        self.tableViewStudent.hidden = NO;
        self.showStudentsList = YES;
        self.showCoursesList = NO;
        self.tableViewCourse.hidden = YES;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
        self.frame = sf;
        self.tableViewStudent.frame = frame;
        [UIView commitAnimations];//提交动画
        
    }
    
}


- (void)DropDown2{
    
    self.currentIndex = 1;
    [self.tableViewCourse reloadData];
    
    if (self.showCoursesList) {
        return;
    }
    else{
        [self.textFieldCourse resignFirstResponder];
        //NSLog(@"%0.0f",(self.textFieldCourse.frame.origin.x));
        //NSLog(@"%0.0f",(self.frame.size.width/2));
        self.tableHeight = kCellHeight *[self.coursesArray count];
        self.frameHeight = 42 + self.tableHeight;
        
        CGRect sf = self.frame;
        sf.size.height = self.frameHeight;
        CGRect frame = self.tableViewCourse.frame;
        frame.size.height = self.tableHeight;
        
        [self.superview bringSubviewToFront:self];
        self.tableViewCourse.hidden = NO;
        self.showCoursesList = YES;
        self.showStudentsList = NO;
        self.tableViewStudent.hidden = YES;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
        self.frame = sf;
        self.tableViewCourse.frame = frame;
        [UIView commitAnimations];//提交动画
        
    }

}



#pragma mark - set
//- (void)setTabTFColor:(UIColor *)tabTFColor{
//    
//    if (self.tabTFColor != tabTFColor) {
//        self.tabTFColor = tabTFColor;
//        
//        self.textFieldStudent.textColor = tabTFColor;
//        self.textFieldCourse.textColor = tabTFColor;
//    }
//}



#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.currentIndex == 0) {
        return [self.studentsArray count];
    }
    else if(self.currentIndex == 1){
        return [self.coursesArray count];
    }
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"StudentCell";
    static NSString *reuse2 = @"CourseCell";
    static NSString *reuse3 = @"Cell";
    
    UITableViewCell *cell = nil;
    
    if (self.currentIndex == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        cell.textLabel.text = self.studentsArray[indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:kFont];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }
    else if (self.currentIndex == 1){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
        cell.textLabel.text = self.coursesArray[indexPath.row];
        //NSLog(@"%li",[self.coursesArray count]);
        //NSLog(@"%@",cell.textLabel.text);
        
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:kFont];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
        }
    return cell;
        
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.currentIndex == 0) {
        [self.textFieldStudent becomeFirstResponder];
        [self.textFieldCourse resignFirstResponder];
        self.textFieldStudent.text = self.studentsArray[indexPath.row];
        self.showStudentsList = NO;
        self.tableViewStudent.hidden = YES;
        CGRect frame = self.tableViewStudent.frame;
        frame.size.height = 0;
        self.tableViewStudent.frame = frame;
        
   
    }
    else{
        [self.textFieldCourse becomeFirstResponder];
        [self.textFieldStudent resignFirstResponder];
        self.textFieldCourse.text = self.coursesArray[indexPath.row];
        //NSLog(@"%@",self.textFieldCourse.text);
        self.showCoursesList = NO;
        self.tableViewCourse.hidden = YES;
        CGRect frame = self.tableViewCourse.frame;
        frame.size.height = 0;
        self.tableViewCourse.frame = frame;
        
    }
    
    CGRect sf = self.frame;
    sf.size.height = 42;
    self.frame = sf;
      
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
}


@end
