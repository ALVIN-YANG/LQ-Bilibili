//
//  LaunchScreen.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/4.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "LaunchScreen.h"
#import <UIKit/UIKit.h>

@interface LaunchScreen()

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIImageView *iconImageView;

@end

@implementation LaunchScreen

- (void)launchAnimation{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgImageView.backgroundColor = [UIColor orangeColor];
    self.bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"bilibili_splash_iphone_bg"];
    
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 7.5, [UIScreen mainScreen].bounds.size.height/2 - 100, 30, 40)];
    [self.iconImageView setImage:[UIImage imageNamed:@"bilibili_splash_default"]];

    [window addSubview:self.bgImageView];
    [window addSubview:self.iconImageView];
    
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.iconImageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 10.0f, 10.0f, 1.0f);
    } completion:^(BOOL finished) {
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissAll];
    });
}

- (void)dismissAll{
    
    
    
    [UIView animateWithDuration:1.5f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{

                     }
                     completion:^(BOOL finished) {
                         [self.bgImageView removeFromSuperview];
                         [self.iconImageView removeFromSuperview];
                     }];
}


@end
