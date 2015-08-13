//
//  PersonInfoVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PersonInfoVC.h"
#import "PersonImageTVC.h"
#import "BaseTVC.h"

#import "NeTNameAndDomicileVC.h"
#import "SetCommunityVC.h"
#import "SettingBirthdayVC.h"
#import "SettingSignatureVC.h"
#import "ChangePassWordVC.h"

#import "XeeService.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface PersonInfoVC ()<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,NeTNameAndDomicileDelegate,SettingBirthdayDelegate,SettingSignatureDelegate,SetCommunityVCDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *keepBtn;

@property (nonatomic, strong) UIImage *personImage;//个人头像
//@property (nonatomic, strong) UIImage *saveImage;//拍照后保存的图像
@property (nonatomic, strong) NSString *personImageBase64Coder;//上传所需的base64编码。
@property (nonatomic, strong) NSString *isPhotoEdit;//是否编辑了个人头像
@property (nonatomic, strong) NSString *netName;    //名字
@property (nonatomic, strong) NSString *phoneNumber; //手机号
@property (nonatomic, strong) NSString *myCommunityId;//小区id
@property (nonatomic, strong) NSString *myCommunityName;//小区名字
@property (nonatomic, strong) NSString *myAddr;   //城市名
@property (nonatomic, strong) NSString *myBirthday; //生日
@property (nonatomic, strong) NSString *myInvitationCode;//邀请码
@property (nonatomic, strong) NSString *mySignature;//个性签名

@property (nonatomic, assign) BOOL isChangePhoneNuber;//标记是否是修改手机操作启动的UIActionSheet


@end

@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    [super initUI];
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    
    
    self.isPhotoEdit = @"0";
    self.netName = userInfoDic[uUserName];
    //NSLog(@"netName:%@",self.netName);
    self.phoneNumber = userInfoDic[uPhoneNumber];
    self.myAddr = userInfoDic[uUserAddr];
    self.myBirthday = userInfoDic[uUserBirthday];
    self.myInvitationCode = userInfoDic[uUserInvitationCode];
    self.mySignature = userInfoDic[uUserMemo];
    self.myCommunityId = [NSString stringWithFormat:@"%@",userInfoDic[uUserCommunityId]];
    self.myCommunityName = userInfoDic[uUserCommunityName];
    //NSLog(@"comminut:%@",userInfoDic[uUserCommunityName]);
    //NSLog(@"phone:%@",userInfoDic[uUserPhoto]);
//    if ([userInfoDic[uUserPhoto] isKindOfClass:[NSNull class]]) {
//        self.personImage =[UIImage imageNamed:@"people_ayb"];//没有图像就给个磨人图像
//    }
//    else{
//        UIImageView *personImageView = [[UIImageView alloc] init];
//        [personImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,userInfoDic[uUserPhoto]]]];
//        self.personImage = personImageView.image;//有图像就用有本地化的图像
//    }
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,userInfoDic[uUserPhoto]]]];
    //NSLog(@"imagestr:%@",[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,userInfoDic[uUserPhoto]]);
    self.personImage = [UIImage imageWithData:data];//有图像就用有本地化的图像
    //NSLog(@"phone:%@",self.personImage );
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self footView];
    [self.view addSubview:self.tableView];
}

