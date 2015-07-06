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
#import "SettingBirthdayVC.h"
#import "SettingSignatureVC.h"
#import "ChangePassWordVC.h"

#import "XeeService.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface PersonInfoVC ()<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,NeTNameAndDomicileDelegate,SettingBirthdayDelegate,SettingSignatureDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *keepBtn;

@property (nonatomic, strong) UIImage *personImage;//个人头像
//@property (nonatomic, strong) UIImage *saveImage;//拍照后保存的图像
@property (nonatomic, strong) NSString *personImageBase64Coder;//上传所需的base64编码。
@property (nonatomic, strong) NSString *isPhotoEdit;//是否编辑了个人头像
@property (nonatomic, strong) NSString *netName;    //名字
@property (nonatomic, strong) NSString *phoneNumber; //手机号
@property (nonatomic, strong) NSString *myAddr;   //城市名
@property (nonatomic, strong) NSString *myBirthday; //生日
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
    self.mySignature = userInfoDic[uUserMemo];
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
    
    [self.view addSubview:self.tableView];
    
    self.keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.keepBtn setFrame:CGRectMake(20, kScreenHeight-160, kScreenWidth-40, 40)];
    [self.keepBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.keepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.keepBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    self.keepBtn.backgroundColor = [UIColor orangeColor];
    self.keepBtn.layer.cornerRadius = 4.0;
    [self.keepBtn addTarget:self action:@selector(keepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:self.keepBtn];
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
#warning   nickName
    //NSString *nickName = [self.netName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[XeeService sharedInstance] modifyUserWithIsPhotoEdit:self.isPhotoEdit andName:self.netName andSex:@"null" andBirthday:self.myBirthday andIdentifyId:@"null" andMobile:userInfoDic[uPhoneNumber] andAddr:self.myAddr andQq:@"null" andEmail:@"null" andMemo:self.mySignature andRegionalId:userInfoDic[uUserRegionalId] andMobile2:@"null" andParentId:userInfoDic[uUserId] andPhoto: imageWeb andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *isResult = result[@"result "];
            
            if (isResult.integerValue == 0) {
                
                NSDictionary *resultInfoDic = result[@"resultInfo"];
                //NSLog(@"info:%@",resultInfoDic);
                [UIFactory showAlert:@"操作成功"];
                //userInfoDic[uUserPhoto] = resultInfoDic[@"photo"];
                self.isPhotoEdit = @"0";
                //[[UserInfo sharedUser] setUserInfoDicWithWebServiceResult:result];
                //userInfoDic[uUserPhoto] = resultInfoDic[@"photo"];
                
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
    
    return 5;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        
        return 3;
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
                    break;
                }
            }
        }
        else if (indexPath.section == 3){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"居住地";
                    detailInfoString = self.myAddr;
                    break;
                }
                case 1:
                {
                    infoString = @"生日";
                    detailInfoString = self.myBirthday;
                    break;
                }
                case 2:
                {
                    infoString = @"个性签名";
                    detailInfoString = self.mySignature;
                    break;
                }
                default:
                    break;
            }
        }else {
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
                [self changePhoneNumber];
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 3){
        switch (indexPath.row) {
            case 0:
            {
                NeTNameAndDomicileVC *vc = [[NeTNameAndDomicileVC alloc] init];
                vc.nTitle = @"修改居住地";
                vc.nplaceholder = @"请输入居住地";
                vc.index = @"City";
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 1:
            {
                SettingBirthdayVC *vc = [[SettingBirthdayVC alloc] init];
                vc.delegate =self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 2:
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
    else{
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
