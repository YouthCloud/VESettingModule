//
//  DKHelpMeTableViewController.m
//  DaoKong
//
//  Created by fanghao on 15-2-3.
//  Copyright (c) 2015年 cyyun. All rights reserved.
//

#import "DKHelpMeTableViewController.h"
#import "DKDetailHelpMeViewController.h"
#import "DKUtils.h"
#import "Marcos.h"
#import "MobClick.h"

@interface DKHelpMeTableViewController ()

@property (strong, nonatomic) NSArray *helpQAData;

@end

@implementation DKHelpMeTableViewController

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"helpMe-QA" ofType:@"plist"];
    self.helpQAData = [NSArray arrayWithContentsOfFile:path];
    self.clearsSelectionOnViewWillAppear = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:HelpMeView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:HelpMeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (TableCellRowHeight + 10);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.helpQAData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"helpMeCell" forIndexPath:indexPath];
    
    NSDictionary *item = [self.helpQAData objectAtIndex:indexPath.row];
    NSString *question = [item valueForKey:@"question"];
    
    cell.textLabel.text = question;
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    DKDetailHelpMeViewController *detailHelpMeViewController = (DKDetailHelpMeViewController*)[segue destinationViewController];
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *item = [self.helpQAData objectAtIndex:selectedIndexPath.row];
    detailHelpMeViewController.question = [item valueForKey:@"question"];
    NSString *answer = [item valueForKey:@"answer"];
    detailHelpMeViewController.answer = [answer stringByReplacingOccurrencesOfString:@"N" withString:@"\n"];

}


@end
