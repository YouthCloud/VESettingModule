//
//  DKSettingTableViewController.m
//  DaoKong
//
//  Created by cyyun on 15-2-3.
//  Copyright (c) 2015年 cyyun. All rights reserved.
//

#import "DKSettingTableViewController.h"
#import "UIAlertView+UFBlock.h"
#import "UIViewController+HUD.h"
#import "DKUtils.h"
#import "Marcos.h"

@interface DKSettingTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoReceivePicSwitch;
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;

@property (nonatomic, assign) BOOL autoLogin;
@property (nonatomic, assign) BOOL autoReceivePic;

@end

@implementation DKSettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
//    _userNameLabel.text = USER_INFO.userName;
//    _autoLoginSwitch.on = USER_INFO.autoLogin;
//    _autoReceivePicSwitch.on = USER_INFO.autoReceivePic;
    _appVersionLabel.text = [NSString stringWithFormat:@"V %@",APP_VERSION];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self showHint:@"版本检测"];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - helper method



#pragma mark - target Action

- (IBAction)autoLoginSwitchChanged:(UISwitch *)sender {
    _autoLogin = NO;
    if (sender.isOn) {
        _autoLogin = YES;
    }
    //[[DKUserInfoManager shareManager] updateAutoLoginWithUserName:USER_INFO.userName autoLogin:_autoLogin];
}

- (IBAction)autoReceivePicSwitchChanged:(UISwitch *)sender {
    _autoReceivePic = NO;
    if (sender.isOn) {
        _autoReceivePic = YES;
    }
    //[[DKUserInfoManager shareManager] updateAutoReceivePicWithUserName:USER_INFO.userName autoReceivePic:_autoReceivePic];
}

- (IBAction)exitButtonTapped:(id)sender {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定是否退出登录" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.completionBlock = ^(UIAlertView *alertView,NSUInteger buttonIndex){
        if (buttonIndex == 0) {
        }else{
            [DKUtils exitToLogin];
        }
    };
    
    [alertView show];
}

#pragma mark - UIAlertViewDelegate


@end
