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

@interface ContentViewController ()
{
    NoteObject * _note;

    BOOL _isUpdating;
}
@property (nonatomic, strong) IBOutlet LabelView * tagView;
@property (nonatomic, strong) LabelView * tagInputView;

@end

@implementation ContentViewController

- (instancetype)initWithBOOL:(BOOL)isNote {
    if ([super init]) {
        self.isNote = isNote;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleField.inputAccessoryView = self.inputBottomView;
    self.textView.inputAccessoryView = self.inputBottomView;
    
    self.titleField.delegate = self;
    self.textView.delegate = self;
    
    
    self.titleField.text = _note.title;
    self.textView.text = _note.content;

}

- (void)setDataNoteObject:(NoteObject *)note {
    _note = note;
    _isUpdating = YES;
}

#pragma mark - Getter 
- (LabelView *)tagView {
    if (_tagView == nil) {
        _tagView = [[LabelView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100) Addable:YES];
    }
    return _tagView;
}

#pragma mark - button

- (IBAction)backButtonDo:(id)sender {
    //NEW
    if (_isUpdating == NO) {
        //只要有一个不空就新建
        if (![self.titleField.text isEqualToString:@""] || ![self.textView.text isEqualToString:@""] ) {
            [NoteService creatNewNoteWithTitle:self.titleField.text
                                       content:self.textView.text
                                          type:self.isNote
                                      callback:^(BOOL succeeded) {
                                          if (succeeded) {
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                          else {
                                              NSLog(@"error saving");
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                      }];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //EXISTED
    else {
        //当全空时删除
        if ([self.titleField.text isEqualToString:@""] && [self.textView.text isEqualToString:@""]) {
            //delete
            [NoteService deleteWithObjectId:_note.avObject.objectId
                                   callback:^(BOOL isSuccess) {
                                       if (isSuccess) {
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }
                                       else {
                                           NSLog(@"error deleting");
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }
                                   }];
        }
        //只要有改动就上传刷新
        else {
            [NoteService updateTitle:self.titleField.text
                             Content:self.textView.text
                        WithObjectId:_note.avObject.objectId
                            callback:^(BOOL success) {
                                if (success) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                                else {
                                    NSLog(@"error");
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }];
        }
        _isUpdating = NO;
    }

}

- (IBAction)labelButtonDo:(id)sender {
    
    NSLog(@"new label?");
}

- (IBAction)keyboardDown:(id)sender {
    NSLog(@"hello kayboard");
    [self.titleField resignFirstResponder];
    [self.textView resignFirstResponder];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
