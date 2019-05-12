//
//  ViewController.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "Model.h"
#import "ViewController.h"
#import "AddEntryViewController.h"
#import "EntryCell.h"
#import "FullEntryViewController.h"

@interface ViewController ()

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *addEntryButton;
@property (nonatomic, strong) UIBarButtonItem *refreshButton;
@property (nonatomic, strong) AddEntryViewController *addEntryViewController;
@property (nonatomic, strong) FullEntryViewController *fullEntryViewController;
@property (nonatomic, strong) UIActivityIndicatorView *loadingSpinner;
@property (nonatomic, strong) UIAlertController *networkErrorAlert;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self preparationsForWork];
}

-(void)viewDidAppear:(BOOL)animated
{
    if([self.model getSessionID])
    {
        [self.model refreshData];
    }
}

#pragma mark - Creating UI
-(void)createUI
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.addEntryButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEntryButtonPushed)];
    self.refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPushed)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = self.addEntryButton;
    self.navigationController.navigationBar.topItem.leftBarButtonItem = self.refreshButton;

    self.navigationController.navigationBar.topItem.title = @"List of entries";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    [self.tableView registerClass:[EntryCell class] forCellReuseIdentifier:NSStringFromClass([EntryCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.loadingSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingSpinner.center = self.view.center;
    [self.view addSubview:self.loadingSpinner];
    
    
    self.networkErrorAlert = [UIAlertController alertControllerWithTitle:@"Check internet connection!"
                                                                message:@"Check your internet connection and try again!"
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *refreshAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshButtonPushed];
    }];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {
                                                              if([self.loadingSpinner isAnimating])
                                                              {
                                                                  [self.loadingSpinner stopAnimating];
                                                                  [UIView animateWithDuration:0.5 animations:^{
                                                                      self.tableView.backgroundColor = UIColor.whiteColor;
                                                                  }];
                                                              }
                                                          }];
    [self.networkErrorAlert addAction:defaultAction];
    [self.networkErrorAlert addAction:refreshAction];
    
    
}

-(void)preparationsForWork
{
    _model = [Model sharedInstance];
    self.model.delegate = self;
}

#pragma mark - Navigation buttons
-(void)addEntryButtonPushed
{
    self.addEntryViewController = [AddEntryViewController new];
    [self.navigationController pushViewController:self.addEntryViewController animated:YES];
}

-(void)refreshButtonPushed
{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.backgroundColor = [UIColor colorWithRed:169.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:1];
    }];
    [self.loadingSpinner startAnimating];
    [self.model refreshData];
}


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.notesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EntryCell class]) forIndexPath:indexPath];
    NSDictionary* dictionary = [self.model.notesArray objectAtIndex:indexPath.row];
    [cell configureCellWith:dictionary];
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.fullEntryViewController = [FullEntryViewController new];
    self.fullEntryViewController.data = [self.model.notesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.fullEntryViewController animated:YES];
}


#pragma mark - Model Delegate
- (void)modelDidRefreshed;
{
    [self.tableView reloadData];
    [self.loadingSpinner stopAnimating];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.backgroundColor = UIColor.whiteColor;
    }];
}

- (void)NWServiceError
{

    if(!self.presentedViewController)
    {
        [self presentViewController:self.networkErrorAlert animated:YES completion:nil];
    }
}


@end
