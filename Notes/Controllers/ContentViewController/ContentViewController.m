//
//  ContentViewController.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/2.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "ContentViewController.h"
#import "NoteService.h"
#import "LabelView.h"
#import "NoteService.h"

@interface ContentViewController () <LabelViewDelegate>
{
    NoteObject * _note;
    BOOL _isUpdating;
    BOOL _isInputtingTag;
}

@property (nonatomic, strong) NSArray * userTags;       // 用户的常用标签
@property (nonatomic, strong) NSArray * noteTags;       // 用户

@property (nonatomic, strong) IBOutlet LabelView * tagView;
// tag input View
@property (nonatomic, strong) IBOutlet LabelView * tagInputViewContent;
@property (nonatomic, strong) IBOutlet UIView * tagInputView;
@property (strong, nonatomic) IBOutlet UIView *tagInputToolView;
@property (nonatomic, readonly) CGRect tagInputOriginFrame;
@property (nonatomic, readonly) CGRect tagInputFinnalFrame;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeight;

/// 新建的tag
@property (nonatomic, strong) NSMutableArray<NSString *> * freshTagsTitles;

@end

@implementation ContentViewController
@synthesize userTagObjects = _userTagObjects;

- (instancetype)initWithBOOL:(BOOL)isNote {
    if ([super init]) {
        self.isNote = isNote;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleField.delegate = self;
    self.textView.delegate = self;
    
    
    self.titleField.text = _note.title;
    self.textView.text = _note.content;
    
    [self.tagView setCanAddNewTag:YES];
    [self.tagView setDelegate:self];
    [self.tagInputViewContent setCanAddNewTag:NO];
    [self.tagInputViewContent setDelegate:self];
    
    _isInputtingTag = NO;
    
    if (_isUpdating) {
        [self getNoteTagsData];
    } else {
        [self updateTagView];
    }
    
    [self addKeyBoardNotificationObserver];
}

- (void)setDataNoteObject:(NoteObject *)note {
    _note = note;
    _isUpdating = YES;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentViewHeight.constant = CGRectGetHeight(self.tagInputViewContent.frame);
}

- (void)dealloc {
    [self removeKeyBoardNotificationObserver];
}

- (void) addKeyBoardNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyBoardNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI Logic
- (void)showTagInputView {
    if (!_isInputtingTag) {
        _isInputtingTag = YES;
        self.tagInputView.frame = self.tagInputOriginFrame;
        [self.view addSubview:self.tagInputView];
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.25f
                         animations:^
         {
             self.tagInputView.frame = self.tagInputFinnalFrame;
         }];
    }
}

- (void)hideTagInputView {
    if (_isInputtingTag) {
        _isInputtingTag = NO;
        self.tagInputView.frame = self.tagInputFinnalFrame;
        [UIView animateWithDuration:0.25f
                         animations:^
         {
             self.tagInputView.frame = self.tagInputOriginFrame;
         }
                         completion:^(BOOL finished)
         {
             if (finished) {
                 [self.tagInputView removeFromSuperview];
             }
         }];
    }
}

#pragma mark - Tag Logic 
- (void)updateTagView {
    self.tagView.allTags = self.noteTags;
    self.tagView.seletedTags = self.noteTags;
    self.tagInputViewContent.allTags = self.userTags;
    self.tagInputViewContent.seletedTags = self.noteTags;
    
    self.contentViewHeight.constant = CGRectGetHeight(self.tagInputViewContent.frame);
    self.tagViewHeight.constant = self.tagView.supposeHeight;
}

- (NSArray *)addTagTitle:(NSString *)tagTitle toArray:(NSArray *)array {
    NSMutableArray *mArray = [array mutableCopy];
    for (NSString * title in mArray) {
        if ([title isEqualToString:tagTitle]) {
            return array;
        }
    }
    [mArray addObject:tagTitle];
    return mArray;
}

- (NSArray *)removeTagTitle:(NSString *)tagTitle fromArray:(NSArray *)array {
    NSMutableArray *mArray = [array mutableCopy];
    for (NSString * title in mArray) {
        if ([title isEqualToString:tagTitle]) {
            [mArray removeObject:title];
        }
    }
    return mArray;
}

#pragma mark - Tag Data handle 
- (void)getNoteTagsData {
    WS(weakSelf);
    [NoteService getTagsWithNoteId:_note.objectId
                          callback:^(NSArray<TagObject *> *result)
     {
         weakSelf.noteTagObjects = [result mutableCopy];
         NSMutableArray * tagTitles = [NSMutableArray array];
         for (TagObject * tagObj in result) {
             [tagTitles addObject:tagObj.tagName];
         }
         weakSelf.noteTags = tagTitles;
         [weakSelf updateTagView];
     }];
}

