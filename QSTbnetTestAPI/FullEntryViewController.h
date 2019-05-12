//
//  FullEntryViewController.h
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/12/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FullEntryViewController : UIViewController

@property (nonatomic, strong) NSDictionary *data;

- (void)configureWithDictionary:(NSDictionary *)dictionary;


@end

