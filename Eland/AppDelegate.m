//
//  AppDelegate.m
//  Eland
//
//  Created by aJia on 13/9/10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UIColor+TPCategory.h"
#import "UserSet.h"
#import "SecrecyViewController.h"
@implementation AppDelegate
@synthesize hasConnect;
@synthesize isLandscape;
- (void)dealloc
{
    [_window release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.isLandscape=NO;
    //横竖屏检测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectShowOrientation) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    //a2dce1 3bafb9
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor colorFromHexRGB:@"5cc2cb"]];
    
    UserSet *user=[UserSet sharedInstance];
    if (!user.isReadPrivacy) {
        SecrecyViewController *privacy=[[SecrecyViewController alloc] init];
        privacy.title=@"隱私及資訊安全保護政策";
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:privacy];
        self.window.rootViewController = nav;
        [privacy release];
        [nav release];
    }else{
        MainViewController *main=[[[MainViewController alloc] init] autorelease];
        self.window.rootViewController = main;
    }
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark 横竖屏检测
-(void)detectShowOrientation{
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft ||[UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight){//横屏
        self.isLandscape=YES;
    }else{//竖屏
        self.isLandscape=NO;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
