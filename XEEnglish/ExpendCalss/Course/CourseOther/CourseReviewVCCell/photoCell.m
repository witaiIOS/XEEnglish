//
//  photoCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//
#define imageHeight 110

#import "photoCell.h"

@implementation photoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //NSLog(@"info:%@",self.photoArray);
        
        self.photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, ((kScreenWidth-20)/3)-10, imageHeight)];
        self.photo2 = [[UIImageView alloc] initWithFrame:CGRectMake(((kScreenWidth-20)/3)+5, 5,((kScreenWidth-20)/3)-10, imageHeight)];
        self.photo3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*((kScreenWidth-20)/3)+5, 5, (kScreenWidth-20)/3-10, imageHeight)];
        
        [self.contentView addSubview:self.photo1];
        [self.contentView addSubview:self.photo2];
        [self.contentView addSubview:self.photo3];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //NSLog(@"info:%@",self.photoArray);
    //NSLog(@"url:%@",[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[self.photoArray[0] objectForKey:@"pic_url"]]);
    [self.photo1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[self.photoArray[0] objectForKey:@"pic_url"]]]];
    
    if ([self.photoArray count] >= 2) {
        [self.photo2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[self.photoArray[1] objectForKey:@"pic_url"]]]];
        
        if ([self.photoArray count] > 2){
            [self.photo3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[self.photoArray[2] objectForKey:@"pic_url"]]]];
        }
    }
}

@end
