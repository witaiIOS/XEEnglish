//
//  CoursePhotoCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
#import "CoursePhotoButton.h"
@protocol CoursePhotoCellDelegate <NSObject>

- (void)CoursePhotoCellButtonPressed:(id)sender andRowOfCell:(NSInteger )rowOfCell;

@end

@interface CoursePhotoCell : BaseTVC
@property (nonatomic, assign) NSInteger rowOfCell;

@property (strong, nonatomic) NSDictionary *serviceDic1;
@property (strong, nonatomic) NSDictionary *serviceDic2;
@property (strong, nonatomic) NSDictionary *serviceDic3;

@property (nonatomic, strong) CoursePhotoButton *button1;
@property (nonatomic, strong) CoursePhotoButton *button2;
@property (nonatomic, strong) CoursePhotoButton *button3;


@property (nonatomic, assign) id<CoursePhotoCellDelegate>delegate;

- (IBAction)buttonPressed:(id)sender;
@end
