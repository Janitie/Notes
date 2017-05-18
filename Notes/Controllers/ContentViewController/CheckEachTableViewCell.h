//
//  CheckEachTableViewCell.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/18.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckEachTableViewCell;

@protocol checkCellTextViewDelegate <NSObject>

- (void)adjustCellHeight:(CheckEachTableViewCell *)cell;
- (void)didPushEnterAddHeight:(CGFloat)height;
- (void)deleteCell:(CheckEachTableViewCell *)cell Height:(CGFloat)height;

- (void)moveKeyboardFromRect:(CGRect)rect;
- (void)keyboardBack;

@end


@interface CheckEachTableViewCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *status;


@property (assign, nonatomic) BOOL statusDone;

@property (nonatomic, weak) id<checkCellTextViewDelegate> delegate;

+ (NSString *)cellIdentifier;

+ (UINib *)cellNib;

@end
