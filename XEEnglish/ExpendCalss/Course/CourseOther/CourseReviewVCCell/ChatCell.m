//
//  ChatCell.m
//  XEEnglish
//
//  Created by houjing on 15/8/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //创建时间
        self.bubbleTime = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-60, 10, 120, 20)];
        self.bubbleTime.backgroundColor = [UIColor lightGrayColor];
        self.bubbleTime.textColor = [UIColor whiteColor];
        self.bubbleTime.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.bubbleTime];
        
        
        //创建头像
        if ([[self.chatInfoDic objectForKey:@"type"] integerValue] == 1) {
            self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-60, 10+30, 50, 50)];
            [self addSubview:self.photo];

        }else{
            self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10+30, 50, 50)];
            [self addSubview:self.photo];
        }
        
    }
    
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    //设置聊天时间
    self.bubbleTime.text = [self.chatInfoDic objectForKey:@"create_time"];
    
    //创建头像
    if ([[self.chatInfoDic objectForKey:@"type"] integerValue] == 1) {
        
        [self.photo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.chatInfoDic[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        
        [self addSubview:[self bubbleView:[self.chatInfoDic objectForKey:@"parent_comment"] from:YES withPosition:65]];
        
        
    }else{
       
        [self.photo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.chatInfoDic[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        
        [self addSubview:[self bubbleView:[self.chatInfoDic objectForKey:@"parent_comment"] from:NO withPosition:65]];
    }
    
    
}


//泡泡文本
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf withPosition:(int)position{
    
    //计算大小
    UIFont *font = [UIFont systemFontOfSize:14];
    //CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(180.0f, 20000.0f) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    //背影图片
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"SenderAppNodeBkg_HL":@"ReceiverTextNodeBkg" ofType:@"png"]];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/2)]];
    NSLog(@"%f,%f",size.width,size.height);
    
    
    //添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf?15.0f:22.0f, 20.0f, size.width+10, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    bubbleText.text = text;
    
    bubbleImageView.frame = CGRectMake(0.0f, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
    
    if(fromSelf)
        returnView.frame = CGRectMake(kScreenWidth-position-(bubbleText.frame.size.width+30.0f), 0.0f+30, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    else
        returnView.frame = CGRectMake(position, 0.0f+30, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    
    [returnView addSubview:bubbleImageView];
    [returnView addSubview:bubbleText];
    
    return returnView;
}

@end
