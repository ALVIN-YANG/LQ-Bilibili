//
//  BangumiLatestUpdateListItem.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangumiLatestUpdateListItem : NSObject
/**
 *  cover  -->图片
 */
@property (nonatomic, copy) NSString *cover;
/**
 *  last_time -->更新时间
 */
@property (nonatomic, copy) NSString *last_time;
/**
 *  newest_ep_id -->当前 ID
 */
@property (nonatomic, copy) NSString *newest_ep_id;
/**
 *  newest_ep_index  -->当前第多少话
 */
@property (nonatomic, copy) NSString *newest_ep_index;
/**
 *  season_id
 */
@property (nonatomic, copy) NSString *season_id;
/**
 *  title  -->番命
 */
@property (nonatomic, copy) NSString *title;
/**
 *  total_count
 */
@property (nonatomic, copy) NSString *total_count;
/**
 *  watchingCount  -->上次看的集数, -1(没看过)
 */
@property (nonatomic, copy) NSString *watchingCount;
@end
