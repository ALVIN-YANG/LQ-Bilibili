//
//  HomeViewController.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/7.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "HomeViewController.h"
#import "FanViewController.h"
#import "DanceViewController.h"
#import "MusicViewController.h"
#import "LQTitleButton.h"
#import "UIView+Frame.h"
#import "LQMacro.h"
#import <AFNetworking.h>

#import "PlayerViewController.h"


@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIView *titleView;
@property (nonatomic, weak)LQTitleButton *preSelectedBtn;
@property (nonatomic, weak)UIView *subLine;
@property (nonatomic, copy)NSMutableArray *titleButtons;


//请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
@end

@implementation HomeViewController
#pragma mark - init
- (AFHTTPSessionManager *)mgr{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

#pragma mark - lazy load
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self.navigationController setNavigationBarHidden:YES];
    
    //请求数据
    [self requestNewData];
    //设置ScrollView
    [self setupScrollView];
    //设置title
    [self setupTitle];
    //设置子控制器
    [self setupViewController];
    //设置下划线
    [self setupSubLine];

}

#pragma mark - Helper
- (void)requestNewData
{
    //取消加载
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
   
    //拼接parameter
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [self.mgr GET:@"http://bangumi.bilibili.com/api/app_index_page_v2?access_key=20819ee9177d90bd7b07ca20b6bd6727&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3360&device=phone&platform=ios&sign=8b2717cac07eae922f8302eeefe7212a&ts=1465654494" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         [responseObject writeToFile:@"/Users/YLQ/Desktop/bilibili-Demo/Bangumi(Top).plist" atomically:YES];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)setupScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.backgroundColor = [UIColor cyanColor];
    self.scrollView = scroll;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:scroll];
}

- (void)setupTitle
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    self.titleView = view;
    
    [self.navigationController.navigationBar insertSubview:view atIndex:0];
    [self.view addSubview:view];
    
    //titleButton
    NSArray *btns = @[@"番剧", @"舞蹈", @"音乐"];
    NSInteger count = btns.count;
    CGFloat btnX ,btnW;
    for (NSInteger i = 0; i < count; i++) {
        btnW = self.titleView.bounds.size.width / count;
        btnX = i * btnW;
        
        LQTitleButton *btn = [[LQTitleButton alloc] init];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        btn.frame = CGRectMake(btnX, 20, btnW, self.titleView.bounds.size.height-20);
        btn.tag = i;
        [self.titleButtons addObject:btn];
        [btn setTitle:btns[i] forState:UIControlStateNormal];
    }

}

/**
 *  添加子控制器
 */
- (void)setupViewController
{
    
    [self addChildViewController:[[FanViewController alloc] init]];
    [self addChildViewController:[[DanceViewController alloc] init]];
    [self addChildViewController:[[MusicViewController alloc] init]];
    
    //添加控制器的View到scrollView
    NSUInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
       
        vc.view.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        vc.view.backgroundColor = YLQRandomColor;
        [self.scrollView addSubview:vc.view];
    }
    //设置scrollView
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.frame.size.width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //取消自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupSubLine
{
    LQTitleButton *firstBtn = self.titleView.subviews.firstObject;
    UIView *subLine = [[UIView alloc] init];
    subLine.frame = CGRectMake(0, self.titleView.frame.size.height - 2, ScreenW/3, 2);
    subLine.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:subLine];
    self.subLine = subLine;
    //默认选中第一个
    firstBtn.selected = YES;
    self.preSelectedBtn = firstBtn;
    [firstBtn.titleLabel sizeToFit];
    self.subLine.ylq_center_X = firstBtn.ylq_center_X;
}

- (void)titleBtnClick:(LQTitleButton *)btn{
    //如果是重复点击
    if (self.preSelectedBtn == btn) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:YLQTitleBarButtonDidRepeatClickNotification object:nil];
    }
    [self dealTitleButtonClick:btn];
}

- (void)dealTitleButtonClick:(LQTitleButton *)titleButton{
    
    
    //切换按钮状态
    for (LQTitleButton *btn in self.titleButtons) {
        btn.selected = NO;
        [btn setTitleColor:LQNavTintColor forState:UIControlStateNormal];
        [btn setTitleColor:LQMainColor forState:UIControlStateSelected];
    }
    self.preSelectedBtn.selected = NO;
    titleButton.selected = YES;
    self.preSelectedBtn = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        //下划线
        [titleButton.titleLabel sizeToFit];
        self.subLine.ylq_center_X = titleButton.ylq_center_X;
        //scroll
        CGFloat offsetX = titleButton.tag * self.scrollView.ylq_width;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    }];
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 按钮索引
    NSInteger index = scrollView.contentOffset.x / scrollView.ylq_width;
    // 找到按钮
    LQTitleButton *titleButton = self.titleView.subviews[index];
    // 点击按钮
    [self dealTitleButtonClick:titleButton];
}

// 只要滚动 就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat rad =  scrollView.contentOffset.x *(ScreenW / scrollView.contentSize.width);
    self.subLine.ylq_x = rad;
    // 让按钮形变
    NSInteger leftI = scrollView.contentOffset.x / ScreenW;
    NSInteger rightI = leftI + 1;
    
    // 1.获取需要形变的按钮
    
    // left
    // 获取左边按钮
    UIButton *leftButton = (UIButton *)self.titleButtons[leftI];
    
    // right
    NSUInteger count = self.childViewControllers.count;
    UIButton *rigthButton;
    // 获取右边按钮
    if (rightI < count) {
        rigthButton = self.titleButtons[rightI];
    }
    
    // 计算右边按钮偏移量
    CGFloat rightScale = scrollView.contentOffset.x / ScreenW;
    NSLog(@"%f", rightScale);
    // 只想要 0~1
    rightScale = rightScale - leftI;
    
    // 颜色渐变
    [rigthButton setTitleColor:Color(rightScale *(255-145)+145, rightScale * (114-145)+145, rightScale*(153-141)+141) forState:UIControlStateNormal];
    
    [leftButton setTitleColor:Color((1-rightScale) *(255-145)+145, (1-rightScale) * (114-145)+145, (1-rightScale)*(153-141)+141) forState:UIControlStateNormal];

}

@end
