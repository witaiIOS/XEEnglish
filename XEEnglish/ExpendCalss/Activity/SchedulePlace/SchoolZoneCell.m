//
//  SchoolZoneCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchoolZoneCell.h"

@implementation SchoolZoneCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.schollLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
    self.schollLabel.font = [UIFont systemFontOfSize:14];
    self.schollLabel.textColor = [UIColor darkGrayColor];
    
    [self addSubview:self.schollLabel];
    
    UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
    UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
    self.selectImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth -50, 2, 40, 40)];
    
    [self addSubview:self.selectImageView];
    
    return self;
}

@end
