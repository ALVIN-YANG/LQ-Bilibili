//
//  PlayerViewController.m
//  ZFPlayer试用
//
//  Created by 杨卢青 on 16/6/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry.h>
#import "ZFPlayerView.h"

@interface PlayerViewController ()
@property (weak, nonatomic) IBOutlet ZFPlayerView *playerView;


@end

@implementation PlayerViewController
#pragma mark - life Cycle
- (void)dealloc
{
    NSLog(@"%@释放了", self.class);
    /**
     *  取消延时隐藏controlView的方法,在ViewController的delloc方法中调用
     *  用于解决：刚打开视频播放器，就关闭该页面，maskView的延时隐藏还未执行。
     */
    [self.playerView cancelAutoFadeOutControlBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456653443902B.mp4"];
    
    // Do any additional setup after loading the view.
    
    self.playerView.videoURL = self.videoURL;
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    //打开断点下载功能(默认没有这个功能)
    self.playerView.hasDownload = YES;
    
    // 如果想从xx秒开始播放视频
    // self.playerView.seekTime = 15;
    
    //是否自动播放, 默认不自动播放
    [self.playerView autoPlayTheVideo];
    
    __weak typeof(self) weakSelf = self;
    self.playerView.goBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
