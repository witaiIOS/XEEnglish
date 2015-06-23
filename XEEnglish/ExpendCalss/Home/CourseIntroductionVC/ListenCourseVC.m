//
//  ListenCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ListenCourseVC.h"

@interface ListenCourseVC ()

@end

@implementation ListenCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI{
    
    self.courseName.text = self.title;
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

- (IBAction)courseTypeClicked:(id)sender {
}

- (IBAction)schoolSelectedClicked:(id)sender {
}

- (IBAction)listenAtSchoolClicked:(id)sender {
}

- (IBAction)listenAtHomeClicked:(id)sender {
}



- (IBAction)applyBtnClicked:(id)sender {
}


@end
