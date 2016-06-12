//
//  BangumiCollectionHeaderView.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiBannerItem.h"
#import "BangumiLatestUpdateModel.h"
#import "BangumiEndsItem.h"
#import "BangumiEpisodesItem.h"

@protocol BangumiCollectionHeaderViewDelegate <NSObject>

- (void)didSelectedIndexPath:(NSIndexPath *)indexPath withEpisodes:(NSArray<BangumiEpisodesItem *> *)episodesArray;

@end
@interface BangumiCollectionHeaderView : UICollectionReusableView

/**
 *  Banner数据
 */
@property (nonatomic, copy)
    NSArray<BangumiBannerItem *> *bannerList;
/**
 *  latestUpdate数据
 */
@property (nonatomic, strong) BangumiLatestUpdateModel *latestUpdateModel;
/**
 *  ends数据
 */
@property (nonatomic, strong) NSArray<BangumiEndsItem *> *endsArray;
/**
 *  代理
 */
@property (nonatomic, weak) id<BangumiCollectionHeaderViewDelegate> delegate;
@end
