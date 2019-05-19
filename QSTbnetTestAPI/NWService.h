//
//  NWService.h
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWServiceProtocol.h"


@interface NWService : NSObject

@property (nonatomic, weak) id <NWServiceProtocol> delegate;

+ (instancetype) sharedInstance;
+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
- (instancetype) copy __attribute__((unavailable("copy not available, call sharedInstance instead")));

- (void)okLets:(NWRequestType)type;

@end

