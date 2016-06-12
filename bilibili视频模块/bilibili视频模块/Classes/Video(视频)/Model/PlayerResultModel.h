//
//  PlayerResultModel.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/13.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerURLItem.h"

@interface PlayerResultModel : NSObject

/**
 *  list
 */
@property (nonatomic, copy) NSArray<PlayerURLItem *> *list;
@end
