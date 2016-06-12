//
//  LQVerticalButton.h
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/12.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQVerticalButton : UIButton

/**
 *  什么也没干
 */
+ (instancetype)allocVerticalButton;

/**
 *  初始化垂直Button
 */
- (void)setFrame:(CGRect)frame imageFrame:(CGRect)imageFrame textFrame:(CGRect)textFrame image:(UIImage *)image text:(NSString *)text;
@end
