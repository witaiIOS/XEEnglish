//
//  Course.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseVC.h"
#import "StudentList.h"

@interface CourseVC ()

@property (nonatomic, strong) StudentList *students;

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)initUI{
    
    [super initUI];
    self.students = [[StudentList alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth/2, 44)];
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"小明",@"小华",@"小刚", nil];
    self.students.tableList = array1;
//    NSArray *array2 = [[NSArray  alloc] initWithObjects:@"CP",@"CK",@"CL",@"CH",@"CJ", nil];
//    self.mySegment.coursesArray = array2;
    
    [self.view addSubview:self.students];

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
