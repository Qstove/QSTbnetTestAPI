//
//  SessionListViewController.h
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/19/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelProtocol.h"


@interface SessionListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, OutputModelProtocol>

@end

