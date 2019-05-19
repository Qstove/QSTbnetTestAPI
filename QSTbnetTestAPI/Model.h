//
//  Model.h
//  QSTbnetTestAPI
//
//  Created by Qstove on 07/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"
#import "NWService.h"
#import "CDService.h"


@interface Model : NSObject <NWServiceProtocol , CDServiceProtocol>

@property(nonatomic, weak) id <OutputModelProtocol> delegate;
@property(nonatomic, copy) NSArray <NSDictionary *> *notesArray;
@property(nonatomic, copy) NSArray <NSArray *> *sessionArray;
@property(nonatomic, strong) NSString *sessionID;

+ (instancetype) sharedInstance;
+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
- (instancetype) copy __attribute__((unavailable("copy not available, call sharedInstance instead")));

- (void)startSession;
- (void)refreshData;
- (void)newEntryWith:(NSString *)text;
- (void)cleanCoreData;


@end

