//
//  MBProgressHUD+QuickShow.m
//  Notes
//
//  Created by Horace Yuan on 2017/5/19.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "MBProgressHUD+QuickShow.h"

@implementation MBProgressHUD (QuickShow)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

+ (void)showQuickTipWithText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow]
                                              animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setLabelText:text];
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showQuickTipWithTitle:(NSString *)title withText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow]
                                              animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setLabelText:title];
    [hud setDetailsLabelText:text];
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showWaitingHUDInKeyWindow
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow
                         animated:YES];
}

+ (void)hideAllWaitingHUDInKeyWindow;
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow
                             animated:YES];
}

+ (MBProgressHUD *)showWaitingHUDInView:(UIView *)view;
{
    return ([MBProgressHUD showHUDAddedTo:view animated:YES]);
}

+ (void)hideAllWaitingHudInView:(UIView *)view;
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
              usingView:(UIView *)view
{
    [[self class] showTipsWithHUD:labelText showTime:time usingView:view yOffset:0.0f];
}

+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
              usingView:(UIView *)view
                yOffset:(CGFloat)yOffset
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    hud.yOffset = yOffset;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [view addSubview:hud];
    
    [hud hide:YES afterDelay:time];
    
}

+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
           withFontSize:(CGFloat)fontSize
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:fontSize];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hide:YES afterDelay:time];
}

+ (MBProgressHUD *)showTipsWithHUD:(NSString *)labelText
                          showTime:(CGFloat)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hide:YES afterDelay:time];
    return hud;
}

#pragma clang diagnostic pop

@end