- (void)resetNoteTagsWithTagTitles:(NSArray *)tagTitles {
    for (NSString * tagTitle in tagTitles) {
        BOOL isExist = NO;
        for (TagObject * tagObj in self.noteTagObjects) {
            if (tagTitle == tagObj.tagName) {
                isExist = YES;
                break;
            }
        }
        if (!isExist) { // 不存在的给他添加一个
            WS(weakSelf);
            [self addTagWithTitle:tagTitle
                         callback:^(BOOL isSuccess, TagObject *obj)
            {
                if (isSuccess) {
                    NSMutableArray * mArr = [weakSelf.noteTagObjects mutableCopy];
                    [mArr addObject:obj];
                    weakSelf.noteTagObjects = mArr;
                }
            }];
        }
    }
}

- (void)addTagWithTagTitle:(NSString *)tagTitle
                  callback:(void (^)(TagObject * tag))callback {
    BOOL isExist = NO;
    TagObject * tagObject = nil;
    for (TagObject * tagObj in self.userTagObjects) {
        if ([tagObj.tagName isEqualToString:tagTitle]) {
            tagObject = tagObj;
            isExist = YES;
            break;
        }
    }
    if (isExist) {
        callback(tagObject);
    } else {
        [NoteService addNewTag:tagTitle
                      callback:^(BOOL isSuccess, TagObject *object)
        {
            callback (object);
        }];
    }
    
}

- (void)addTagWithTitle:(NSString *)tagTitle
               callback:(void(^)(BOOL isSuccess, TagObject * obj))callback
{
    [NoteService addNewTag:tagTitle
                  callback:^(BOOL isSuccess, TagObject *object)
    {
        if (!isSuccess) {
            [MBProgressHUD showQuickTipWithText:@"创建标签失败"];
        }
        callback (isSuccess, object);
    }];
}

- (void)deleteTagWithTitle:(NSString *)tagId {
    [NoteService deleteTag:tagId
                  callback:^(BOOL isSuccess)
    {
        if (!isSuccess) {
            [MBProgressHUD showQuickTipWithText:@"删除标签失败"];
        }
    }];
}

- (void)addNoteTagsWithTagId:(NSString *)tagId {
    [NoteService addNoteTagWithNoteId:_note.objectId
                                tagId:tagId
                             callback:^(BOOL isSuccess)
    {
        if (!isSuccess) {
            [MBProgressHUD showQuickTipWithText:@"添加标签失败"];
        }
    }];
}

#pragma mark - Setter 
- (void)setUserTagObjects:(NSMutableArray<TagObject *> *)userTagObjects {
    _userTagObjects = userTagObjects;
    NSMutableArray * tagTitles = [NSMutableArray array];
    for (TagObject * tagObj in userTagObjects) {
        [tagTitles addObject:tagObj.tagName];
    }
    self.userTags = tagTitles;
}

#pragma mark - Getter
- (LabelView *)tagView {
    if (_tagView == nil) {
        _tagView = [[LabelView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100) Addable:YES];
    }
    return _tagView;
}

- (CGRect)tagInputOriginFrame {
    return CGRectMake(0,
                      CGRectGetHeight([UIScreen mainScreen].bounds) - 35.0f,
                      CGRectGetWidth([UIScreen mainScreen].bounds),
                      300.0f);
}

- (CGRect)tagInputFinnalFrame {
    return CGRectMake(0,
                      CGRectGetHeight([UIScreen mainScreen].bounds) - 300.0f,
                      CGRectGetWidth([UIScreen mainScreen].bounds),
                      300.0f);
}

- (NSArray *)userTags {
    if (_userTags == nil) {
        _userTags = [NSArray array];
    }
    return _userTags;
}

- (NSArray *)noteTags {
    if (_noteTags == nil) {
        _noteTags = [NSArray array];
    }
    return _noteTags;
}

- (NSMutableArray<NSString *> *)freshTagsTitles {
    if (_freshTagsTitles == nil) {
        _freshTagsTitles = [NSMutableArray array];
    }
    return _freshTagsTitles;
}

- (NSMutableArray<TagObject *> *)noteTagObjects {
    if (_noteTagObjects == nil) {
        _noteTagObjects = [NSMutableArray array];
    }
    return _noteTagObjects;
}

- (NSMutableArray<TagObject *> *)userTagObjects {
    if (_userTagObjects == nil) {
        _userTagObjects = [NSMutableArray array];
    }
    return _userTagObjects;
}

#pragma mark - button

