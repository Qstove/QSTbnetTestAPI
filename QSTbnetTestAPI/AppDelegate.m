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




@end

