//
//  NWServiceProtocol.h
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

typedef enum : NSUInteger {
    START,
    REFRESH,
    CREATE,
    DELETE,
    EDIT
}RequestType;

@protocol NWServiceOutputProtocol <NSObject>

- (void)refreshDidFinishedWith:(NSArray <NSArray *> *)array;
- (void)NWConnectionFailure;
- (void)sessionDidStarted:(NSString *)sessionID;
- (NSString *)getSessionID;
- (NSString *)getNoteText;

@end

