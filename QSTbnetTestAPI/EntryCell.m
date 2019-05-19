//
//  EntryCell.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/8/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "EntryCell.h"


@interface EntryCell ()

@property (nonatomic, strong) UILabel *entryLabel;
@property (nonatomic, strong) UILabel *createDateLabel;
@property (nonatomic, strong) UILabel *editDateLabel;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end


@implementation EntryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"d MMM H:mm";
        
        _entryLabel = [UILabel new];
        _entryLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _entryLabel.adjustsFontSizeToFitWidth = YES;
        _entryLabel.numberOfLines = 5;
        _entryLabel.minimumScaleFactor = 0.7;
        [self.contentView addSubview: _entryLabel];
        
        _createDateLabel = [UILabel new];
        _createDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _createDateLabel.adjustsFontSizeToFitWidth = YES;
        _createDateLabel.numberOfLines = 2;
        _createDateLabel.minimumScaleFactor=0.5;
        _createDateLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        _createDateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: _createDateLabel];
        
        _editDateLabel = [UILabel new];
        _editDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _editDateLabel.adjustsFontSizeToFitWidth = YES;
        _editDateLabel.numberOfLines = 2;
        _editDateLabel.minimumScaleFactor=0.5;
        _editDateLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        _editDateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: _editDateLabel];
        
        [self makeConstraints];
    }
    return self;
}

- (void)makeConstraints
{
     [NSLayoutConstraint activateConstraints:@[
                                               [self.entryLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:2.5],
                                               [self.entryLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:2.5],
                                               [self.entryLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-2.5],
                                               [self.entryLabel.widthAnchor constraintEqualToConstant:CGRectGetWidth(self.contentView.bounds)*0.8],
                                               
                                               [self.createDateLabel.leadingAnchor constraintEqualToAnchor:self.entryLabel.trailingAnchor constant:2.5],
                                               [self.createDateLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-2.5],
                                               [self.createDateLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:2.5],
                                               [self.createDateLabel.bottomAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                               
                                               [self.editDateLabel.leadingAnchor constraintEqualToAnchor:self.entryLabel.trailingAnchor constant:2.5],
                                               [self.editDateLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-2.5],
                                               [self.editDateLabel.topAnchor constraintEqualToAnchor:self.createDateLabel.bottomAnchor],
                                               [self.editDateLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-2.5]
                                               ]
      ];
}

- (void)configureCellWith:(NSDictionary*)dictionary
{
    NSNumber *createDate = [dictionary objectForKey:@"da"];
    NSNumber *editDate = [dictionary objectForKey:@"dm"];
    NSString *entryBody = @"";
    if(((NSString*)[dictionary objectForKey:@"body"]).length > 200)
    {
        entryBody = [NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"body"] substringWithRange:NSMakeRange(0,200)]];
        entryBody = [entryBody stringByAppendingString:@" ..."];
    }
    else
    {
        entryBody = [dictionary objectForKey:@"body"];
    }
    self.entryLabel.text = entryBody;
    self.createDateLabel.text = [NSString stringWithFormat:@"Created at:\n%@",[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[createDate floatValue]]]];
    self.editDateLabel.text  =  [NSString stringWithFormat:@"Edited at:\n%@",[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[editDate floatValue]]]];
    if ([editDate floatValue] == [createDate floatValue])
    {
        self.editDateLabel.hidden = YES;
    }
}

@end
