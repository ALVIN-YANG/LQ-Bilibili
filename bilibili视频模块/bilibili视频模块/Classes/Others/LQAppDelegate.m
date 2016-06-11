//
//  AppDelegate.m
//  Pinterest-Demo
//
//  Created by 杨卢青 on 16/5/28.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "LQAppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIImageView *iconImageView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    HomeViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    
   //启动动画
    [self launchAnimation];
  
    return YES;
}

- (void)launchAnimation{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"bilibili_splash_iphone_bg"];
    
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 7.5, [UIScreen mainScreen].bounds.size.height/2 - 100, 30, 40)];
    [self.iconImageView setImage:[UIImage imageNamed:@"bilibili_splash_default"]];
    
    [window addSubview:self.bgImageView];
    [window addSubview:self.iconImageView];
    
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.iconImageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 10.0f, 10.0f, 1.0f);
    } completion:^(BOOL finished) {
        [self dismissAll];
    }];
}

- (void)dismissAll{
    [self.bgImageView removeFromSuperview];
    [self.iconImageView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
