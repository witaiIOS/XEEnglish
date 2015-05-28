//
//  PersonInfoVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PersonInfoVC.h"
#import "PersonImageTVC.h"


#import "ChangePassWordVC.h"

@interface PersonInfoVC ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *keepBtn;

@end

@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
}

- (void)initUI
{
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
    
    return 2;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    else{
        
        return 7;
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
                [cell.personImageView setImage:[UIImage imageNamed:@"people_ayb"]];

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
        
        switch (indexPath.row) {
            case 0:
            {
                infoString = @"网名";
                detailInfoString = @"风哥";
            }
                break;
            case 1:
            {
                infoString = @"账号";
                detailInfoString = @"123";
            }
                break;

            case 2:
            {
                infoString = @"手机号";
                detailInfoString = @"13797066866";
            }
                break;

            case 3:
            {
                infoString = @"居住地";
                detailInfoString = @"武汉";
            }
                break;

            case 4:
            {
                infoString = @"生日";
                detailInfoString = @"1990-01-01";
            }
                break;

            case 5:
            {
                infoString = @"个性签名";
                detailInfoString = @"随风飘扬";
            }
                break;

            case 6:
            {
                infoString = @"修改密码";
                detailInfoString = @"";
            }
                break;

                
            default:
                break;
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
    else{
        
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                
            }
                break;
            case 5:
            {
                
            }
                break;
            case 6:
            {
                ChangePassWordVC *vc = [[ChangePassWordVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;


                
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
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
    
}

- (void)changeImage{
    
    UIActionSheet *photoSource = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相册", @"图库",@"拍照",nil];
    [photoSource showFromRect:self.view.bounds inView:self.view animated:YES];
    
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController *imageSource = [[UIImagePickerController alloc] init];
    imageSource.delegate = self;
    
    if (buttonIndex == 0) {
        imageSource.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            [self presentViewController:imageSource animated:YES completion:nil];
        }
        
        
    }else if (buttonIndex == 1){
        imageSource.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
            [self presentViewController:imageSource animated:YES completion:nil];
        }
        
    }else if (buttonIndex == 2){
        imageSource.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self presentViewController:imageSource animated:YES completion:nil];
        }

        
        
    }
    
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
