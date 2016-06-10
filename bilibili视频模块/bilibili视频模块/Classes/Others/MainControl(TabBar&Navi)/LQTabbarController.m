//
//  LQTabbarController.m
//  Pinterest-Demo
//
//  Created by 杨卢青 on 16/5/28.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "LQTabbarController.h"

#import "PlayerViewController.h"
#import "ZFPlayer.h"

@interface LQTabbarController ()

@end

@implementation LQTabbarController

#pragma mark - life Cycle
- (void)awakeFromNib
{
    self.selectedIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - rewrite
//1.设置页面是否支持转屏
- (BOOL)shouldAutorotate
{
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    
    //PlayerViewController 和 全屏的控制器支持自动转屏
    if ([nav.topViewController isKindOfClass:[PlayerViewController class]]) {
        //调用ZFPlayerSingleton单例记录播放状态是否锁定屏幕方向
        return !ZFPlayerShared.isLockScreen;
    }
    return NO;
}

//2. 支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    //两个方向都支持
    if ([nav.topViewController isKindOfClass:[PlayerViewController class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    //其他页面
    return UIInterfaceOrientationMaskPortrait;
}
@end
