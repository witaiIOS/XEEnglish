//
//  NearSchoolDetailCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NearSchoolDetailCell.h"

@implementation NearSchoolDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.schoolImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-40, 130)];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.schoolImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.schoolImageInfoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
}

@end
