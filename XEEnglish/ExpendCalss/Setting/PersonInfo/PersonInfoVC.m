//
//  PersonInfoVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PersonInfoVC.h"
#import "PersonImageTVC.h"

#import "NeTNameAndDomicileVC.h"
#import "SettingBirthdayVC.h"
#import "SettingSignatureVC.h"
#import "ChangePassWordVC.h"

@interface PersonInfoVC ()<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *keepBtn;
@property (nonatomic, strong) UIImage *personImage;

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
    
    self.personImage =[UIImage imageNamed:@"people_ayb"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
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

- (void)keepBtnAction:(id)sender
{
    
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
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
        }
        
        NSString *infoString = nil;
        NSString *detailInfoString = nil;
        
        if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"名字";
                    detailInfoString = @"风哥";
                    break;
                }
            }
        }
        else if (indexPath.section == 2){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"手机号";
                    detailInfoString = @"13797066866";
                    break;
                }
            }
        }
        else if (indexPath.section == 3){
            switch (indexPath.row) {
                case 0:
                {
                    infoString = @"居住地";
                    detailInfoString = @"武汉";
                    break;
                }
                case 1:
                {
                    infoString = @"生日";
                    detailInfoString = @"1990-01-01";
                    break;
                }
                case 2:
                {
                    infoString = @"个性签名";
                    detailInfoString = @"随风飘扬";
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
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 1:
            {
                SettingBirthdayVC *vc = [[SettingBirthdayVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 2:
            {
                SettingSignatureVC *vc = [[SettingSignatureVC alloc] init];
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

//用UIActionSheet控件来选择相片的来源
- (void)changeImage{
    
    UIActionSheet *photoSource = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相册", @"拍照",nil];
    [photoSource showFromRect:self.view.bounds inView:self.view animated:YES];
    
}

#pragma mark - UIActionSheet Delegate

//实现UIActionSheet的 Delegate方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            //当选中第一个按钮时，选用localPhoto方法设置图片
            [self localPhoto];
            break;
        case 1:
            //当选中第二个按钮时，选用takePhoto方法设置图片
            [self takePhoto];
            break;
            
            
        default:
            break;
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
    
    UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.personImage = myImage;
    //[self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
