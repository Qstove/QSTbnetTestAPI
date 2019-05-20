//
//  AddEntryViewController.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AddEntryViewController.h"
#import "ViewController.h"
#import "Model.h"


@interface AddEntryViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) Model *model;

@end


@implementation AddEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self makeConstrains];
    self.model = [Model sharedInstance];
}

- (void)createUI
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.label = [UILabel new];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.font = [UIFont systemFontOfSize:20];
    self.label.textColor = UIColor.blackColor;
    self.label.text = @"Enter the text:";
    [self.view addSubview:self.label];

    self.textField = [UITextField new];
    self.textField.layer.borderColor = UIColor.grayColor.CGColor;
    self.textField.layer.cornerRadius = 10;
    self.textField.layer.borderWidth = 0.5;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.textField];
    
    self.okButton = [UIButton new];
    self.okButton.layer.cornerRadius = 10;
    self.okButton.layer.borderWidth = 0.5;
    self.okButton.layer.borderColor = UIColor.blackColor.CGColor;
    self.okButton.backgroundColor = UIColor.greenColor;
    self.okButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.okButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.okButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.okButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.okButton addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.okButton];
}

- (void)makeConstrains
{
    [NSLayoutConstraint activateConstraints:@[
                                              [self.label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.label.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                                              [self.label.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
                                              [self.label.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
                                              
                                              [self.textField.topAnchor constraintEqualToAnchor:_label.bottomAnchor constant:5],
                                              [self.textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                                              [self.textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
                                              [self.textField.heightAnchor constraintEqualToConstant:CGRectGetHeight(UIScreen.mainScreen.bounds)/2],
                                              
                                              [self.okButton.topAnchor constraintEqualToAnchor:_textField.bottomAnchor  constant:10],
                                              [self.okButton.widthAnchor constraintEqualToConstant:CGRectGetWidth(UIScreen.mainScreen.bounds)/2],
                                              [self.okButton.bottomAnchor constraintLessThanOrEqualToAnchor:self.view.bottomAnchor constant:-10],
                                              [self.okButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
                                              ]
     ];
}

- (void)okButtonPressed
{
    [self.model newEntryWith:self.textField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}
@end
