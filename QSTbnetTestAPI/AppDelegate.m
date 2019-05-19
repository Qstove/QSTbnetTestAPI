//
//  AppDelegate.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SessionListViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *tabBarVC = [UITabBarController new];
    UINavigationController *ncEntries = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    UINavigationController *ncSessions = [[UINavigationController alloc]initWithRootViewController:[SessionListViewController new]];
    ncEntries.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Entries" image:[UIImage imageNamed:@"list"] tag:0];
    ncSessions.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Sessions" image:[UIImage imageNamed:@"clock"] tag:1];
    [tabBarVC setViewControllers:@[ncEntries, ncSessions]];
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;

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

