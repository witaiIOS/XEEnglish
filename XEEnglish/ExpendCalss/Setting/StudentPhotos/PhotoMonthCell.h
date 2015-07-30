//
//  PhotoMonthCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
#import "PhotoMonthButton.h"

@protocol PhotoMonthCellDelegate <NSObject>

- (void)PhotoMonthCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic;

@end

@interface PhotoMonthCell : BaseTVC
@property (strong, nonatomic) NSDictionary *serviceDic1;
@property (strong, nonatomic) NSDictionary *serviceDic2;
@property (strong, nonatomic) NSDictionary *serviceDic3;

@property (nonatomic, strong) PhotoMonthButton *button1;
@property (nonatomic, strong) PhotoMonthButton *button2;
@property (nonatomic, strong) PhotoMonthButton *button3;


@property (nonatomic, assign) id<PhotoMonthCellDelegate>delegate;

- (IBAction)buttonPressed:(id)sender;

@end
