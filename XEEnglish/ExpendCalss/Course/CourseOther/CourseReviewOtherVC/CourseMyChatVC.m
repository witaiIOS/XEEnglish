//
//  CourseMyChatVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseMyChatVC.h"

#import "XeeService.h"

@interface CourseMyChatVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation CourseMyChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史聊天";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initUI{
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化数组
    self.commentArray = [NSMutableArray array];
    
    //网络请求评论数据
    [self getCourseScheduleSignParentCommentWithWeb];
    
    //定义tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Web
- (void)getCourseScheduleSignParentCommentWithWeb {

    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];

    [self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getCourseScheduleSignParentCommentWithParentId:userInfoDic[uUserId] andCourseScheduleId:@"" andPageSize:10 andPageIndex:1 andSignonId:self.courseInfoDic[@"signon_id"] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //查询这节课老师和家长的评论，传值signon_id课表签到id，course_schedule_id不传值。
                NSDictionary *commentDic = result[@"resultInfo"];
                self.commentArray = commentDic[@"data"];
                //NSLog(@"array:%@",self.myCommentArray);
                [self.tableView reloadData];
            }else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }

    }];
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

#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [_commentArray objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [[dict objectForKey:@"parent_comment"] sizeWithFont:font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+44+30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        for (UIView *cellView in cell.subviews){
            [cellView removeFromSuperview];
        }
    }
    
    
    NSDictionary *dict = [_commentArray objectAtIndex:indexPath.row];
    //创建时间
    UILabel *bubbleTime = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-60, 10, 120, 20)];
    bubbleTime.backgroundColor = [UIColor lightGrayColor];
    bubbleTime.text = [dict objectForKey:@"create_time"];
    bubbleTime.textColor = [UIColor whiteColor];
    bubbleTime.font = [UIFont systemFontOfSize:12];
    
    [cell addSubview:bubbleTime];
    
    //创建头像
    UIImageView *photo ;
    if ([[dict objectForKey:@"type"] integerValue] == 1) {
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-60, 10+30, 50, 50)];
        [cell addSubview:photo];
        //photo.image = [UIImage imageNamed:@"image_loading.png"];
        [photo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,dict[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        
        [cell addSubview:[self bubbleView:[dict objectForKey:@"parent_comment"] from:YES withPosition:65]];
        
        
    }else{
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10+30, 50, 50)];
        [cell addSubview:photo];
        //photo.image = [UIImage imageNamed:@"photo"];
        [photo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,dict[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        
        [cell addSubview:[self bubbleView:[dict objectForKey:@"parent_comment"] from:NO withPosition:65]];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
