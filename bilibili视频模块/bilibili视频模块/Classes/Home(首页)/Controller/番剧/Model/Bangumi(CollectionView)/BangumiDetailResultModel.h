//
//  BangumiDetailResultModel.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/13.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiEpisodesItem.h"

@interface BangumiDetailResultModel : NSObject

/**
 *  episodes -->选集
 */
@property (nonatomic, copy) NSArray<BangumiEpisodesItem *> *episodes;
@end
