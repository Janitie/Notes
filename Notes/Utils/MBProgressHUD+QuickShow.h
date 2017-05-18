//
//  MBProgressHUD+QuickShow.h
//  Notes
//
//  Created by Horace Yuan on 2017/5/19.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (QuickShow)

/**
 快速显示全局提示(显示两秒钟)
 @param  text    NSString    提示内容
 */
+ (void)showQuickTipWithText:(NSString *)text;

/**
 快速显示全局提示(显示两秒钟)
 @param  title   NSString    提示题目
 @param  text    NSString    提示内容
 */
+ (void)showQuickTipWithTitle:(NSString *)title withText:(NSString *)text;

/**
 显示全局等待提示
 */
+ (void)showWaitingHUDInKeyWindow;

/**
 隐藏所有全局等待提示
 */
+ (void)hideAllWaitingHUDInKeyWindow;

/**
 显示等待提示
 @param view    UIView  提示出现的位置
 */
+ (MBProgressHUD *)showWaitingHUDInView:(UIView *)view;

/**
 隐藏等待提示
 @param view    UIView  隐藏特定view上的提示
 */
+ (void)hideAllWaitingHudInView:(UIView *)view;


/**
 显示提示信息
 @param labelText   NSString*   提示内容
 @param time        CGFloat     显示时间
 @param view        UIView*     出现视图
 */
+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
              usingView:(UIView *)view;

/**
 显示提示信息
 @param labelText   NSString*   提示内容
 @param time        CGFloat     显示时间
 @param view        UIView*     出现视图
 @param yOffset     CGFloat     y轴偏移距离
 */

+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
              usingView:(UIView *)view
                yOffset:(CGFloat)yOffset;

/**
 显示提示信息
 @param labelText   NSString*   提示内容
 @param time        CGFloat     显示时间
 @param fontSize    CGFloat     提示内容字体大小
 */
+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
           withFontSize:(CGFloat)fontSize;

/**
 显示提示信息
 @param labelText   NSString*   提示内容
 @param time        CGFloat     显示时间
 */
+ (MBProgressHUD *)showTipsWithHUD:(NSString *)labelText
                          showTime:(CGFloat)time;


@end
