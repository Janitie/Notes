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
    BOOL _statusDone;
}

@end

@implementation CheckCellView

- (instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:@"CheckCellView" owner:self options:nil] firstObject];
    if (self) {
        self.checkContentView.delegate = self;
        _statusDone = NO;
    }
    return self;
}
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
    self.checkContentView.text = @"";
}


- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"2 = %@",textView.text);
    self.checkContentView.frame = CGRectMake(40, 10, 305, self.checkContentView.contentSize.height);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"4 = %@",textView.text);
    if (_delegate && [_delegate respondsToSelector:@selector(adjustCellHeight)]) {
        
        [_delegate adjustCellHeight];
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
