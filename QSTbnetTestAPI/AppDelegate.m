//
//  AppDelegate.m
//  QSTbnetTestAPI
//
//  Created by Анатолий Кустов on 5/6/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@property (strong, nonatomic)ViewController *vc;
@property (strong, nonatomic)UINavigationController *nc;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.vc = [ViewController new];
    self.nc = [[UINavigationController alloc]initWithRootViewController:self.vc];
    self.window.rootViewController = self.nc;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
