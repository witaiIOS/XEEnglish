//
//  SetCommunityCell.m
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SetCommunityCell.h"

@implementation SetCommunityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.communityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
        self.communityNameLabel.font = [UIFont systemFontOfSize:14.0];
        self.communityNameLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.communityNameLabel];
        
        
        UIImage *unSelectedImage = [UIImage imageNamed:@"school_unselected.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"school_selected.png"];
        self.selectedImageView = [[UIImageView alloc] initWithImage:unSelectedImage highlightedImage:selectedImage];
        [self.selectedImageView setFrame:CGRectMake(kScreenWidth-50, 12, 20, 20)];
        
        [self.contentView addSubview:self.selectedImageView];
    }
    
    return self;
}

@end
