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
#import <MJExtension.h>

#import "BangumiCollectionHeaderView.h"
//模型
#import "BangumiResultModel.h"
#import "BangumiBannerItem.h"
#import "BangumiLatestUpdateModel.h"

@interface FanViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

//请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
/**banner Array*/
@property (nonatomic, copy) NSArray *bannerArray;
/**collectionView*/
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation FanViewController
#pragma mark - init
- (AFHTTPSessionManager *)mgr
{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (NSArray *)bannerArray
{
    if (!_bannerArray) {
        _bannerArray = [NSArray array];
    }
    return _bannerArray;
}

#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self requestData];
}

#pragma mark - Helpers
- (void)requestData
{
    //取消加载
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接parameter
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [self.mgr GET:@"http://bangumi.bilibili.com/api/app_index_page_v2?access_key=20819ee9177d90bd7b07ca20b6bd6727&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3360&device=phone&platform=ios&sign=8b2717cac07eae922f8302eeefe7212a&ts=1465654494" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BangumiResultModel *model = [BangumiResultModel mj_objectWithKeyValues:responseObject[@"result"]];
        self.bannerArray = model.banners;
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)setupCollectionView
{
    [self.view addSubview:({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.frame.size.width, 100);
        layout.minimumLineSpacing = 10;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor lightGrayColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCellIdentifier"];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BangumiCollectionHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderIndentifier"];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        collectionView;
    })];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellIdentifier" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"cell";
    label.frame = CGRectMake(20, 20, 100, 50);
    label.tintColor = [UIColor orangeColor];
    [cell.contentView addSubview:label];
    cell.backgroundColor = YLQRandomColor;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BangumiCollectionHeaderView *sectionHeaderView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderIndentifier" forIndexPath:indexPath];
        
        sectionHeaderView.bannerList = self.bannerArray;
        return sectionHeaderView;
    }
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 200);
}
@end
