//
//  LabelView.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/15.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LabelView;

@protocol LabelViewDelegate <NSObject>
- (void)labelView:(LabelView *)labelView didSelectedTag:(NSString *)tagTitle;
- (void)labelView:(LabelView *)labelView didDeselectedTag:(NSString *)tagTitle;
/// 返回 YES：编辑标签将清空文字  NO：不做任何操作
- (BOOL)labelView:(LabelView *)labelView didEnterNewTag:(NSString *)newTagTitle;
@end

@interface LabelView : UIView

@property (nonatomic, assign) BOOL canAddNewTag;    // default is NO
/// 全部可选的标签
@property (nonatomic, strong) NSArray * allTags;
/// 全部已选的标签
@property (nonatomic, strong) NSArray * seletedTags;

@property (nonatomic, assign ,readonly) CGFloat supposeHeight;

@property (nonatomic, weak) id<LabelViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame Addable:(BOOL)canAddNew;

@end
