//
//  photoCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "photoCell.h"

@implementation photoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (kScreenWidth/3)-10, self.frame.size.height-10)];
        self.photo2 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/3)+5, 5,(kScreenWidth/3)-10, self.frame.size.height-10)];
        self.photo3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*(kScreenWidth/3)+5, 5, kScreenWidth/3-10, self.frame.size.height-10)];
    } 
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

}

@end
