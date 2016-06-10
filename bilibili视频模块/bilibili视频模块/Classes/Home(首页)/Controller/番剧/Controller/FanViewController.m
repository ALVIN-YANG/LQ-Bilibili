//
//  FanViewController.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/7.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "FanViewController.h"
#import "LQMacro.h"
#import "UIView+Frame.h"
#import "PlayerViewController.h"
#import <AFNetworking.h>

@interface FanViewController ()

//请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
@end

@implementation FanViewController
#pragma mark - init
- (AFHTTPSessionManager *)mgr{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"播放" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    button.backgroundColor = YLQRandomColor;
    button.ylq_width = 200;
    button.ylq_height = 150;
    button.center = self.view.center;
    [button addTarget:self action:@selector(playTheVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)playTheVideo
{
    PlayerViewController *playerVC = [[UIStoryboard storyboardWithName:NSStringFromClass([PlayerViewController class]) bundle:nil] instantiateInitialViewController];
    playerVC.videoURL = [NSURL URLWithString:@"http://www.bilibilijj.com/Files/DownLoad/7903739.mp4/www.bilibilijj.com.mp4?mp3=true"];
    [self.navigationController pushViewController:playerVC animated:YES];
}

@end
