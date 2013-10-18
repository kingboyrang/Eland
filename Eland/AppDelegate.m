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
#import "ZAActivityBar.h"
#import "ServiceHelper.h"
#import "PushToken.h"
#import "NetWorkConnection.h"
#import "asyncHelper.h"
@implementation AppDelegate
@synthesize hasConnect;
@synthesize isLandscape;
- (void)dealloc
{
    [_window release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
-(void)registerAPNS{
    //注册推播
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
}
-(void)registerAPNSToken:(NSString*)deviceId{
    if ([deviceId length]==0) {
        [self registerAPNS];
        return;
    }
    UserSet *entity=[UserSet sharedInstance];
    if (![entity isRegisterToken]) {
        [ServiceHelper asynService:[PushToken registerTokenWithDeivceId:deviceId] success:^(ServiceResult *result) {
            [entity registerAppToken:deviceId status:YES];
            
        } failed:^(NSError *error, NSDictionary *userInfo) {
            [entity registerAppToken:deviceId status:NO];
        }];
    }
}
-(void)initParams{
    [ZAActivityBar setLocationTabBar];
    [self registerAPNS];
    self.isLandscape=NO;
    //横竖屏检测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectShowOrientation) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    //a2dce1 3bafb9
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor colorFromHexRGB:@"5cc2cb"]];
    //检测是否有网络
    [[NetWorkConnection sharedInstance] dynamicListenerNetwork:^(NetworkStatus status, BOOL isConnection) {
        self.hasConnect=isConnection;
    }];
    //背景任务
    [asyncHelper backgroundQueueLoad];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self initParams];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    UserSet *user=[UserSet sharedInstance];
    if (user.isSecondLoad==NO) {
        user.isSecondLoad=YES;
        user.isFirstLoad=YES;
        [user save];
    }
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

- (void)applicationDidEnterBackground:(UIApplication *)app
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) { //Check if our iOS version supports
        if ([[UIDevice currentDevice] isMultitaskingSupported]) { //Check if device supports mulitasking
            UIApplication *application = [UIApplication sharedApplication]; //Get the shared application instance
            
            __block UIBackgroundTaskIdentifier background_task; //Create a task object
            
            background_task = [application beginBackgroundTaskWithExpirationHandler: ^ {
                /*
                 当应用程序后台停留的时间为0时，会执行下面的操作（应用程序后台停留的时间为600s，可以通过backgroundTimeRemaining查看）
                 */
                [application endBackgroundTask: background_task]; //Tell the system that we are done with the tasks
                background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                
                //System will be shutting down the app at any point in time now
            }];
            
            // Background tasks require you to use asyncrous tasks
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //Perform your tasks that your application requires
                NSLog(@"time remain:%f", app.backgroundTimeRemaining);
                
                [application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
            });
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self registerAPNSToken:[[UserSet sharedInstance] AppToken]];
    //背景任务
    [asyncHelper backgroundQueueLoad];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - APNS 回傳結果
// 成功取得設備編號token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceId = [[deviceToken description]
                          substringWithRange:NSMakeRange(1, [[deviceToken description] length]-2)];
    deviceId = [deviceId stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceId = [deviceId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [self registerAPNSToken:deviceId];
}
#pragma mark -
#pragma mark 接收的推播信息
- (void) application:(UIApplication *) app didReceiveRemoteNotification:(NSDictionary *) userInfo
{
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=nil) {
        NSString *post=[userInfo objectForKey:@"guid"];
        NSDictionary  *dic=[NSDictionary dictionaryWithObjectsAndKeys:post,@"guid", nil];
        NSNotification *notification = [NSNotification notificationWithName:kPushNotificeName object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:NO];
    }

}
// 或無法取得設備編號token
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //表示信息推播失败
}
@end
