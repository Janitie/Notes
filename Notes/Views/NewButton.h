//
//  NewButton.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/1.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewButtonDelegate <NSObject>

- (void)leftButtonDidPush;
- (void)rightButtonDidPush;

@end

typedef enum : NSUInteger {
    leftState,
    rightState,
} buttonState;

@interface NewButton : UIView

@property (nonatomic, weak) id<NewButtonDelegate> delegate;

@property (nonatomic, strong) UIImageView * nomalView;
@property (nonatomic, strong) UIImageView * biggerView;
@property (nonatomic, strong) UILongPressGestureRecognizer * longPressGes;



@end
