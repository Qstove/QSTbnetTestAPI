//
//  NWServiceProtocol.h
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

typedef NS_ENUM(NSUInteger, NWRequestType)
{
    NWRequestTypeSTART,
    NWRequestTypeREFRESH,
    NWRequestTypeCREATE,
    NWRequestTypeDELETE,
    NWRequestTypeEDIT
};


@protocol NWServiceProtocol <NSObject>

- (void)refreshDidFinishedWith:(NSArray <NSArray *> *)array;
- (void)NWConnectionFailure;
- (void)sessionDidStarted:(NSString *)sessionID;
- (NSString *)getSessionID;
- (NSString *)getNoteText;

@end

