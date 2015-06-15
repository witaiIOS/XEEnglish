//
//  Course.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseVC.h"
//#import "DropList.h"
#import "JSDropDownMenu.h"

@interface CourseVC ()<JSDropDownMenuDataSource, JSDropDownMenuDelegate>

@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSMutableArray *courseList;

@property (nonatomic) NSInteger currentStudentsIndex;
@property (nonatomic) NSInteger currentCouseListIndex;

@property (strong, nonatomic) JSDropDownMenu *menu;

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _students =[NSMutableArray arrayWithArray:@[@"小明", @"小红", @"小花"]];
    _courseList = [NSMutableArray arrayWithArray:@[@"(2-4岁)创意思维课", @"(4-6岁)HABA数学课", @"初级英语"]];
    _currentStudentsIndex = 0;
    _currentCouseListIndex = 0;

    _menu.dataSource = self;
    _menu.delegate = self;
    
}

- (void)initUI{
    
    [super initUI];
    
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    _menu.indicatorColor = RGBCOLOR(175, 175, 175);
    _menu.separatorColor = RGBCOLOR(210, 210, 210);
    _menu.textColor = RGBCOLOR(83, 83, 83);
   
    [self.view addSubview:_menu];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JSDropDownMenu datasouce delegate
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 2;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentStudentsIndex;;
        
    }
    if (column==1) {
        
        return _currentCouseListIndex;
    }
    
    return 0;
}


- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow {
    if (column == 0) {
        return _students.count;
    }
    else if (column == 1) {
        return _courseList.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column {
    if (column == 0) {
        return _students[_currentStudentsIndex];
    }
    else if (column ==1) {
        return _courseList[_currentCouseListIndex];
    }
    
    return nil;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return _students[indexPath.row];
    }
    else if (indexPath.column == 1) {
        return _courseList[indexPath.row];
    }
    return nil;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        _currentStudentsIndex = indexPath.row;
    }
    else if (indexPath.column == 1) {
        _currentCouseListIndex = indexPath.row;
    }
}


@end
