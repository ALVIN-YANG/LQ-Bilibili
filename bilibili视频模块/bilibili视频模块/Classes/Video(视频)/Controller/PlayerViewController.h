//
//  PlayerViewController.h
//  ZFPlayer试用
//
//  Created by 杨卢青 on 16/6/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiEpisodesItem.h"

@interface PlayerViewController : UIViewController
/**
 *  视频URL
 */
@property (nonatomic, strong) NSURL *videoURL;
/**
 *  视频模型列表
 */
@property (nonatomic, copy) NSArray<BangumiEpisodesItem *> *episodesArray;
@end
