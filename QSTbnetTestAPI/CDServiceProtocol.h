//
//  CDServiceProtocol.h
//  QSTbnetTestAPI
//
//  Created by Qstove on 17/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//


@protocol CDServiceProtocol <NSObject>

- (void)dataDidUpdatedWith:(NSArray <NSDictionary *> *)array;


@end
