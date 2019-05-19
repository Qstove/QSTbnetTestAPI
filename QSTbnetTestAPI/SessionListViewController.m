//
//  SessionListViewController.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/19/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SessionListViewController.h"
#import "Model.h"
#import "SessionCell.h"

@interface SessionListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *noSessionsLabel;
@property (nonatomic, strong) UIBarButtonItem *cleanCoreDataButton;
@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) SessionCell *selectedCell;

@end

@implementation SessionListViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.model = [Model sharedInstance];
    [self createUI];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(void)createUI
{
    self.cleanCoreDataButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(cleanCoreDataButtonPushed)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = self.cleanCoreDataButton;
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.topItem.title = @"Session list";
    self.noSessionsLabel = [[UILabel alloc]initWithFrame:self.view.frame];
    self.noSessionsLabel.text = @"No sessions";
    self.noSessionsLabel.font = [UIFont systemFontOfSize:25];
    self.noSessionsLabel.textAlignment = NSTextAlignmentCenter;
    self.noSessionsLabel.backgroundColor = UIColor.clearColor;
    
    [self.view addSubview:self.noSessionsLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    [self.tableView registerClass:[SessionCell class] forCellReuseIdentifier:NSStringFromClass([SessionCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setHidden:YES];
    [self.view addSubview:self.tableView];
}


#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SessionCell class]) forIndexPath:indexPath];
    NSArray* array = [self.model.sessionArray objectAtIndex:indexPath.row];
    [cell configureCellWith:array];
    cell.backgroundColor = UIColor.clearColor;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if((self.model.sessionArray.count) && (self.tableView.isHidden))
    {
        [self.tableView setHidden:NO];
        [self.noSessionsLabel setHidden:YES];
    }
    return self.model.sessionArray.count;
}


-(void)cleanCoreDataButtonPushed
{
    [self.model cleanCoreData];
    [self.tableView reloadData];
    [self.tableView setHidden:YES];
    [self.noSessionsLabel setHidden:NO];

}


@end
