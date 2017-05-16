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

@property(nonatomic,strong) LabelView * tagView;

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
    
//    NSArray * labelArray = [[NSArray alloc] initWithObjects:@"today",@"tomorrow",@"yesterday",@"tonight", nil];
    
    
}

#pragma mark - button

- (IBAction)backButtonDo:(id)sender {
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
                                      }
                                  }];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
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

//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called





- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"respond");
    [self.textView becomeFirstResponder];
    return NO;
}// called when 'return' key pressed. return NO to ignore.


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    NSLog(@"shouldChangeTextInRange text = %@", textView.text);
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    NSLog(@"textViewShouldBeginEditing text = %@", textView.text);
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
//    NSLog(@"DidtextViewDidChangeChange text = %@", textView.text);
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
