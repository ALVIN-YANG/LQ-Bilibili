//
//  BangumiResultModel.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiBannerItem.h"
#import "BangumiEndsItem.h"

@interface BangumiResultModel : NSObject
/**
 *  banners  -->头部banner
 */
@property (nonatomic, copy)
    NSArray<BangumiBannerItem *> *banners;
/**
 *  latestUpdate -->新番连载
 */
@property (nonatomic, copy) NSDictionary *latestUpdate;
/**
 *  ends    -->完结动画
 */
@property (nonatomic, copy)
    NSArray<BangumiEndsItem *> *ends;
@end