- (IBAction)backButtonDo:(id)sender {
    //NEW
    if (_isUpdating == NO) {
        //只要有一个不空就新建
        if (![self.titleField.text isEqualToString:@""] || ![self.textView.text isEqualToString:@""] ) {
            [self addNewNote];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else { //EXISTED
        //当全空时删除
        if ([self.titleField.text isEqualToString:@""] && [self.textView.text isEqualToString:@""]) {
            //delete
            [self deleteNote];
        } else { //只要有改动就上传刷新
            [self updateNote];
        }
    }
}

/// 新建Note
- (void)addNewNote {
    WS(weakSelf);
    [NoteService creatNewNoteWithTitle:self.titleField.text
                               content:self.textView.text
                                  type:self.isNote
                              callback:^(BOOL succeeded, NoteObject * object)
    {
        if (succeeded) {
            _note = object;
            [weakSelf updateAllTagsAndNoteTags:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [MBProgressHUD showQuickTipWithText:@"保存失败"];
                }
            }];
        }
        else {
            NSLog(@"error saving");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

/// delete
- (void)deleteNote {
    WS(weakSelf);
    [NoteService deleteWithObjectId:_note.avObject.objectId
                           callback:^(BOOL isSuccess)
    {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else {
            [MBProgressHUD showQuickTipWithText:@"保存失败"];
        }
    }];
}

/// update
- (void)updateNote {
    WS(weakSelf);
    [NoteService updateTitle:self.titleField.text
                     Content:self.textView.text
                WithObjectId:_note.avObject.objectId
                    callback:^(BOOL success)
    {
        if (success) {
            [weakSelf updateAllTagsAndNoteTags:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [MBProgressHUD showQuickTipWithText:@"保存失败"];
                }
            }];
        }
        else {
            [MBProgressHUD showQuickTipWithText:@"保存失败"];
        }
    }];
}

/// 更新笔记Tag的状态
- (void)updateAllTagsAndNoteTags:(void (^)(BOOL isSuccess))callback
{
    WS(weakSelf);
    [MBProgressHUD showWaitingHUDInKeyWindow];
    [self updateUserTags:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf updateNoteTags:^(BOOL isSuccess) {
                [MBProgressHUD hideAllWaitingHUDInKeyWindow];
                callback(isSuccess);
            }];
        } else {
            [MBProgressHUD hideAllWaitingHUDInKeyWindow];
            callback (NO);
        }
    }];
}

/// 更新用户标签
- (void)updateUserTags:(void (^)(BOOL isSuccess))callback {
    WS(weakSelf);
    [NoteService addTagsWithTitles:self.freshTagsTitles
                          callback:^(BOOL isSuccess, NSArray<TagObject *> * objects)
    {
        if (isSuccess) {
            [weakSelf.userTagObjects addObjectsFromArray:objects];
            callback (YES);
        } else {
            callback (NO);
        }
    }];
}

/// 更新笔记标签
- (void)updateNoteTags:(void (^)(BOOL isSuccess))callback {
    NSMutableArray * freshNoteTags = [NSMutableArray array];
    for (NSString * tagTitle in self.noteTags) {
        for (TagObject * tagObj in self.userTagObjects) {
            if ([tagObj.tagName isEqualToString:tagTitle]) {
                [freshNoteTags addObject:tagObj];
                break;
            }
        }
    }
    [NoteService updateNoteTags:freshNoteTags
                         noteId:_note.objectId
                       callback:callback];
}

- (IBAction)labelButtonDo:(id)sender {
    if (_isInputtingTag) {
        [self hideTagInputView];
    } else {
        [self showTagInputView];
    }
}

- (IBAction)keyboardDown:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - KeyBoard Notification
- (void)keyBoardWillShow:(NSNotification *)notification {
    CGFloat height = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self.view bringSubviewToFront:self.bottomView];
    [self hideTagInputView];
    [UIView animateWithDuration:duration
                     animations:^
    {
        self.bottomViewBottomSpace.constant = height;
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyBoardWillHide:(NSNotification *)notification {
    CGFloat duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration
                     animations:^
    {
        self.bottomViewBottomSpace.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - textFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"respond");
    [self.textView becomeFirstResponder];
    return NO;
}// called when 'return' key pressed. return NO to ignore.


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //second return
//    NSLog(@"shouldChangeTextInRange text = %@", textView.text);
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    //first return
//    NSLog(@"DidtextViewDidChangeChange text = %@", textView.text);
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    NSLog(@"textViewShouldBeginEditing text = %@", textView.text);
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
//    NSLog(@"textViewDidBeginEditing text = %@", textView.text);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LabelView Delegate
- (void)labelView:(LabelView *)labelView didSelectedTag:(NSString *)tagTitle {
    if (labelView == self.tagInputViewContent) {
        self.noteTags = self.tagInputViewContent.seletedTags;
    }
    [self updateTagView];
}

- (void)labelView:(LabelView *)labelView didDeselectedTag:(NSString *)tagTitle {
    if (labelView == self.tagInputViewContent) {
        self.noteTags = self.tagInputViewContent.seletedTags;
    } else {
        self.noteTags = self.tagView.seletedTags;
    }
    [self updateTagView];
}

- (BOOL)labelView:(LabelView *)labelView didEnterNewTag:(NSString *)newTagTitle {
    NSLog(@"newTag = %@", newTagTitle);
    NSInteger userTagsCount = self.userTags.count;
    self.userTags = [self addTagTitle:newTagTitle toArray:self.userTags];
    self.noteTags = [self addTagTitle:newTagTitle toArray:self.noteTags];
    if (userTagsCount != self.userTags.count) {
        [self.freshTagsTitles addObject:newTagTitle];
    }
    [self updateTagView];
    return YES;
}

@end
