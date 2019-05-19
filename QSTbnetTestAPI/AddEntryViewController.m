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
@property (nonatomic, weak) Model *model;

@end


@implementation AddEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self makeConstrains];
    _model = [Model sharedInstance];
}

- (void)createUI
{
    self.view.backgroundColor = UIColor.whiteColor;
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.font = [UIFont systemFontOfSize:20];
    _label.textColor = UIColor.blackColor;
    _label.text = @"Enter the text:";
    [self.view addSubview:_label];

    _textField = [UITextField new];
    _textField.layer.borderColor = UIColor.grayColor.CGColor;
    _textField.layer.cornerRadius = 10;
    _textField.layer.borderWidth = 0.5;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_textField];
    
    _okButton = [UIButton new];
    _okButton.layer.cornerRadius = 10;
    _okButton.layer.borderWidth = 0.5;
    _okButton.layer.borderColor = UIColor.blackColor.CGColor;
    _okButton.backgroundColor = UIColor.greenColor;
    _okButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_okButton setTitle:@"Send" forState:UIControlStateNormal];
    [_okButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    _okButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [_okButton addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_okButton];
}

- (void)makeConstrains
{
    [NSLayoutConstraint activateConstraints:@[
                                              [_label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [_label.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                                              [_label.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
                                              [_label.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
                                              
                                              [_textField.topAnchor constraintEqualToAnchor:_label.bottomAnchor constant:5],
                                              [_textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                                              [_textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
                                              [_textField.heightAnchor constraintEqualToConstant:CGRectGetHeight(UIScreen.mainScreen.bounds)/2],
                                              
                                              [_okButton.topAnchor constraintEqualToAnchor:_textField.bottomAnchor  constant:10],
                                              [_okButton.widthAnchor constraintEqualToConstant:CGRectGetWidth(UIScreen.mainScreen.bounds)/2],
                                              [_okButton.bottomAnchor constraintLessThanOrEqualToAnchor:self.view.bottomAnchor constant:-10],
                                              [_okButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
                                              ]
     ];
}

- (void)okButtonPressed
{
    [self.model newEntryWith:self.textField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
