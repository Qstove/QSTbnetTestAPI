//
//  SessionCell.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/19/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SessionCell.h"

@interface SessionCell ()

@property (nonatomic, strong) UILabel *sessionIDLabel;
@property (nonatomic, strong) UILabel *createDateLabel;
@property (nonatomic, strong) UILabel *entriesCountLabel;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end


@implementation SessionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"d MMM H:mm";
        
        _sessionIDLabel = [UILabel new];
        _sessionIDLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _sessionIDLabel.adjustsFontSizeToFitWidth = YES;
        _sessionIDLabel.numberOfLines = 1;
        _sessionIDLabel.minimumScaleFactor = 0.8;
        _sessionIDLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        [self.contentView addSubview: _sessionIDLabel];
        
        _createDateLabel = [UILabel new];
        _createDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _createDateLabel.adjustsFontSizeToFitWidth = YES;
        _createDateLabel.numberOfLines = 2;
        _createDateLabel.minimumScaleFactor=0.5;
        _createDateLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        _createDateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: _createDateLabel];
        
        _entriesCountLabel = [UILabel new];
        _entriesCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _entriesCountLabel.adjustsFontSizeToFitWidth = YES;
        _entriesCountLabel.numberOfLines = 1;
        _entriesCountLabel.minimumScaleFactor=0.5;
        _entriesCountLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        _entriesCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: _entriesCountLabel];
        
        [self makeConstraints];
    }
    
    return self;
}

- (void)makeConstraints
{
    [NSLayoutConstraint activateConstraints:@[
                                              [self.sessionIDLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:2.5],
                                              [self.sessionIDLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:2.5],
                                              [self.sessionIDLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-2.5],
                                              [self.sessionIDLabel.widthAnchor constraintEqualToConstant:CGRectGetWidth(self.contentView.bounds)*0.8],
                                              
                                              [self.createDateLabel.leadingAnchor constraintEqualToAnchor:self.sessionIDLabel.trailingAnchor constant:2.5],
                                              [self.createDateLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-2.5],
                                              [self.createDateLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:2.5],
                                              [self.createDateLabel.bottomAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              
                                              [self.entriesCountLabel.leadingAnchor constraintEqualToAnchor:self.sessionIDLabel.trailingAnchor constant:2.5],
                                              [self.entriesCountLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-2.5],
                                              [self.entriesCountLabel.topAnchor constraintEqualToAnchor:self.createDateLabel.bottomAnchor],
                                              [self.entriesCountLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-2.5]
                                              ]
     ];
}

- (void)configureCellWith:(NSArray*)array
{
    NSString *sessionID = [array valueForKey:@"id"];
    NSDate *createDate = [array valueForKey:@"creatingDate"];
    NSNumber *entriesCount = [array valueForKey:@"entriesCount"];
    
    self.sessionIDLabel.text = [NSString stringWithFormat:@"ID: %@", sessionID];
    self.createDateLabel.text = [NSString stringWithFormat:@"Created at:\n%@",[self.dateFormatter stringFromDate:createDate]];
    self.entriesCountLabel.text  =  [NSString stringWithFormat:@"Entries count:%@", entriesCount];
    
}

@end