- (UIView *)footView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    view.backgroundColor = [UIColor clearColor];
    
    self.keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.keepBtn setFrame:CGRectMake(20, 10, kScreenWidth-40, 40)];
    [self.keepBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.keepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.keepBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    self.keepBtn.backgroundColor = [UIColor orangeColor];
    self.keepBtn.layer.cornerRadius = 4.0;
    [self.keepBtn addTarget:self action:@selector(keepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:self.keepBtn];
    
    return view;
}

#pragma mark - action

- (void)keepBtnAction:(id)sender
{
    [self modifyUser];
}

#pragma mark - Web
- (void)modifyUser{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"userInfoDic:%@",userInfoDic);
    
//    NSLog(@"isPhotoEdit:%@",self.isPhotoEdit);
//    NSLog(@"name:%@",userInfoDic[uUserName]);
//    NSLog(@"myBirthday:%@",self.myBirthday);
//    NSLog(@"uPhoneNumber:%@",userInfoDic[uPhoneNumber]);
//    NSLog(@"myAddr:%@",self.myAddr);
//    NSLog(@"mySignature:%@",self.mySignature);
//    NSLog(@"uUserRegionalId:%@",userInfoDic[uUserRegionalId]);
//    NSLog(@"uUserId:%@",userInfoDic[uUserId]);
//    //NSLog(@"personImageBase64Coder:%@",self.personImageBase64Coder);
//    NSLog(@"uUserToken:%@",userInfoDic[uUserToken]);
    NSString *imageWeb = nil;
    if ([self.isPhotoEdit isEqualToString:@"0"]) {
        imageWeb = userInfoDic[uUserPhoto];
    }
    else{
        imageWeb = self.personImageBase64Coder;
         //NSLog(@"coder:%@",self.personImageBase64Coder);
    }
    
    //NSLog(@"addr:%@",self.myAddr );
//#warning   nickName
    NSString *nickName = [self.netName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *niceAddr = [self.myAddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *niceSignature = [self.mySignature stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self showHudWithMsg:@"上传中..."];
    [[XeeService sharedInstance] modifyUserWithIsPhotoEdit:self.isPhotoEdit andName:nickName andSex:@"null" andBirthday:self.myBirthday andIdentifyId:@"null" andMobile:userInfoDic[uPhoneNumber] andAddr:niceAddr andQq:@"null" andEmail:@"null" andMemo:niceSignature andMobile2:@"null" andParentId:userInfoDic[uUserId] andPhoto: imageWeb andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result "];
            
            if (isResult.integerValue == 0) {
                
                [UIFactory showAlert:@"操作成功"];
                //////////////////////////////////////////////
                NSDictionary *resultInfoDicNull = result[@"resultInfo"];
                ///过滤NULL
                NSDictionary *resultInfoDic = [[UserInfo sharedUser] filterNullForDictionary:resultInfoDicNull];
                //NSLog(@"info:%@",resultInfoDic);
                ////////////////////////////////////////////////////////
            
                NSMutableDictionary *tempUserInfoDic = [userInfoDic mutableCopy];
                
                [tempUserInfoDic setObject:resultInfoDic[@"photo"] forKey:uUserPhoto];
                [tempUserInfoDic setObject:resultInfoDic[@"name"] forKey:uUserName];
                [tempUserInfoDic setObject:resultInfoDic[@"addr"] forKey:uUserAddr];
                [tempUserInfoDic setObject:resultInfoDic[@"birthday"] forKey:uUserBirthday];
                [tempUserInfoDic setObject:resultInfoDic[@"memo"] forKey:uUserMemo];
                
                NSMutableDictionary *tempUserDic = [userDic mutableCopy];
                [tempUserDic setObject:tempUserInfoDic forKey:uUserInfoKey];
                [[UserInfo sharedUser] setUserInfoDic:tempUserDic];
                
                //返回的isPhotoEdit，为空，必须重新赋0，表示没有编辑
                self.isPhotoEdit = @"0";
                
                /*//userInfoDic[uUserPhoto] = resultInfoDic[@"photo"];
                
                //保存自己的token，因为返回的没有token；
                NSString *myToken = userInfoDic[uUserToken];
                
                //userInfoDic[uUserPhoto] = resultInfoDic[@"photo"];
                
                //返回的isPhotoEdit，为空，必须重新赋0，表示没有编辑
                self.isPhotoEdit = @"0";
                //NSLog(@"myToken:%@",myToken);
                NSMutableDictionary *userInfoMutableDic = [NSMutableDictionary dictionaryWithDictionary:resultInfoDic];
                //重新将token设置回来。
                [userInfoMutableDic setObject:myToken forKey:@"token"];
                NSLog(@"lastInfo:%@",userInfoMutableDic);
                NSMutableDictionary *lastDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"result",userInfoMutableDic,@"resultInfo", nil];
                [[UserInfo sharedUser] setUserInfoDicWithWebServiceResult:lastDic];
                //NSLog(@"myInfo:%@",[[UserInfo sharedUser] getUserInfoDic]);
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,userInfoDic[uUserPhoto]]]];
//                //NSLog(@"imagestr:%@",[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,userInfoDic[uUserPhoto]]);
//                self.personImage = [UIImage imageWithData:data];//有图像就用有本地化的图像*/
                
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        
        return 4;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *reuse = @"PersenImageCell";
        
        PersonImageTVC *cell =[tableView dequeueReusableCellWithIdentifier:reuse];
        
        if (cell == nil) {
            cell = [[PersonImageTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            cell.cellEdge = 10;
        }
        
        switch (indexPath.row) {
            case 0:
            {
                cell.title.text = @"头像";
                
                [cell.personImageView setImage:self.personImage];
                
            }
                break;
                
            default:
                break;
        }
        return cell;
    }
    else{
        static NSString *reuse = @"PersonInfoCell";
        
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellEdge = 10;
            
            
        }
        
        NSString *infoString = nil;
        NSString *detailInfoString = nil;
        
        if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"名字";
                    detailInfoString = self.netName;
                    break;
                }
            }
        }
        else if (indexPath.section == 2){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"手机号";
                    detailInfoString = self.phoneNumber;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
            }
        }
        else if (indexPath.section == 3){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"小区";
                    detailInfoString = self.myCommunityName;
                    break;
                }
                case 1:
                {
                    infoString = @"详细地址";
                    detailInfoString = self.myAddr;
                    break;
                }
                case 2:
                {
                    infoString = @"生日";
                    detailInfoString = self.myBirthday;
                    break;
                }
                case 3:
                {
                    infoString = @"个性签名";
                    detailInfoString = self.mySignature;
                    break;
                }
                default:
                    break;
            }
        }
        else if (indexPath.section == 4){
            infoString = @"我的邀请码";
            detailInfoString = self.myInvitationCode;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else {
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"修改密码";
                    detailInfoString = @"";
                    break;
                }
                default:
                    break;
            }
            
        }
        
        
        cell.textLabel.text = infoString;
        cell.detailTextLabel.text = detailInfoString;
        
        return cell;
    }
    
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self changeImage];
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                NeTNameAndDomicileVC *vc = [[NeTNameAndDomicileVC alloc] init];
                vc.nTitle = @"修改网名";
                vc.nplaceholder = @"请输入网名";
                vc.delegate =self;
                vc.index = @"NetName";//标记更改哪个cell
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
            {
                //[self changePhoneNumber];
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 3){
        switch (indexPath.row) {
            case 0:
            {
                SetCommunityVC *vc = [[SetCommunityVC alloc] init];
                vc.delegate = self;
                vc.selectedCommunityId = self.myCommunityId;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                NeTNameAndDomicileVC *vc = [[NeTNameAndDomicileVC alloc] init];
                vc.nTitle = @"修改居住地";
                vc.nplaceholder = @"请输入居住地";
                vc.index = @"City";
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 2:
            {
                SettingBirthdayVC *vc = [[SettingBirthdayVC alloc] init];
                vc.delegate =self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 3:
            {
                SettingSignatureVC *vc = [[SettingSignatureVC alloc] init];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
                
        }
    }
    else if (indexPath.section == 5){
        switch (indexPath.row) {
            case 0:
            {
                ChangePassWordVC *vc = [[ChangePassWordVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            default:
                break;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }
    else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 70.0f;
    }
    else{
        return 44.0f;
    }
}

//用UIActionSheet控件来选择相片的来源
- (void)changeImage{
    
    self.isChangePhoneNuber = NO;
    UIActionSheet *photoSource = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相册",@"拍照",nil];
    [photoSource showFromRect:self.view.bounds inView:self.view animated:YES];
    
}

//用UIActionSheet控件来修改注册手机号
- (void)changePhoneNumber{
    
    self.isChangePhoneNuber = YES;
    UIActionSheet *photoNumber = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"修改绑定手机号",nil];
    [photoNumber showFromRect:self.view.bounds inView:self.view animated:YES];
    
}


#pragma mark - UIActionSheet Delegate

//实现用UIActionSheet控件来选择相片来源的 Delegate方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.isChangePhoneNuber ) {
        //添加修改手机号的界面
    }
    else{
        switch (buttonIndex) {
            case 0:
                //当选中第一个按钮时，选用localPhoto方法设置图片
                [self localPhoto];
                break;
            case 1:
                //当选中第三个按钮时，选用takePhoto方法设置图片
                [self takePhoto];
                break;
                
                
            default:
                break;
        }
 
    }
}


//从相册选择
- (void)localPhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图库文件
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可以编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
//拍照
- (void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的照片可以编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"该设备没有摄像头");
    }
    
}


