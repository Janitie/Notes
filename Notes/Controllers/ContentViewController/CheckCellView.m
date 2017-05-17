//
//  CheckCellView.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckCellView.h"

@interface CheckCellView ()
{
}

@end

@implementation CheckCellView

- (instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:@"CheckCellView" owner:self options:nil] firstObject];
    if (self) {
        self.checkContentView.delegate = self;
        self.statusDone = NO;
    }
    return self;
}

#pragma mark - bouttonDo

- (IBAction)statusButtonDo:(id)sender {
    _statusDone = !_statusDone;
    if (_statusDone == YES) {
        _statusButton.selected = YES;
    }
    else {
        _statusButton.selected = NO;
    }
}

- (IBAction)deleteButtonDo:(id)sender {
//    self.checkContentView.text = @"";
//    self.checkContentView.frame = CGRectMake(40, 10, 305, self.checkContentView.contentSize.height);
    
    NSLog(@" oldheight = %f, contentHeight = %f",self.frame.size.height,self.checkContentView.frame.size.height);

    if (_delegate && [_delegate respondsToSelector:@selector(adjustCellHeight:)] && [_delegate respondsToSelector:@selector(deleteCell:Height:)]) {
//        [_delegate adjustCellHeight:self];
        [_delegate deleteCell:self Height:self.frame.size.height];
    }
}

#pragma mark - delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    CGRect rect = self.frame;
    if (_delegate && [_delegate respondsToSelector:@selector(moveKeyboardFromRect:)]) {
        [_delegate moveKeyboardFromRect:rect];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (_delegate && [_delegate respondsToSelector:@selector(keyboardBack)]) {
        [_delegate keyboardBack];
    }
}


- (void)textViewDidChange:(UITextView *)textView {
//    NSLog(@"2 = %@",textView.text);
    self.checkContentView.frame = CGRectMake(40, 10, 305, self.checkContentView.contentSize.height);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(didPushEnterAddHeight:)]) {
            NSLog(@"adding height = %f",self.frame.size.height);
            [_delegate didPushEnterAddHeight:self.frame.size.height];
        }
        return NO;
    }
    
//    NSLog(@"4 = %@",textView.text);
    if (_delegate && [_delegate respondsToSelector:@selector(adjustCellHeight:)]) {
        [_delegate adjustCellHeight:self];
    }
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
