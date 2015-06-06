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
        [self.yesButton setFrame:CGRectMake(180, 6, 20, 20)];
        //[self.yesButton setBackgroundColor:[UIColor orangeColor]];
        [self.yesButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        //[self.yesButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateHighlighted];
        [self.yesButton addTarget:self action:@selector(YesAtion) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.yesButton ];
        
        self.yesLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 6, 20, 30)];
        self.yesLabel.textAlignment = NSTextAlignmentLeft;
        self.yesLabel.textColor = [UIColor darkGrayColor];
        self.yesLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.yesLabel];
        
        self.noButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.noButton setFrame:CGRectMake(240, 6, 20, 20)];
        //[self.yesButton setBackgroundColor:[UIColor orangeColor]];
        [self.noButton setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        //[self.noButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateHighlighted];
        [self.noButton addTarget:self action:@selector(NOAtion) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.noButton ];
        
        self.noLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 6, 30, 30)];
        self.noLabel.textAlignment = NSTextAlignmentLeft;
        self.noLabel.textColor = [UIColor darkGrayColor];
        self.noLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.noLabel];
        
        
    }
    return self;

}

#pragma mark - My Action
- (void)YesAtion{
    [self.yesButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
    [self.noButton setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
    self.valueStr = self.yesLabel.text;
}


- (void)NOAtion{
    [self.yesButton setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
    [self.noButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
    self.valueStr = self.noLabel.text;
}

@end
