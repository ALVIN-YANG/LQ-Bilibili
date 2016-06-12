//
//  MidCollectionCell.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/12.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "MidCollectionCell.h"
#import <UIImageView+WebCache.h>

@interface MidCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *watchingBackView;
@property (weak, nonatomic) IBOutlet UILabel *brifLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchingCountLabel;

@end
#define Color(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#define YLQRandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@implementation MidCollectionCell

- (void)setItem:(BangumiLatestUpdateListItem *)item
{
    _item = item;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.cover]];
    self.imageView.backgroundColor = YLQRandomColor;
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = YES;
   
    self.watchingCountLabel.text = [NSString stringWithFormat:@"%@人在看", item.watchingCount];
    self.brifLabel.text = item.title;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
