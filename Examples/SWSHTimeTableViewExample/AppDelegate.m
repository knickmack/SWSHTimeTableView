//
//  AppDelegate.m
//  SWSHTimeTableViewExample
//
//  Created by Nik Macintosh on 2013-07-22.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "AppDelegate.h"
#import "SWSHTimeTableViewController.h"

@implementation AppDelegate

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.rootViewController = [SWSHTimeTableViewController new];
    }
    
    return _window;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];

    return YES;
}

@end
