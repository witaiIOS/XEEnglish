//
//  AllCoursesVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AllCoursesVC.h"
#import "JSDropDownMenu.h"

@interface AllCoursesVC ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>

@property (nonatomic, strong) NSMutableArray *coursesArray;
@property (nonatomic, strong) NSMutableArray *ageGroupArray;

@property (nonatomic, assign) NSInteger currentCourseIndex;
@property (nonatomic, assign) NSInteger currentAgeGroupIndex;

@property (nonatomic, strong) JSDropDownMenu *menu;


@end

@implementation AllCoursesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"所有课程";
    
    self.coursesArray = [NSMutableArray arrayWithObjects:@"英语课", @"艺术课",@"趣味课",nil];
    self.ageGroupArray = [NSMutableArray arrayWithObjects:@"1013~1011", @"1021~1020",@"1022~1020",nil];
    
    self.currentCourseIndex = 0;
    self.currentAgeGroupIndex = 0;
    
    self.menu.dataSource = self;
    self.menu.delegate = self;
}

- (void)initUI{
    
    [super initUI];
    
    self.menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    self.menu.indicatorColor = RGBCOLOR(175, 175, 175);
    self.menu.separatorColor = RGBCOLOR(210, 210, 210);
    self.menu.textColor = RGBCOLOR(83, 83, 83);
    
    [self.view addSubview:self.menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - JSDropDownMenu DataSource
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    return 2;
}

/**
 * 表视图显示时，是否需要两个表显示
 */
- (BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}
/**
 * 表视图显示时，左边表显示比例
 */
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1.0f;
}

/**
 * 返回当前菜单左边表选中行
 */
- (NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column == 0) {
        
        return self.currentCourseIndex;
    }
    else if (column == 1) {
        
        return self.currentAgeGroupIndex;
    }
    else{
        return 0;
    }
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column == 0) {
        
        return [self.coursesArray count];
    }
    else if (column == 1){
        
        return [self.ageGroupArray count];
    }
    else
        return 0;
    
}
- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    if (column == 0) {
        
        return self.coursesArray[self.currentCourseIndex];
    }
    else if (column == 1){
        
        return self.ageGroupArray[self.currentAgeGroupIndex];
    }
    return nil;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        
        return self.coursesArray[indexPath.row];
    }
    else if(indexPath.column == 1){
        
        return self.ageGroupArray[indexPath.row];
    }
    return nil;
}

#pragma mark - JSDropDownMenu Delegate
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        
        self.currentCourseIndex = indexPath.row;
    }
    else if(indexPath.column == 1){
        
        self.currentAgeGroupIndex =indexPath.row;
    }
    else{
        
    }
        
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
