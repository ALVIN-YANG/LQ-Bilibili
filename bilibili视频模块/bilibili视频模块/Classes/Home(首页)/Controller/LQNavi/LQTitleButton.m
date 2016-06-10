//
//  LQTitleButton.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/7.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "LQTitleButton.h"
#import "LQMacro.h"

@implementation LQTitleButton


- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:LQNavTintColor forState:UIControlStateNormal];
        [self setTitleColor:LQMainColor forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
}

//取消高亮
- (void)setHighlighted:(BOOL)highlighted{}


@end
