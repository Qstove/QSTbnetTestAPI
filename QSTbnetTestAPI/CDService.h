//
//  CDService.h
//  QSTbnetTestAPI
//
//  Created by Qstove on 17/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDServiceProtocol.h"
#import <CoreData/CoreData.h>

@interface CDService : NSObject

@property (nonatomic, weak) id <CDServiceProtocol> delegate;
@property (nonatomic, strong) NSArray *results;

+ (instancetype) sharedInstance;
+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
- (instancetype) copy __attribute__((unavailable("copy not available, call sharedInstance instead")));


@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext;
- (void)saveSessionWithID:(NSString*)sessionID entriesCount:(NSNumber*)count;
- (void)deleteAll;

@end

