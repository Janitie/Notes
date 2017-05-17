//
//  CheckCellView.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckCellView;

@protocol checkCellTextViewDelegate <NSObject>

- (void)adjustCellHeight:(CheckCellView *)cell;
- (void)didPushEnterAddHeight:(CGFloat)height;
- (void)deleteCell:(CheckCellView *)cell Height:(CGFloat)height;


@end

@interface CheckCellView : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *checkContentView;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, weak) id<checkCellTextViewDelegate> delegate;


@end
