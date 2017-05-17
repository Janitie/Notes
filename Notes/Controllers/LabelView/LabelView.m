//
//  LabelView.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/15.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "LabelView.h"
#import "TagView.h"

#define SpaceX  5.0f
#define SpaceY  5.0f
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LabelView ()<TagViewDelegate>

// 用于存储TagView
@property (nonatomic, strong) NSMutableArray * labelTags;
@property (nonatomic, assign) BOOL canAddNewTag;    // default is NO

@end

@implementation LabelView

- (instancetype)initWithFrame:(CGRect)frame Addable:(BOOL)canAddNew {
    self = [super initWithFrame:frame];
    if (self) {
        self.canAddNewTag = canAddNew;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.canAddNewTag = NO;
    }
    return self;
}

#pragma mark - UI
- (void)updateTagsStyle {
    [self clearAllTagsInView];
    CGFloat widthRemain = ScreenWidth - SpaceX;
    CGFloat rowHeight = 30.0f;
    NSInteger line = 0;
    
    for (NSString * tagStr in self.allTags) {
        TagView * tagView = [[TagView alloc] initWithEditable:NO
                                                        title:tagStr];
        tagView.delegate = self;
        CGRect tagFrame = tagView.frame;
        CGFloat tagWidth = CGRectGetWidth(tagFrame);
        CGFloat tagHeight = CGRectGetHeight(tagFrame);
        rowHeight = tagHeight + SpaceY;
        
        // 计算tag的位置，判断是否需要换行
        if (widthRemain < (tagWidth + SpaceX)) {
            widthRemain = ScreenWidth - SpaceX;
            line++;
        }
        tagFrame.origin.x = ScreenWidth - widthRemain;
        tagFrame.origin.y = (rowHeight) * line;
        widthRemain -= (tagWidth + SpaceX);
        // 设置位置
        tagView.frame = tagFrame;
        // 设置是否被选中
        tagView.isSelected = [self isSelectedTag:tagStr];
        
        [self addSubview:tagView];
    }
    
    // 如果可以添加新标签，则添加一个可编辑的tagView
    if (self.canAddNewTag) {
        TagView * tagView = [[TagView alloc] init];
        tagView.delegate = self;
        CGRect tagFrame = tagView.frame;
        CGFloat tagWidth = CGRectGetWidth(tagFrame);
        CGFloat tagHeight = CGRectGetHeight(tagFrame);
        rowHeight = tagHeight + SpaceY;
        
        // 计算tag的位置，判断是否需要换行
        if (widthRemain < (tagWidth + SpaceX)) {
            widthRemain = ScreenWidth - SpaceX;
            line++;
        }
        tagFrame.origin.x = ScreenWidth - widthRemain;
        tagFrame.origin.y = (rowHeight) * line;
        widthRemain -= (tagWidth + SpaceX);
        // 设置位置
        tagView.frame = tagFrame;
        [self addSubview:tagView];
    }
    
    CGRect viewFrame = self.frame;
    viewFrame.size.height = line * rowHeight;
    self.frame = viewFrame;
}

- (void)clearAllTagsInView {
    for (TagView * tag in self.labelTags) {
        [tag removeFromSuperview];
    }
    [self.labelTags removeAllObjects];
}

- (BOOL)isSelectedTag:(NSString *)tagTitle {
    BOOL isSelected = NO;
    for (NSString *selectedTagStr in self.seletedTags) {
        if ([selectedTagStr isEqualToString:tagTitle]) {
            isSelected = YES;
            break;
        }
    }
    return isSelected;
}

#pragma mark - Getter
- (NSMutableArray *)labelTags {
    if (_labelTags == nil) {
        _labelTags = [NSMutableArray array];
    }
    return _labelTags;
}


#pragma mark - Setter   
- (void)setAllTags:(NSArray *)allTags {
    _allTags = allTags;
    [self updateTagsStyle];
}

- (void)setSeletedTags:(NSArray *)seletedTags {
    _seletedTags = seletedTags;
    [self updateTagsStyle];
}



@end
