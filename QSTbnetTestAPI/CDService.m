//
//  CDService.m
//  QSTbnetTestAPI
//
//  Created by Qstove on 17/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "CDService.h"

@interface CDService ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation CDService

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

- (instancetype) initUniqueInstance
{
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _context = _appDelegate.persistentContainer.viewContext;
    return [super init];
}

- (void)saveSessionWithID:(NSString*)sessionID entriesCount:(NSNumber*)count
{
    //сейвим только если такой сессии нет, если есть то проверяем не изменилось ли количесво записей.
    for(NSDictionary *session in self.results)
    {
        if( [session valueForKey:@"id"] == sessionID )
        {
            if([session valueForKey:@"entriesCount"] != count)
            {
                [session setValue:count forKey:@"entriesCount"];
                [session setValue:[NSDate date] forKey:@"creatingDate"];
                [self.appDelegate saveContext];
                [self.delegate dataDidUpdatedWith:self.results];
            }
            return;
        }
    }
    NSManagedObject *session = [NSEntityDescription insertNewObjectForEntityForName:@"Session" inManagedObjectContext:self.context];
    [session setValue:sessionID forKey:@"id"];
    [session setValue:count forKey:@"entriesCount"];
    [session setValue:[NSDate date] forKey:@"creatingDate"];
    [self.appDelegate saveContext];
    [self.delegate dataDidUpdatedWith:self.results];
}

- (NSArray*)results
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Session"];
    _results = [self.context executeFetchRequest:request error:nil];
    return _results;
}

- (void)deleteAll
{
    NSFetchRequest *fetchRequest =  [NSFetchRequest fetchRequestWithEntityName:@"Session"];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError *error;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [self.context deleteObject:object];
    }
    [self.appDelegate saveContext];
    [self.delegate dataDidUpdatedWith:self.results];
}
@end
