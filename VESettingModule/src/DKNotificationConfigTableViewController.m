//
//  DKNotificationConfigTableViewController.m
//  DaoKong
//
//  Created by fanghao on 15-2-3.
//  Copyright (c) 2015年 cyyun. All rights reserved.
//

#import "DKNotificationConfigTableViewController.h"
#import "DKUtils.h"
#import "Marcos.h"
#import "MobClick.h"
#import "UIViewController+HUD.h"

@interface DKNotificationConfigTableViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *autoPushNotificationSwitcher;
@property (weak, nonatomic) IBOutlet UISwitch *warnLevelUrgentSwitcher;
@property (weak, nonatomic) IBOutlet UISwitch *warnLevelSeriousSwitcher;
@property (weak, nonatomic) IBOutlet UISwitch *warnLevelGeneralSwitcher;
@property (weak, nonatomic) IBOutlet UISwitch *disturbSwitcher;
@property (nonatomic, assign) NSInteger state;


@end

@implementation DKNotificationConfigTableViewController

#pragma mark - getter



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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.state = 0;
    [self showHudInView:self.view hint:@"正在同步配置，请稍等..."];
    [self downloadUserConfiguration];
    
    [MobClick beginLogPageView:AlertNotificationView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:AlertNotificationView];
}

#pragma mark - Table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - helper method

- (void)downloadUserConfiguration
{
//    NSString *stringUrl = [NSString stringWithFormat:@"%@/settingInfo.htm", COMMONURL];
//    NSURL *url = [NSURL URLWithString:stringUrl];
//    
//    [self.httpRequestLoader cancelAsynRequest];
//    [self.httpRequestLoader startAsynRequestWithURL:url withParams:@""];
//    
//    __weak typeof(self) weakSelf = self;
//    [self.httpRequestLoader setCompletionHandler:^(NSDictionary *resultData, NSString *error){
//        [weakSelf hideHud];
//        if (error != nil)
//        {
//            [DKUtils showServerErrorMeassage:error];
//        }
//        
//        if (resultData != nil)
//        {
//            debugLog(@"resultData:%@",resultData);
//            NSString *message = [resultData objectForKey:@"message"];
//            NSString *resultType = [resultData objectForKey:@"type"];
//            if ([resultType isEqualToString:@"success"])
//            {
//                weakSelf.state = 1;
//                NSDictionary *dataDic = [resultData objectForKey:@"data"];
//                VEJsonParser *jsonParser = [[VEJsonParser alloc] initWithJsonDictionary:dataDic];
//                [weakSelf.autoPushNotificationSwitcher setOn:[jsonParser retrieveAutoPushValue]];
//                [weakSelf.disturbSwitcher setOn:[jsonParser retrieveNightNoDisturbValue]];
//                [weakSelf.warnLevelGeneralSwitcher setOn:[jsonParser retrievePushGenralAlertValue]];
//                [weakSelf.warnLevelSeriousSwitcher setOn:[jsonParser retrievePushSeriousAlertValue]];
//                [weakSelf.warnLevelUrgentSwitcher setOn:[jsonParser retrievePushUrgentAlertValue]];
//                
//                [weakSelf.tableView reloadData];
//            }
//            else
//            {
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


- (IBAction)saveUserConfig:(id)sender
{
//    if (self.state == 0)
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    
//    [self showHudInView:self.view hint:@"正在保存配置，请稍等..."];
//    
//    NSString *stringUrl = [NSString stringWithFormat:@"%@/updateSetting.htm", COMMONURL];
//    NSURL *url = [NSURL URLWithString:stringUrl];
//    
//    NSString *paramsStr = @"";
//    paramsStr = [paramsStr stringByAppendingFormat:@"isPush=%@", (self.autoPushNotificationSwitcher.isOn ? @"true" : @"false")];
//    paramsStr = [paramsStr stringByAppendingFormat:@"&isNightNodisturb=%@", (self.disturbSwitcher.isOn ? @"true" : @"false")];
//    
//    NSString *veLevels = @"_";
//    if (self.warnLevelGeneralSwitcher.isOn)
//    {
//        veLevels = [veLevels stringByAppendingString:@"3_"];
//    }
//    if (self.warnLevelSeriousSwitcher.isOn)
//    {
//        veLevels = [veLevels stringByAppendingString:@"2_"];
//    }
//    if (self.warnLevelUrgentSwitcher.isOn)
//    {
//        veLevels = [veLevels stringByAppendingString:@"1_"];
//    }
//    
//    paramsStr = [paramsStr stringByAppendingFormat:@"&veLevels=%@", veLevels];
//    
//    [self.httpRequestLoader cancelAsynRequest];
//    [self.httpRequestLoader startAsynRequestWithURL:url withParams:paramsStr];
//    
//    __weak typeof(self) weakSelf = self;
//    [self.httpRequestLoader setCompletionHandler:^(NSDictionary *resultData, NSString *error){
//        [weakSelf hideHud];
//        if (error != nil)
//        {
//            [weakSelf showHint:error];
//        }
//        
//        if (resultData != nil)
//        {
//            
//            debugLog(@"resultData:%@",resultData);
//            NSString *message = [resultData objectForKey:@"message"];
//            NSString *resultType = [resultData objectForKey:@"type"];
//            if ([resultType isEqualToString:@"success"])
//            {
//                [weakSelf showHint:@"成功修改配置"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                });
//
//            }
//            else
//            {
//                [weakSelf showHint:message];
//            }
//        }else{
//            [weakSelf showHint:@"网络连接异常"];
//        }
//    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = 1;
    if (self.state == 0)
    {
        sections = 0;
    }
    else if (self.autoPushNotificationSwitcher.isOn)
    {
        sections = 3;
    }
    return sections;
}

- (IBAction)autoPushSwitchChanged:(id)sender {
    [self.tableView reloadData];
}

@end
