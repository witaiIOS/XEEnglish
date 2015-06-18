//
//  HomeBtnCell.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeBtnCell.h"
#import "AppCore.h"
#import "HomeButton.h"


@implementation HomeBtnCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setButtonInfo];
}

- (void)setButtonInfo{
    
    ///
//    HomeButton *button1 = (HomeButton *)[self viewWithTag:1];
//    [button1 setTitle:[_serviceDic1 objectForKey:@"serviceName"] forState:UIControlStateNormal];
//    
//    NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",MZBimageURLPrefix,[_serviceDic1 objectForKey:@"servicePhoto"]];
//    
//    [button1 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@""]];
//    
//    ///
//    HomeButton *button2 = (HomeButton *)[self viewWithTag:2];
//    if (_serviceDic2) {
//        [button2 setHidden:NO];
//        
//        [button2 setTitle:[_serviceDic2 objectForKey:@"serviceName"] forState:UIControlStateNormal];
//        
//        NSString *imageUrl2 = [NSString stringWithFormat:@"%@%@",MZBimageURLPrefix,[_serviceDic2 objectForKey:@"servicePhoto"]];
//        
//        [button2 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@""]];
//    }
//    else{
//        [button2 setHidden:YES];
//    }
    
    HomeButton *button1 = (HomeButton *)[self viewWithTag:1];
    [button1 setTitle:[_serviceDic1 objectForKey:@"title"] forState:UIControlStateNormal];
    
    NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic1 objectForKey:@"photo"]];
    
    [button1 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@""]];
    
    ///
    HomeButton *button2 = (HomeButton *)[self viewWithTag:2];
    if (_serviceDic2) {
        [button2 setHidden:NO];
        
        [button2 setTitle:[_serviceDic2 objectForKey:@"title"] forState:UIControlStateNormal];
        
        NSString *imageUrl2 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic2 objectForKey:@"photo"]];
        
        [button2 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@""]];
    }
    else{
        [button2 setHidden:YES];
    }

    
}

- (IBAction)buttonPressed:(id)sender{
    UIButton *button = (UIButton *)sender;

    if (button.tag == 1) {
        [self.delegate HomeBtnCellButtonPressed:sender andServiceInfo:_serviceDic1];
    }
    else if (button.tag == 2){
        [self.delegate HomeBtnCellButtonPressed:sender andServiceInfo:_serviceDic2];
    }
    
}

@end
