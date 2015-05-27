//
//  PersonImageTVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PersonImageTVC.h"
//#import "AppMacros.h"
//#import "AppConfig.h"

@interface PersonImageTVC()


@end

@implementation PersonImageTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 10, self.frame.origin.y+8, 40, 30)];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [UIColor darkGrayColor];
        self.title.font = [UIFont systemFontOfSize:14.0];
        
        [self.contentView addSubview:self.title];
        
        self.personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-70, self.frame.origin.y+2, 40, 40)];
        self.personImageView.backgroundColor = RGBCOLOR(210, 210, 210);
        [self.contentView addSubview:self.personImageView];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}



@end
