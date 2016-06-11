//
//  BangumiCollectionHeaderView.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiBannerItem.h"

@interface BangumiCollectionHeaderView : UICollectionReusableView

/**
 *  Banner数据
 */
@property (nonatomic, copy)
    NSArray<BangumiBannerItem *> *bannerList;
@end
