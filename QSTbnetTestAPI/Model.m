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
@property(nonatomic, strong) CDService *cdService;
@property(nonatomic, strong) NSString *noteText;

@end


@implementation Model

+ (instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

- (instancetype) initUniqueInstance {
    _nwService = [NWService sharedInstance];
    _cdService = [CDService sharedInstance];
    _nwService.delegate = self;
    _cdService.delegate = self;
    _notesArray = [NSMutableArray array];
    _sessionArray = _cdService.results;
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

- (void)NWConnectionFailure
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.delegate NWServiceError];
    });
}

- (void)startSession
{
    [self.nwService okLets:START];
}

- (void)newEntryWith:(NSString *)text
{
    self.noteText = text;
    [self.nwService okLets:CREATE];
}

- (void)cleanCoreData
{
    [self.cdService deleteAll];
}

#pragma mark - NWService delegate
- (void)sessionDidStarted:(NSString *)sessionID
{
    self.sessionID = sessionID;
}

- (void)refreshDidFinishedWith:(NSArray <NSDictionary *> *)array
{
    self.notesArray = array;
    if(array.count)
    {
        [self.cdService saveSessionWithID:self.sessionID entriesCount:[NSNumber numberWithInteger:array.count]];
    }
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

#pragma mark - CDservice delegate
- (void)dataDidUpdatedWith:(NSArray <NSArray *> *)array
{
    self.sessionArray = array;
}

@end
