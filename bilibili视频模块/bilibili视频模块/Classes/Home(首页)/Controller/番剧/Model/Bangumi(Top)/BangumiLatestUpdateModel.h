//
//  BangumiLatestUpdateModel.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiLatestUpdateListItem.h"

@interface BangumiLatestUpdateModel : NSObject
/**
 *  list -->新番连载列表
 */
@property (nonatomic, copy)
    NSArray<BangumiLatestUpdateListItem *> *list;
/**
 *  updateCount -->今日更新 数目
 */
@property (nonatomic, copy) NSString *updateCount;
@end
