//
//  BangumiCollectionHeaderView.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "BangumiCollectionHeaderView.h"
#import "YLQScrollPage.h"

@interface BangumiCollectionHeaderView()<YLQScrollPageDelegate>
@property (nonatomic, strong) NSMutableArray *imageList;

@property (nonatomic, strong)YLQScrollPage *scrollPage;
@end

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
@implementation BangumiCollectionHeaderView
- (NSMutableArray *)urlList
{
    if (!_imageList) {
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}

- (void)setBannerList:(NSArray<BangumiBannerItem *> *)bannerList
{
    _bannerList = bannerList;
    for (BangumiBannerItem *item in self.bannerList) {
        [self.imageList addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.img]]]];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupScrollPage];
}

- (void)setupScrollPage
{
   
    self.scrollPage = [[YLQScrollPage alloc] init];
    
    self.scrollPage.images = self.imageList;
    
    self.scrollPage.delegate = self;
    self.scrollPage.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.scrollPage.pageControl.currentPageIndicatorTintColor = UIColorFromHex(0xFB769E);
    self.scrollPage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
    self.scrollPage.direction = YLQInfiniteScrollViewDirectionHorizontal;
    [self addSubview:self.scrollPage];
}
@end
