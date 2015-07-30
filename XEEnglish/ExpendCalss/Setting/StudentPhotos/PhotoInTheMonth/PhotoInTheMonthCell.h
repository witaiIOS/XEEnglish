//
//  PhotoInTheMonthCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
#import "PhotoInTheMonthButton.h"

@protocol PhotoInTheMonthCellDelegate <NSObject>

- (void)PhotoInTheMonthCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic;

@end

@interface PhotoInTheMonthCell : BaseTVC
@property (strong, nonatomic) NSDictionary *serviceDic1;
@property (strong, nonatomic) NSDictionary *serviceDic2;
@property (strong, nonatomic) NSDictionary *serviceDic3;

@property (nonatomic, strong) PhotoInTheMonthButton *button1;
@property (nonatomic, strong) PhotoInTheMonthButton *button2;
@property (nonatomic, strong) PhotoInTheMonthButton *button3;


@property (nonatomic, assign) id<PhotoInTheMonthCellDelegate>delegate;

- (IBAction)buttonPressed:(id)sender;
@end
