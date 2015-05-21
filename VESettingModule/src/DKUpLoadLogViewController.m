//
//  DKUpLoadLogViewController.m
//  DaoKong
//
//  Created by fanghao on 15-2-3.
//  Copyright (c) 2015年 cyyun. All rights reserved.
//

#import "DKUpLoadLogViewController.h"
#import <MessageUI/MessageUI.h>
#import "UIViewController+HUD.h"
#import "DKUtils.h"
#import "Marcos.h"
#import "MobClick.h"

@interface DKUpLoadLogViewController ()<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *listData;
@property (strong, nonatomic) NSMutableArray *selectedList;

@end

@implementation DKUpLoadLogViewController


- (NSMutableArray *)listData
{
    if (_listData == nil)
    {
        _listData = [[NSMutableArray alloc] init];
    }
    return _listData;
}

- (NSMutableArray *)selectedList
{
    if (_selectedList == nil)
    {
        _selectedList = [[NSMutableArray alloc] init];
    }
    return _selectedList;
}

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
    
    self.clearsSelectionOnViewWillAppear = YES;
    [DKUtils setExtraTableCellLine:self.tableView];
    NSString *logsFolderPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:LogsFolder];
    NSError *error = nil;
    NSArray *dirArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logsFolderPath error:&error];
    if (!error) {
        [self.listData addObjectsFromArray:dirArray];
    }else{
        NSLog(@"打开日志文件夹失败！");
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:UploadLogView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:UploadLogView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableCellRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpLoadLogCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == ([self.listData count] - 1))
    {
        NSNumber *numRow = [NSNumber numberWithInteger:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedList removeObject:numRow];
        [self.selectedList addObject:numRow];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == ([self.listData count] - 1)) return;
    
    NSNumber *numRow = [NSNumber numberWithInteger:indexPath.row];
    [self.selectedList removeObject:numRow];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedList addObject:numRow];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}


- (IBAction)doUploadLogFiles
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        mailViewController.navigationBar.tintColor = [UIColor blackColor];
        
        [mailViewController setSubject:@"指挥系统-iPhone版 日志文件"];
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"fanghao@cyyun.com"]];
        
        [mailViewController setMessageBody:[NSString stringWithFormat:@"当前设备系统版本: %@\n当前应用版本:%@\n", [UIDevice currentDevice].systemVersion,APP_VERSION]
                                    isHTML:NO];
        
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *logsFolderPath = [documentsDirectory stringByAppendingPathComponent:@"Logs"];
        
        for (NSNumber *selectedIndex in self.selectedList)
        {
            NSString *logFileName = [self.listData objectAtIndex:[selectedIndex integerValue]];
            NSString *logFilePath = [logsFolderPath stringByAppendingPathComponent:logFileName];
            
            [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:logFilePath]
                                         mimeType:@"text"
                                         fileName:logFileName];
        }
        
        [self presentViewController:mailViewController animated:YES completion:NULL];
        
    }
    else
    {
        [self showHint:@"[设置]－>[iCloud]->打开邮件开关"];
    }
    
}


#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if (result == MFMailComposeResultSent)
    {
        [self showHint:@"邮件已发送"];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