#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    /*UIImage *myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //设置当前日期时间为图片名字
    NSDate *imageDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:imageDate]];
    
    //保存图片
    [self saveImage:myImage withName:imageName];
    //获取路径，读取图片
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    self.personImage = [UIImage imageWithContentsOfFile:fullPath];
    //编辑了图像
    self.isPhotoEdit = @"1";
    //NSLog(@"imagePath:%@",fullPath);
    //对保存的图片转化为NSData，并编码
    NSData *imageData0 = [NSData dataWithContentsOfFile:fullPath];
    NSData *imageData = [GTMBase64 encodeData:imageData0];
    //获取编码后的图片，准备上传时用
    self.personImageBase64Coder = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    //NSLog(@"coder:%@",self.personImageBase64Coder);
    //self.personImage = myImage;
    //[self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];*/
    
    
    
   /* NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:imageURL resultBlock:^(ALAsset *asset) {
        
        NSString *imageName = asset.defaultRepresentation.filename;
        
        if (!imageName) {
            
            NSDate *imageDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            imageName = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:imageDate]];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];*/
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.personImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImageJPEGRepresentation(self.personImage, 0.2);
    
    NSData *imageBase64Data = [GTMBase64 encodeData:imageData];
    //获取编码后的图片，准备上传时用
    self.personImageBase64Coder = [[NSString alloc] initWithData:imageBase64Data encoding:NSUTF8StringEncoding];
    //编辑了图像
    self.isPhotoEdit = @"1";
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - saveImage 保存图片至沙盒

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.2);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - NeTNameAndDomicile Delegate
- (void)ChangeNeTNameAndDomicile:(id)sender index:(NSInteger)index{
    
    if (index == 0) {
        self.netName = sender;
    }else{
        self.myAddr = sender;
    }
}

#pragma mark - SettingBirthday Delegate
- (void)ChangeBirthday:(id)sender{
    
    self.myBirthday = sender;
}

#pragma mark - SettingSignature Delegate
- (void)changeSignature:(id)sender{
    
    self.mySignature = sender;
}

#pragma mark - SetCommunityVCDelegate
- (void)setCommunityVCSelectedCommunity:(id)sender{
    
    self.myCommunityId = sender[@"community_id"];
    self.myCommunityName = sender[@"name"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
