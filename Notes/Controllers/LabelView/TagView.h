//
//  TagView.h
//  Notes
//
//  Created by Horace Yuan on 2017/5/16.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagView;

@protocol TagViewDelegate <NSObject>

@optional
- (void)tagDidSelect:(TagView *)tag;
- (BOOL)tagDidPushReturnKey:(NSString *)tag;
@end

@interface TagView : UIView

@property (nonatomic, assign, readonly) BOOL isEditable;    // 是否能被编辑
@property (nonatomic, strong) NSString * tagTitle;          // 标签名
@property (nonatomic, assign) BOOL isSelected;              // 是否被选中

@property (nonatomic, weak) id<TagViewDelegate> delegate;

/// isEditable:YES
- (instancetype)init;
- (instancetype)initWithEditable:(BOOL)editAble title:(NSString *)tagTitle;

@end
