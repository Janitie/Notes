//
//  SingleCheckCell.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/18.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "SingleCheckCell.h"

@implementation SingleCheckCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - button Do
- (IBAction)tickButtonDo:(id)sender {
    NSLog(@"tick");
    self.statusDone = !self.statusDone;
    if (self.delegate && [self.delegate respondsToSelector:@selector(statusDidChangeTo:fromIndex:)]) {
        [self.delegate statusDidChangeTo:self.statusDone fromIndex:self.indexNumber];
    }
}

- (IBAction)deleteButtonDo:(id)sender {
    if (![self.textView.text isEqualToString:@""]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteCellFromIndex:)]) {
            [self.delegate deleteCellFromIndex:self.indexNumber];
        }
    }
}

#pragma mark - setter 
- (void)setStatusDone:(BOOL)statusDone {
    _statusDone = statusDone;
    self.tickButton.selected = _statusDone;
}

#pragma mark - textView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    CGFloat x = self.textView.frame.origin.x;
    CGFloat y = self.textView.frame.origin.y;
    CGFloat w = self.textView.frame.size.width;
    self.textView.frame = CGRectMake(x, y, w, self.textView.contentSize.height);
    
//    NSLog(@"1 = %@",textView.text);

    if ([text isEqualToString:@"\n"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(stringDidConfirm:fromIndex:)]) {
            [self.delegate stringDidConfirm:textView.text fromIndex:self.indexNumber];
        }
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(stringDidChange:fromIndex:)]) {
        [self.delegate stringDidChange:textView.text fromIndex:self.indexNumber];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    NSLog(@"2 = %@",textView.text);
}


//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    CGRect rect = self.frame;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(moveKeyboardFromRect:)]) {
//        [self.delegate moveKeyboardFromRect:rect];
//    }
//    return YES;
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardBack)]) {
//        [self.delegate keyboardBack];
//    }
//}
//
//
//- (void)textViewDidChange:(UITextView *)textView {
//    //    NSLog(@"2 = %@",textView.text);
//    self.checkContentView.frame = CGRectMake(40, 10, 305, self.checkContentView.contentSize.height);
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if ([text isEqualToString:@"\n"]) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(didPushEnterAddHeight:)]) {
//            NSLog(@"adding height = %f",self.frame.size.height);
//            [self.delegate didPushEnterAddHeight:self.frame.size.height];
//        }
//        return NO;
//    }
//    
//    //    NSLog(@"4 = %@",textView.text);
//    if (self.delegate && [self.delegate respondsToSelector:@selector(adjustCellHeight:)]) {
//        [self.delegate adjustCellHeight:self];
//    }
//    return YES;
//}


+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:nil];
}

@end
