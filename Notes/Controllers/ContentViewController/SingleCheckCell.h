//
//  SingleCheckCell.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/18.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleCheckCell;

@protocol singleCheckDelegate <NSObject>

//- (void)changeCellHeightForString:(NSString *)string fromCell:(SingleCheckCell *)cell;
- (void)stringDidChange:(NSString *)string fromIndex:(NSInteger)index;
- (void)stringDidConfirm:(NSString *)string fromIndex:(NSInteger)index;
- (void)deleteCellFromIndex:(NSInteger)index;
- (void)statusDidChangeTo:(BOOL)status fromIndex:(NSInteger)index;

@end

@interface SingleCheckCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *tickButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (assign, nonatomic) NSInteger indexNumber;
@property (assign, nonatomic) BOOL statusDone;


@property (weak, nonatomic) id<singleCheckDelegate> delegate;

+ (NSString *)cellIdentifier;

+ (UINib *)cellNib;
@end
