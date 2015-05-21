//
//  DKPasswordModifyViewController.m
//  DaoKong
//
//  Created by fanghao on 15-2-3.
//  Copyright (c) 2015年 cyyun. All rights reserved.
//

#import "DKPasswordModifyViewController.h"
#import "UIViewController+HUD.h"
#import "DKUtils.h"
#import "Marcos.h"
#import "MobClick.h"

@interface DKPasswordModifyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *curPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *NewPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmNewPasswordField;



@end

@implementation DKPasswordModifyViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:TapGr];
    self.view.userInteractionEnabled = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:ChangePWView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:ChangePWView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePassword
{
    
    [self.view endEditing:YES];
    
    NSString *curPassword = self.curPasswordField.text;
    NSString *newPassword = self.NewPasswordField.text;
    NSString *confirmNewPassword = self.confirmNewPasswordField.text;
    
    // 密码不能为空
    if (([curPassword length] == 0) ||
        ([newPassword length] == 0) ||
        ([confirmNewPassword length] == 0))
    {
        [self showHint:@"密码不能为空"];
        return;
    }
    
    
    // 比较新密码是否一致
    if ([newPassword compare:confirmNewPassword] != NSOrderedSame)
    {
        [self showHint:@"新密码输入不一致,请重新输入"];
        return;
    }
    
    // 比较当前密码和新密码是否相同
    if ([curPassword compare:newPassword] == NSOrderedSame)
    {
        [self showHint:@"新密码和旧密码相同,请重新输入"];
        return;
    }
    
    [MobClick event:ChangePassWordEvent];
    
    // 修改密码
    [self changeOldPassword:curPassword ToNewPassword:newPassword];
}

- (void) changeOldPassword:(NSString *)oldPassword ToNewPassword:(NSString *)newPassword
{
//    NSString *encodeOldPassword = [DKUtils encodeToPercentEscapeString:oldPassword];
//    NSString *encodeNewPassword = [DKUtils encodeToPercentEscapeString:newPassword];
//    
//    NSString *stringUrl = [NSString stringWithFormat:@"%@/changePwd.htm", COMMONURL];
//    NSString *paramsStr = [NSString stringWithFormat:@"oldPwd=%@&newPwd=%@", encodeOldPassword, encodeNewPassword];
//    
//    NSURL *url = [NSURL URLWithString:stringUrl];
//    
//    [self showHudInView:self.view hint:@"修改密码中..."];
//    [self.httpRequestLoader cancelAsynRequest];
//    [self.httpRequestLoader startAsynRequestWithURL:url withParams:paramsStr];
//    
//    __unsafe_unretained typeof(self) weakSelf = self;
//    [self.httpRequestLoader setCompletionHandler:^(NSDictionary *resultData, NSString *error){
//        [weakSelf hideHud];
//        
//        if (error != nil)
//        {
//            [DKUtils showServerErrorMeassage:error];
//        }
//        
//        if (resultData != nil)
//        {
//            
//            debugLog(@"change password:%@",resultData);
//            NSString *message = [resultData objectForKey:@"message"];
//            NSString *resultType = [resultData objectForKey:@"type"];
//            if ([resultType isEqualToString:@"success"]) {
//                
//                [[DKUserInfoManager shareManager] saveLatestPasswordWithUserName:USER_INFO.userName password:encodeNewPassword];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf showHint:message];
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                });
//                
//            }else{
//                int resultCode = [[resultData objectForKey:@"code"] intValue];
//                if (resultCode == 5) {
//                    [DKUtils showSessionTokenAlertView];
//                }
//                [weakSelf showHint:message];
//            }
//        }else{
//            [weakSelf showHint:@"网络连接异常"];
//        }
//    }];
}

- (void)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.curPasswordField == textField)
    {
        [self.NewPasswordField becomeFirstResponder];
    }
    else if (self.NewPasswordField == textField)
    {
        [self.confirmNewPasswordField becomeFirstResponder];
    }
    return YES;
}


@end
