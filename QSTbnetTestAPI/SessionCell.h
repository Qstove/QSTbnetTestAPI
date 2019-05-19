//
//  SessionCell.h
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/19/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SessionCell : UITableViewCell

- (void)configureCellWith:(NSArray*)dictionary;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


