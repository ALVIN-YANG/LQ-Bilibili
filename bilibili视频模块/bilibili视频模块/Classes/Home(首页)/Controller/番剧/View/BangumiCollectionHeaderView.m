//
//  BangumiCollectionHeaderView.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "BangumiCollectionHeaderView.h"
#import "YLQScrollPage.h"
#import <Masonry.h>

@interface BangumiCollectionHeaderView()<YLQScrollPageDelegate>
@property (nonatomic, copy) NSMutableArray *imageList;

@property (nonatomic, strong)YLQScrollPage *scrollPage;

@property (nonatomic, strong)UIView *regionView;
@end

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
@implementation BangumiCollectionHeaderView
- (NSMutableArray *)imageList
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
    [self setupScrollPage];
    [self setupRegionView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setupScrollPage
{
   
    self.scrollPage = [[YLQScrollPage alloc] init];
    
    self.scrollPage.images = self.imageList;
    self.scrollPage.delegate = self;
    self.scrollPage.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.scrollPage.pageControl.currentPageIndicatorTintColor = UIColorFromHex(0xFB769E);
    self.scrollPage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130);
    self.scrollPage.direction = YLQInfiniteScrollViewDirectionHorizontal;
    [self addSubview:self.scrollPage];
}

- (void)setupRegionView
{
    self.regionView = [[UIView alloc] init];
    self.regionView.frame = CGRectMake(0, 140, self.frame.size.width, 100);
    self.regionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.regionView];
    
    NSArray *imageName = @[@"hd_home_region_icon_33_60x60", @"hd_home_region_icon_32_60x60", @"hd_home_region_icon_153_60x60", @"hd_home_region_icon_152_60x60"];
    NSArray *labelName = @[@"连载动画", @"完结动画", @"国产动画", @"官方延伸"];
    CGFloat w = self.frame.size.width / imageName.count;
    
    for (int i = 0; i < imageName.count; i++) {
        UIImage *image = [UIImage imageNamed:imageName[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * w + 20, 15, w-40, self.regionView.frame.size.height - 40)];
        
        imageView.image = image;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * w, self.regionView.frame.size.height - 20, w, 15)];
        label.text = labelName[i];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.font = [UIFont systemFontOfSize:15];
        
        [self.regionView addSubview:imageView];
        [self.regionView addSubview:label];
    }
}
@end
