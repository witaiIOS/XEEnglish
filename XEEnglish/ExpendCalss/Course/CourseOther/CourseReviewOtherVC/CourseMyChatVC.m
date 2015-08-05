//
//  CourseMyChatVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseMyChatVC.h"

#import "XeeService.h"

@interface CourseMyChatVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UITextField *chatTF;//聊天输入框
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
    
    //添加键盘上的done按钮
    [self addKeyboardDone];
    //添加脚视图
    [self addFootView];
    
    //定义tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-40) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //[self moveToTableViewBottom];
}

- (void)moveToTableViewBottom{
    
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:YES];
    }
}

#pragma mark - AddKeyboardDone
- (void)addKeyboardDone{
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(dismissKeyBoard)];
    
    NSArray * buttonsArray = @[btnSpace, doneButton];;
    [topView setItems:buttonsArray];
    [self.chatTF setInputAccessoryView:topView];//当文本输入框加上topView
    topView = nil;
}

-(IBAction)dismissKeyBoard
{
    [self.chatTF resignFirstResponder];
}

- (void )addFootView{
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    self.footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.footView];
    
    self.chatTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-80, 30)];
    self.chatTF.backgroundColor = [UIColor whiteColor];
    self.chatTF.font = [UIFont systemFontOfSize:14];
    self.chatTF.placeholder = @"请输入...";
    self.chatTF.borderStyle = UITextBorderStyleRoundedRect;
    self.chatTF.delegate = self;
    
    [self.footView addSubview:self.chatTF];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setFrame:CGRectMake(kScreenWidth-60, 5, 50, 30)];
    [submitBtn setBackgroundColor:[UIColor orangeColor]];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTintColor:[UIColor whiteColor]];
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [submitBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:submitBtn];
    
}

- (void)submitBtnClicked{
    
    [self addSubcourseLeaveApply];
    self.chatTF.text = @"";
}

#pragma mark - Web

- (void)addSubcourseLeaveApply{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    //NSLog(@"111:%@",self.courseLeaveInfoDic);
    // NSLog(@"111:%@",userInfoDic[uUserToken]);
    // NSLog(@"111:%@",self.courseLeaveInfoDic[@"course_id"]);
    
    //对汉字进行编码
    NSString *niceChatStr = [self.chatTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *createTime = [NSString stringWithFormat:@"%@",self.courseInfoDic[@"create_time"]];
    
    [self showHudWithMsg:@"上传中..."];
    [[XeeService sharedInstance] addSubcourseLeaveApplyByParentId:userInfoDic[uUserId] andRelationId:self.courseInfoDic[@"signon_id"] andRemark:niceChatStr andStar:@"null" andType:self.courseInfoDic[@"is_signon"] andApplyId:@"null" andCreateTime:createTime andStatus:@"null" andTeacherId:@"null" andCheckTime:@"null" andCheckRemark:@"null" andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        
        //NSLog(@"result:%@",result);
        //[self hideHud];
        if (!error) {
            
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                [self getCourseScheduleSignParentCommentWithWeb];
                [UIFactory showAlert:result[@"resultInfo"]];
            }
            else{
                [self hideHud];
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [self hideHud];
            [UIFactory showAlert:@"网络错误"];
        }
    }];
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
                
                [self performSelector:@selector(moveToTableViewBottom) withObject:nil afterDelay:0.3];//滚动课程。
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
    //数据时反着的，最新的在数组的最后面，所以反着输出
    NSInteger newRow = _commentArray.count - indexPath.row;
    //NSLog(@"newRow:%li",newRow);
    NSDictionary *dict = [_commentArray objectAtIndex:newRow-1];
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

#pragma mark - UITextFieldDelegate
-(void) slideFrame:(BOOL)up
{
    const int movementDistance = 260; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //NSLog(@"frame:%@",NSStringFromCGRect(self.view.frame));
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self slideFrame:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self slideFrame:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
