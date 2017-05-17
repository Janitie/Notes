//
//  TagView.m
//  Notes
//
//  Created by Horace Yuan on 2017/5/16.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "TagView.h"

#define DefaultFont [UIFont systemFontOfSize:15.0f]
#define EditBorderColor [UIColor lightGrayColor]
#define EditBackgroundColor [UIColor clearColor]
#define DefaultNormalColor [UIColor whiteColor]
#define DefaultHighlightedColor [UIColor colorWithRed:117.0f/255.0f \
green:67.0f/255.0f \
blue: 185.0f/255.0f \
alpha:1.0f]

@interface TagView ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isEditable;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextField * titleTextField;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation TagView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isEditable = YES;
        self.tagTitle = nil;
        [self setupView];
    }
    return self;
}

- (instancetype)initWithEditable:(BOOL)editable
                           title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.isEditable = editable;
        self.tagTitle = title;
        [self setupView];
    }
    return self;
}

- (void)dealloc {
    [self.titleTextField removeObserver:self forKeyPath:@"text"];
}

#pragma mark - UI
- (void)setupView {
    // 添加内容
    if (self.isEditable) {
        [self addSubview:self.titleTextField];
        // 设置View
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0f;
        self.layer.borderColor = EditBorderColor.CGColor;
        self.layer.borderWidth = 1.0f;
        self.backgroundColor = EditBackgroundColor;
        
    } else {
        [self addSubview:self.titleLabel];
        [self addGesture];
        // 设置View
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0f;
        self.layer.borderColor = DefaultHighlightedColor.CGColor;
        self.layer.borderWidth = 1.0f;
        self.backgroundColor = DefaultNormalColor;
    }
    [self resizeTagView];
}

- (void)addGesture {
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDo:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)updateSelectionStyle {
    self.titleLabel.text = self.tagTitle;
    if (self.isSelected) {
        self.titleLabel.textColor = DefaultNormalColor;
        self.backgroundColor = DefaultHighlightedColor;
    } else {
        self.titleLabel.textColor = DefaultHighlightedColor;
        self.backgroundColor = DefaultNormalColor;
    }
    [self resizeTagView];
}

- (void)resizeTagView {
    UIView * titleView;
    if (self.isEditable) {
        [self.titleLabel sizeToFit];
        titleView = self.titleLabel;
    } else {
        BOOL isEmpty = [self.titleTextField.text isEqualToString:@""];
        if (isEmpty) {
            self.titleTextField.text = @"添加标签";
            [self.titleTextField sizeToFit];
            self.titleTextField.text = @"";
        } else {
            [self.titleTextField sizeToFit];
        }
        titleView = self.titleTextField;
    }
    
    CGRect viewFrame = self.frame;
    viewFrame.size.height = titleView.frame.size.height + self.edgeInsets.top + self.edgeInsets.bottom;
    viewFrame.size.width = titleView.frame.size.width + self.edgeInsets.left + self.edgeInsets.right;
    self.frame = viewFrame;
    self.layer.cornerRadius = CGRectGetHeight(viewFrame)/2;
    
    [titleView setCenter:CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2)];
}

#pragma mark - gesture do
- (void)tapGestureDo:(UIGestureRecognizer *)recognizer {
    self.isSelected = !self.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidSelect:)]) {
        [self.delegate tagDidSelect:self];
    }
}

#pragma mark - Setter
- (void)setTagTitle:(NSString *)tagTitle {
    _tagTitle = tagTitle;
    if (!self.isEditable) {
        [self updateSelectionStyle];
    }
    [self resizeTagView];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (!self.isEditable) {
        [self updateSelectionStyle];
    }
    [self resizeTagView];
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = DefaultFont;
        _titleLabel.textColor = DefaultHighlightedColor;
    }
    return _titleLabel;
}

- (UITextField *)titleTextField {
    if (_titleTextField == nil) {
        _titleTextField = [UITextField new];
        _titleTextField.font = DefaultFont;
        _titleTextField.textColor = DefaultHighlightedColor;
        _titleTextField.placeholder = @"添加标签";
        _titleTextField.delegate = self;
        [_titleTextField addObserver:self
                          forKeyPath:@"text"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    }
    return _titleTextField;
}

- (UIEdgeInsets)edgeInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, UIEdgeInsetsZero)) {
        _edgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
    }
    return _edgeInsets;
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidPushReturnKey:)]) {
        BOOL isSuccess = [self.delegate tagDidPushReturnKey:textField.text];
        if (isSuccess) {
            textField.text = @"";
            [textField resignFirstResponder];
        }
    }
    return NO;
}

#pragma mark - Notification 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.titleTextField) {
        NSLog(@"tag textField changed");
        [self resizeTagView];
    }
}

@end
