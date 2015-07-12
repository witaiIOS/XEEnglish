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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.button1 = [HomeButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setFrame:CGRectMake(10, 10, 145, 110)];
        self.button1.tag = 1;
        [self.button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button1];
        
        self.button2 =[HomeButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setFrame:CGRectMake(165, 10, 145, 110)];
        self.button2.tag = 2;
        [self.button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button2];
                        
    }
    
    return self;
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
    
    //self.button1 = (HomeButton *)[self viewWithTag:1];
    //NSLog(@"title:%@",[_serviceDic1 objectForKey:@"title"]);
    [self.button1 setTitle:[_serviceDic1 objectForKey:@"title"] forState:UIControlStateNormal];
    
    NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic1 objectForKey:@"photo"]];
    //NSLog(@"title:%@",self.button1.titleLabel.text);
    //NSLog(@"frame:%@",NSStringFromCGRect(self.button1.titleLabel.frame));

    [self.button1 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    //[self.button1 setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    ///
    //self.button2 = (HomeButton *)[self viewWithTag:2];
    if (_serviceDic2) {
        [self.button2 setHidden:NO];
        
        [self.button2 setTitle:[_serviceDic2 objectForKey:@"title"] forState:UIControlStateNormal];
        //NSLog(@"title:%@",[_serviceDic2 objectForKey:@"title"]);
        NSString *imageUrl2 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic2 objectForKey:@"photo"]];
        
        [self.button2 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        //[self.button2 setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    }
    else{
        [self.button2 setHidden:YES];
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
