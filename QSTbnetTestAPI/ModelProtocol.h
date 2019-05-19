//
//  ModelProtocol.h
//  QSTbnetTestAPI
//
//  Created by Qstove on 07/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//


@protocol OutputModelProtocol <NSObject>

@optional
- (void)modelDidRefreshed;
- (void)coreDataDidRefreshed;
- (void)NWServiceError;

@end
