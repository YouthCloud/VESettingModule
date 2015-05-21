//
//  DKAboutUsViewController.m
//  DaoKong
//
//  Created by cyyun on 15-2-3.
//  Copyright (c) 2015年 cyyun. All rights reserved.
//

#import "DKAboutUsViewController.h"
#import <MessageUI/MessageUI.h>
#import "MobClick.h"
#import "Marcos.h"

@interface DKAboutUsViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation DKAboutUsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - IBAction

- (IBAction)callAction:(id)sender
{
    // By default, a web view automatically converts telephone numbers that appear in web content to Phone links.
    // When a Phone link is tapped, the Phone application launches and dials the number.
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:@"tel://057428877331"];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
    
    [MobClick event:CallUsEvent];
}

- (IBAction)contactAction:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        mailViewController.navigationBar.tintColor = [UIColor blackColor];
        
        [mailViewController setToRecipients:[NSArray arrayWithObject:ContactApproach]];
        
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)])
        {
            [self presentViewController:mailViewController animated:YES completion:NULL];
        }
    }
    else
    {
        NSLog(@"当前设备不支持发送邮件");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"当前设备不支持发送邮件"
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if (result == MFMailComposeResultSent)
    {
        [MobClick event:CallUsViaEmailEvent];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"邮件已发出"
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
        [alert show];
    }
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
