//
//  LQNavigationController.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "LQNavigationController.h"

@interface LQNavigationController ()

@end

@implementation LQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  非跟控制器隐藏TabBar
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果push过来的控制器不是第一个
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    // 意思是，我们任然可以重新在push控制器的viewDidLoad方法中设置导航栏的leftBarButtonItem，如果设置了就会覆盖在push方法中设置的“返回”按钮，因为 [super push....]会加载push的控制器执行viewDidLoad方法。
    [super pushViewController:viewController animated:animated];
}

@end
