//
//  CityVCCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CityVCCell.h"

@implementation CityVCCell

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
        self.cityName = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 60, 30)];
        self.cityName.textColor = [UIColor darkGrayColor];
        self.cityName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.cityName];
        
        UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
        self.selectedImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
        [self.selectedImageView setFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        
        [self.contentView addSubview:self.selectedImageView];
    }
    
    return self;
}


@end
