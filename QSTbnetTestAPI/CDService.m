//
//  CDService.m
//  QSTbnetTestAPI
//
//  Created by Qstove on 17/05/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "CDService.h"


@interface CDService ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end


@implementation CDService
@synthesize persistentContainer = _persistentContainer;

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
    _context = self.persistentContainer.viewContext;
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
                [self saveContext];
                [self.delegate dataDidUpdatedWith:self.results];
            }
            return;
        }
    }
    NSManagedObject *session = [NSEntityDescription insertNewObjectForEntityForName:@"Session" inManagedObjectContext:self.context];
    [session setValue:sessionID forKey:@"id"];
    [session setValue:count forKey:@"entriesCount"];
    [session setValue:[NSDate date] forKey:@"creatingDate"];
    [self saveContext];
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
    [self saveContext];
    [self.delegate dataDidUpdatedWith:self.results];
}

#pragma mark - Core Data stack
- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self)
    {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"QSTbnetTestAPI"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil)
                {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark - Core Data Saving support
- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
