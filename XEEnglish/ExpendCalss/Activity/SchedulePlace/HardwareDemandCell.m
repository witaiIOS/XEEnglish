//
//  HardwareDemandCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HardwareDemandCell.h"

@implementation HardwareDemandCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.tipInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, 80, 30)];
        self.tipInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.tipInfoLabel.textColor = [UIColor darkGrayColor];
        self.tipInfoLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.tipInfoLabel];
        
        self.yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.yesButton setFrame:CGRectMake(172, 12, 20, 20)];
        //[self.yesButton setBackgroundColor:[UIColor orangeColor]];
        [self.yesButton setImage:[UIImage imageNamed:@"chekbox.png"] forState:UIControlStateNormal];
        [self.yesButton setImage:[UIImage imageNamed:@"chekbox_select.png"] forState:UIControlStateSelected];
        self.yesButton.selected = YES;
        [self.yesButton addTarget:self action:@selector(YesAtion) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.yesButton ];
//        
        self.yesLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 6, 20, 30)];
        self.yesLabel.textAlignment = NSTextAlignmentLeft;
        self.yesLabel.textColor = [UIColor darkGrayColor];
        self.yesLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.yesLabel];
        
        self.noButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.noButton setFrame:CGRectMake(232, 12, 20, 20)];
        //[self.yesButton setBackgroundColor:[UIColor orangeColor]];
        [self.noButton setImage:[UIImage imageNamed:@"chekbox.png"] forState:UIControlStateNormal];
        [self.noButton setImage:[UIImage imageNamed:@"chekbox_select.png"] forState:UIControlStateSelected];
        [self.noButton addTarget:self action:@selector(NOAtion) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.noButton ];
        
        self.noLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 6, 30, 30)];
        self.noLabel.textAlignment = NSTextAlignmentLeft;
        self.noLabel.textColor = [UIColor darkGrayColor];
        self.noLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.noLabel];
        
//        self.boxNeed = [[RadioBox alloc] initWithFrame:CGRectMake(0, 6, 60, 20)];
       
        
//        self.boxUnNeed = [[RadioBox alloc] initWithFrame:CGRectMake(60, 6, 80, 20)];
//        
//        self.boxNeed.text = @"有";
//        self.boxUnNeed.text = @"没有";
//        
//        self.boxNeed.value = 0;
//        self.boxUnNeed.value = 1;
//        NSArray *controls = [NSArray arrayWithObjects:self.boxNeed,self.boxUnNeed, nil];
//        
//        self.boxGroup = [[RadioGroup alloc] initWithFrame:CGRectMake(kScreenWidth-150, 6, 140, 30) WithControl:controls];
//        
//        [self.boxGroup addSubview:self.boxNeed];
//        [self.boxGroup addSubview:self.boxUnNeed];
//        
//        self.boxGroup.selectValue = 0;
//        self.boxGroup.textFont = [UIFont systemFontOfSize:14];
//        
//        [self.contentView addSubview:self.boxGroup];
        
//        TNCircularCheckBoxData *bananaData = [[TNCircularCheckBoxData alloc] init];
//        bananaData.identifier = @"banana";
//        bananaData.labelText = @"有";
//        bananaData.labelColor = [UIColor darkGrayColor];
//        bananaData.checked = YES;
//        bananaData.borderColor = RGBCOLOR(255, 109, 63);
//        bananaData.circleColor = RGBCOLOR(255, 109, 63);
//        bananaData.borderRadius = 20;
//        bananaData.circleRadius = 12;
//        
//        _banana = [[TNCircularCheckBox alloc] initWithData:bananaData];
//        _banana.position = CGPointMake(kScreenWidth-160, 6);
//        _banana.delegate = self;
//        [self.contentView addSubview:_banana];
//        
//        TNCircularCheckBoxData *strawberryData = [[TNCircularCheckBoxData alloc] init];
//        strawberryData.identifier = @"apple";
//        strawberryData.checked = NO;
//        strawberryData.labelText = @"没有";
//        strawberryData.labelColor = [UIColor darkGrayColor];
//        strawberryData.borderColor = RGBCOLOR(255, 109, 63);
//        strawberryData.circleColor = RGBCOLOR(255, 109, 63);
//        strawberryData.borderRadius = 20;
//        strawberryData.circleRadius = 12;
//    
//        _strawberry = [[TNCircularCheckBox alloc] initWithData:strawberryData];
//        _strawberry.position = CGPointMake(kScreenWidth-100, 6);
//        _strawberry.delegate = self;
//        [self.contentView addSubview:_strawberry];

        
        
    }
    return self;

}

#pragma mark - My Action
- (void)YesAtion {
    if (self.yesButton.selected == YES) {
        //1代表需要，0代表不需要
        [self.delegate setNeedProjectorAndTeacher:@"1" andRowOfCell:self.rowOfCell];
    }
    else{
        self.yesButton.selected = YES;
        self.noButton.selected = NO;
        //1代表需要，0代表不需要
        [self.delegate setNeedProjectorAndTeacher:@"1" andRowOfCell:self.rowOfCell];
    }
    
//    self.yesButton.selected = !self.yesButton.selected;
//    self.noButton.selected = !self.yesButton.selected;
}

- (void)NOAtion {
    if (self.noButton.selected == YES) {
        //1代表需要，0代表不需要
        [self.delegate setNeedProjectorAndTeacher:@"0" andRowOfCell:self.rowOfCell];
    }
    else{
        self.yesButton.selected = NO;
        self.noButton.selected = YES;
        [self.delegate setNeedProjectorAndTeacher:@"0" andRowOfCell:self.rowOfCell];
    }
    
//    self.noButton.selected = !self.noButton.selected;
//    self.yesButton.selected = !self.noButton.selected;
}



@end
