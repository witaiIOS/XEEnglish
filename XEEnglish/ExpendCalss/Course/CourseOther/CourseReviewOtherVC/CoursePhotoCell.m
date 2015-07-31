//
//  CoursePhotoCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CoursePhotoCell.h"

@implementation CoursePhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.button1 = [CoursePhotoButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setFrame:CGRectMake(0, 0, 90, 150)];
        self.button1.tag = 1;
        [self.button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button1];
        
        self.button2 =[CoursePhotoButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setFrame:CGRectMake(100, 0, 90, 150)];
        self.button2.tag = 2;
        [self.button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button2];
        
        self.button3 =[CoursePhotoButton buttonWithType:UIButtonTypeCustom];
        [self.button3 setFrame:CGRectMake(200, 0, 90, 150)];
        self.button3.tag = 3;
        [self.button3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button3];
        
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
    
    [self.button1 setTitle:[_serviceDic1 objectForKey:@"create_time"] forState:UIControlStateNormal];
    
    NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic1 objectForKey:@"pic_url"]];
    
    [self.button1 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    
    if (_serviceDic2) {
        [self.button2 setHidden:NO];
        
        [self.button2 setTitle:[_serviceDic2 objectForKey:@"create_time"] forState:UIControlStateNormal];
        NSString *imageUrl2 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic2 objectForKey:@"pic_url"]];
        
        [self.button2 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        
        if (_serviceDic3) {
            [self.button3 setHidden:NO];
            
            [self.button3 setTitle:[_serviceDic3 objectForKey:@"create_time"] forState:UIControlStateNormal];
            NSString *imageUrl3 = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_serviceDic3 objectForKey:@"pic_url"]];
            
            [self.button3 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl3] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        }
        else{
            [self.button3 setHidden:YES];
        }
    }
    else{
        [self.button2 setHidden:YES];
    }
    
    
}

- (IBAction)buttonPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    
    if (button.tag == 1) {
        [self.delegate CoursePhotoCellButtonPressed:sender andRowOfCell:_rowOfCell];
    }
    else if (button.tag == 2){
        [self.delegate CoursePhotoCellButtonPressed:sender andRowOfCell:_rowOfCell];
    }
    else if (button.tag == 3){
        [self.delegate CoursePhotoCellButtonPressed:sender andRowOfCell:_rowOfCell];
    }
    
}

@end
