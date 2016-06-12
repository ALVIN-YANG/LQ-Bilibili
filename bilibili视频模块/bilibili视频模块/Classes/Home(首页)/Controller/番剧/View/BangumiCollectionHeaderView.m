//
//  BangumiCollectionHeaderView.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "BangumiCollectionHeaderView.h"
#import "YLQScrollPage.h"
#import "LQVerticalButton.h"
#import <Masonry.h>
#import "UIView+Frame.h"
#import "PlayerViewController.h"

#import "MidCollectionCell.h"
#import "SubReusableHeaderView.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import "BangumiDetailResultModel.h"

@interface BangumiCollectionHeaderView()<YLQScrollPageDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
//请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *mgr;

@property (nonatomic, copy) NSMutableArray *imageList;

@property (nonatomic, strong) YLQScrollPage *scrollPage;

@property (nonatomic, strong) UIView *regionView;

@property (nonatomic, strong) UIView *threeButtonView;

@property (nonatomic, strong) UIView *latestUpdateView;

@property (nonatomic, strong) UICollectionView *midCollection;

@property (nonatomic, strong) UICollectionView *bottomCollection;

@property (nonatomic, copy) NSArray *episodesArray;
@end

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

static NSString * const MidCellIdentifier = @"MidCellIdentifier";
static NSString * const MidHeaderIdentifier = @"MidHeaderIdentifier";
static NSString * const BottomCellIdentifier = @"BottomCellIdentifier";
static NSString * const BottomHeaderIdentifier = @"BottomHeaderIdentifier";
@implementation BangumiCollectionHeaderView
#pragma mark - init
- (AFHTTPSessionManager *)mgr
{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (NSMutableArray *)imageList
{
    if (!_imageList) {
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}

- (UIView *)latestUpdateView
{
    if (!_latestUpdateView) {
        _latestUpdateView = [[UIView alloc] init];
    }
    return _latestUpdateView;
}

- (UICollectionView *)midCollection
{
    if (!_midCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat margin = 12;
        CGFloat itemW = (self.latestUpdateView.frame.size.width - 3*margin) * 0.5;
        CGFloat itemH = (self.latestUpdateView.frame.size.height - 3 * margin - 40) / 3;
        layout.itemSize = CGSizeMake(itemW, itemH);
        
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(margin, 0, itemW*2+margin, itemH*3+margin*3 + 40) collectionViewLayout:layout];
        collectionView.contentSize = CGSizeMake(10, 0);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MidCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:MidCellIdentifier];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SubReusableHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MidHeaderIdentifier];
        
        _midCollection = collectionView;
        [self.latestUpdateView addSubview:_midCollection];
    }
    return _midCollection;
}

- (void)setBannerList:(NSArray<BangumiBannerItem *> *)bannerList
{
    _bannerList = bannerList;
    for (BangumiBannerItem *item in self.bannerList) {
        [self.imageList addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.img]]]];
    }
    [self setupScrollPage];
    [self setupRegionView];
    [self setupThreeButtonView];
    
}

- (void)setLatestUpdateModel:(BangumiLatestUpdateModel *)latestUpdateModel
{
    _latestUpdateModel = latestUpdateModel;
    [self setupLatestUpdate];
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
    self.scrollPage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
    self.scrollPage.direction = YLQInfiniteScrollViewDirectionHorizontal;
    [self addSubview:self.scrollPage];
}

- (void)setupRegionView
{
    self.regionView = [[UIView alloc] init];
    self.regionView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollPage.frame)+ 10, self.frame.size.width, 90);
    self.regionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.regionView];
    
    NSArray *imageName = @[@"hd_home_region_icon_33_60x60", @"hd_home_region_icon_32_60x60", @"hd_home_region_icon_153_60x60", @"hd_home_region_icon_152_60x60"];
    NSArray *labelName = @[@"连载动画", @"完结动画", @"国产动画", @"官方延伸"];
    CGFloat w = self.frame.size.width / imageName.count;
    
    for (int i = 0; i < imageName.count; i++) {
        UIImage *image = [UIImage imageNamed:imageName[i]];
        NSString *text = labelName[i];
        
        LQVerticalButton *button = [LQVerticalButton allocVerticalButton];
        CGFloat reginViewH = self.regionView.frame.size.height;
        [button setFrame:CGRectMake(i * w, 0, w, reginViewH) imageFrame:CGRectMake(15, 20, w - 30, reginViewH - 50) textFrame:CGRectMake(0, reginViewH - 32, w, 30) image:image text:text];
        [self.regionView addSubview:button];
    }
}

- (void)setupThreeButtonView
{
    NSArray *imageName = @[@"hd_home_bangumi_recommend_new", @"hd_home_bangumi_timeline_new", @"hd_home_bangumi_category_new"];
    self.threeButtonView = [[UIView alloc] init];
    self.threeButtonView.frame = CGRectMake(0, CGRectGetMaxY(self.regionView.frame) + 10, self.frame.size.width, 60);
    self.threeButtonView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.threeButtonView];
    CGFloat margin = 12;
    CGFloat w = (self.frame.size.width - margin * 4) / 3;
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (w + margin) + margin, margin-5, w, self.threeButtonView.frame.size.height - margin);
        
        
        [button setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
        [button.imageView setContentMode:UIViewContentModeCenter];
        [button.imageView setTransform:CGAffineTransformMakeScale(0.7, 0.78)];
        button.layer.cornerRadius = 7.0;
        button.layer.masksToBounds = YES;
        [self.threeButtonView addSubview:button];
    }
}

- (void)setupLatestUpdate
{
    self.latestUpdateView.frame = CGRectMake(0, CGRectGetMaxY(self.threeButtonView.frame) + 10, self.frame.size.width, 600);
    self.latestUpdateView.backgroundColor = [UIColor whiteColor];
    
    [self.midCollection reloadData];
    [self addSubview:self.latestUpdateView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MidCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MidCellIdentifier forIndexPath:indexPath];
    cell.item = self.latestUpdateModel.list[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SubReusableHeaderView *subReusableHeaderView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MidHeaderIdentifier forIndexPath:indexPath];
        subReusableHeaderView.updateCountLabel.text = self.latestUpdateModel.updateCount;
        return subReusableHeaderView;
    }
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.midCollection.frame.size.width, 40);
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //取消加载
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接parameter
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"season_id"] = self.latestUpdateModel.list[indexPath.row].season_id;
    [self.mgr GET:@"http://bangumi.bilibili.com/api/season_v3?access_key=20819ee9177d90bd7b07ca20b6bd6727&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3380&device=phone&mobi_app=iphone&platform=ios&sign=164b795f870b5300e3e3eb2f7307688b&ts=1465746488&type=bangumi" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [BangumiDetailResultModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"episodes" : @"BangumiEpisodesItem"
                     };
        }];
        BangumiDetailResultModel *model = [BangumiDetailResultModel mj_objectWithKeyValues:responseObject[@"result"]];
        self.episodesArray = model.episodes;
        //先直接跳转吧
        if ([self.delegate respondsToSelector:@selector(didSelectedIndexPath:withEpisodes:)]) {
            [self.delegate didSelectedIndexPath:indexPath withEpisodes:model.episodes];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}
@end
