//
//  LQVerticalButton.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/12.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "LQVerticalButton.h"

@interface LQVerticalButton()
@property (nonatomic, assign)CGRect imageFrame;
@property (nonatomic, assign)CGRect textFrame;
@end
@implementation LQVerticalButton

+ (instancetype)allocVerticalButton
{
    return [[self alloc] init];
}


- (void)setFrame:(CGRect)frame imageFrame:(CGRect)imageFrame textFrame:(CGRect)textFrame image:(UIImage *)image text:(NSString *)text
{
    // 高亮的时候不要自动调整图标
    self.adjustsImageWhenHighlighted = NO;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    //self.titleLabel.textColor = [UIColor whiteColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 背景
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.imageFrame = imageFrame;
    self.textFrame = textFrame;
    [self setImage:image forState:UIControlStateNormal];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    NSLog(@"text:%@", text);
    [self setFrame:frame];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return self.imageFrame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return self.textFrame;
}
@end
