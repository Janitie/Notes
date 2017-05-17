//
//  LabelView.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/15.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelView : UIView

@property (nonatomic, assign, readonly) BOOL canAddNewTag;    // default is NO

/// 全部可选的标签
@property (nonatomic, strong) NSArray * allTags;
/// 全部已选的标签
@property (nonatomic, strong) NSArray * seletedTags;


- (instancetype)initWithFrame:(CGRect)frame Addable:(BOOL)canAddNew;


@end
