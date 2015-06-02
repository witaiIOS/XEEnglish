//
//  HomeBtnCell.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButton.h"

@protocol HomeBtnCellDelegate <NSObject>

- (void)HomeBtnCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic;

@end

@interface HomeBtnCell : UITableViewCell

//@property (strong, nonatomic) NSArray *serviceInfos;
@property (strong, nonatomic) NSDictionary *serviceDic1;
@property (strong, nonatomic) NSDictionary *serviceDic2;
@property (assign, nonatomic) id<HomeBtnCellDelegate>delegate;


- (IBAction)buttonPressed:(id)sender;


@end
