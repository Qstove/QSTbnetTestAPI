//
//  NWService.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "NWService.h"


@interface NWService ()

@property (nonatomic, strong) NSURLSession *session;

@end


@implementation NWService

+(instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

-(instancetype) initUniqueInstance {
    return [super init];
}


-(void)okLets:(RequestType)type
{
#pragma mark - CompletionHandlers
    void(^startCompletionHandler)(NSData *, NSURLResponse * , NSError * )=^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if(error)
        {
            [self.session finishTasksAndInvalidate];
            [self.delegate NWConnectionFailure];
        }
        else
        {
            NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [self.delegate sessionDidStarted:[[temp objectForKey:@"data"] objectForKey:@"session"]];
            [self.session finishTasksAndInvalidate];
        }
    };
    
    void(^refreshCompletionHandler)(NSData *, NSURLResponse * , NSError * )=^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if(error)
        {
            [self.session finishTasksAndInvalidate];
            [self.delegate NWConnectionFailure];
        }
        else
        {
            NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSArray *arr = [[temp objectForKey:@"data"] firstObject];
            NSMutableArray <NSArray *> *finArr = [NSMutableArray array];
            for (NSArray *dictArr in arr)
            {
                if (dictArr.count)
                {
                    [finArr addObject:dictArr];
                }
            }
            [self.delegate refreshDidFinishedWith:finArr];
            [self.session finishTasksAndInvalidate];
        }
    };
    
    void(^createCompletionHandler)(NSData *, NSURLResponse * , NSError * )=^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if(error)
        {
            [self.session finishTasksAndInvalidate];
            [self.delegate NWConnectionFailure];
        }
        else
        {
            NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@", temp);
            [self.session finishTasksAndInvalidate];
        }
    };
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:@"https://bnet.i-partner.ru/testAPI/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"VCAuRkt-hL-FsQhGd3" forHTTPHeaderField:@"token"];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:15];
    NSURLSessionDataTask *sessionDataTask;
    NSString *postString;
    NSData *postData;

    switch (type) {
        case START:
            postString = [NSString stringWithFormat:@"a=new_session"];
            postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            [request setHTTPBody:postData];
            sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:startCompletionHandler];
            break;
            
        case REFRESH:
            postString = [NSString stringWithFormat:@"a=get_entries&session=%@", [self.delegate getSessionID]];
            postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            [request setHTTPBody:postData];
            sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:refreshCompletionHandler];
            break;
            
        case CREATE:
            postString = [NSString stringWithFormat:@"a=add_entry&session=%@&body=%@", [self.delegate getSessionID], [self.delegate getNoteText]];
            postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            [request setHTTPBody:postData];
            sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:createCompletionHandler];
            break;
            
        case DELETE:
            //Coming soon ;)
            break;
            
        case EDIT:
            //Coming soon ;)
            break;
    }
    [sessionDataTask resume];
}


@end

