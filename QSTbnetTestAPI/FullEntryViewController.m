//
//  FullEntryViewController.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/12/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "FullEntryViewController.h"


@interface FullEntryViewController ()

@property (nonatomic, strong) UILabel *createDateLabel;
@property (nonatomic, strong) UILabel *editDateLabel;
@property (nonatomic, strong) UITextView *entryBodyTextView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end


@implementation FullEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self makeConstraints];
}

- (void)createUI
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"d MMM H:mm";
    
    self.createDateLabel = [UILabel new];
    self.createDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.createDateLabel.adjustsFontSizeToFitWidth = YES;
    self.createDateLabel.numberOfLines = 2;
    self.createDateLabel.minimumScaleFactor=0.5;
    self.createDateLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
    [self.view addSubview: self.createDateLabel];
    
    self.editDateLabel = [UILabel new];
    self.editDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.editDateLabel.adjustsFontSizeToFitWidth = YES;
    self.editDateLabel.numberOfLines = 2;
    self.editDateLabel.minimumScaleFactor=0.5;
    self.editDateLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
    [self.view addSubview: self.editDateLabel];

    self.entryBodyTextView = [UITextView new];
    self.entryBodyTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.entryBodyTextView.font = [UIFont systemFontOfSize:25 weight:0.5];
    [self.view addSubview: self.entryBodyTextView];
    
    [self configureWithDictionary:self.data];

}

- (void)makeConstraints
{
    [NSLayoutConstraint activateConstraints:@[
                                              [self.createDateLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:2.5],
                                              [self.createDateLabel.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.createDateLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:2.5],
                                              [self.createDateLabel.heightAnchor constraintEqualToConstant:50],

                                              
                                              [self.editDateLabel.leadingAnchor constraintEqualToAnchor:self.createDateLabel.trailingAnchor],
                                              [self.editDateLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-2.5],
                                              [self.editDateLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:2.5],
                                              [self.editDateLabel.heightAnchor constraintEqualToConstant:50],

                                              
                                              [self.entryBodyTextView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5],
                                              [self.entryBodyTextView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-2.5],
                                              [self.entryBodyTextView.topAnchor constraintEqualToAnchor:self.editDateLabel.bottomAnchor constant:2.5],
                                              [self.entryBodyTextView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-2.5]
                                              ]
     ];
}

- (void)configureWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *createDate = dictionary[@"da"];
    NSNumber *editDate = dictionary[@"dm"];
    self.entryBodyTextView.text = dictionary[@"body"];
    self.createDateLabel.text = [NSString stringWithFormat:@"Created at:\n%@",[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[createDate floatValue]]]];
    self.editDateLabel.text  =  [NSString stringWithFormat:@"Edited at:\n%@",[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[editDate floatValue]]]];
    if ([editDate floatValue] == [createDate floatValue])
    {
        self.editDateLabel.hidden = YES;
    }
}
@end
