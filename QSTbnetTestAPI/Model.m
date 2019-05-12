//
//  Model.m
//  QSTbnetTestAPI
//
//  Created by Qstove on 07/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "Model.h"

@interface Model ()

@property(nonatomic, strong) NWService *nwService;
@property(nonatomic, strong) NSString *sessionID;
@property(nonatomic, strong) NSString *noteText;

@end

@implementation Model

+(instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

-(instancetype) initUniqueInstance {
    _nwService = [NWService sharedInstance];
    _nwService.delegate = self;
    _notesArray = [NSMutableArray array];
    [self startSession];
    return [super init];
}

- (void)refreshData
{
    if(!self.sessionID)
    {
        [self startSession];
    }
    [self.nwService okLets:REFRESH];
}

-(void)NWConnectionFailure
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.delegate NWServiceError];
    });}

- (void)startSession
{
    [self.nwService okLets:START];
}

- (void)newEntryWith:(NSString *)text
{
    self.noteText = text;
    [self.nwService okLets:CREATE];
}


#pragma mark - NWService delegate
- (void)sessionDidStarted:(NSString *)sessionID
{
    self.sessionID = sessionID;
    NSLog(@"sessionID = %@", self.sessionID);
}

- (void)refreshDidFinishedWith:(NSArray <NSDictionary *> *)array
{
    self.notesArray = array;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.delegate modelDidRefreshed];
    });
}

- (NSString *)getSessionID
{
    return self.sessionID;
}

- (NSString *)getNoteText
{
    return self.noteText;
}



@end
