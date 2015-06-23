//
//  ListenZoneCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ListenZoneCell.h"

@implementation ListenZoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, 100, 30)];
        self.myLabel.textColor = [UIColor blackColor];
        self.myLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myLabel];
        
        self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-60, 12, 20, 20)];
        
        [self.contentView addSubview:self.selectedImageView];
    }
    
    return self;
}

@end
