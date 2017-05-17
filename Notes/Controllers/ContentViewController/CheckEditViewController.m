//
//  CheckEditViewController.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckEditViewController.h"
#import "NoteService.h"
#import "CheckCellView.h"

@interface CheckEditViewController ()<checkCellTextViewDelegate>
{
    NoteObject * _note;
    BOOL _isUpdating;
    float addFloat;
}

@property (nonatomic, strong) CheckCellView * firstCell;
@property (strong, nonatomic) IBOutlet UIScrollView *tableCellView;
@property (nonatomic, strong) NSMutableArray<CheckCellView *> * cellArray;


@end

@implementation CheckEditViewController



- (instancetype)initWithBOOL:(BOOL)isNote {
    if ([super init]) {
        self.isNote = isNote;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.titleField.inputAccessoryView = self.inputBottomView;
    self.firstCell.checkContentView.inputAccessoryView = self.inputBottomView;
    
    self.firstCell.delegate = self;
    [self.tableCellView addSubview:self.firstCell];
    
    addFloat = 0;
    
    //setView
    
}

- (void)setDataNoteObject:(NoteObject *)note {
    _note = note;
    _isUpdating = YES;
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    ///keyboardWasShown = YES;
}



#pragma mark - buttonDo

- (IBAction)backButtonDo:(id)sender {

    
    NSString * content = @"";
//    content = [content stringByAppendingString:@"apend"];
    
    for (CheckCellView * cell in self.cellArray) {
        NSString * eachString = @"";
        if (cell.statusDone == NO) {
            eachString = [eachString stringByAppendingString:@"%cObject%[ ]"];
        }
        else {
            eachString = [eachString stringByAppendingString:@"%cObject%[x]"];
        }
        eachString = [eachString stringByAppendingString:cell.checkContentView.text];
        NSLog(@"eachString = %@",eachString);
        content = [content stringByAppendingString:eachString];
        NSLog(@"content = %@",content);

    }
    
    if (_isUpdating == NO) {
        //只要有一个不空就新建,false if
        if (![self.titleField.text isEqualToString:@""] || ![content isEqualToString:@""]) {
            if (![self.firstCell.checkContentView.text isEqualToString:@""]) {
                [NoteService creatNewNoteWithTitle:self.titleField.text
                                           content:content
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
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


- (IBAction)keyboardDownBtnDo:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)labelButtonDo:(id)sender {
    NSLog(@"label");
}


#pragma mark - getter
- (CheckCellView *)firstCell {
    if (_firstCell == nil) {
        _firstCell = [[CheckCellView alloc] init];
        _firstCell.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 57);
    }
    return _firstCell;
}

- (UIScrollView *)tableCellView {
    if (_tableCellView == nil) {
        self.tableCellView = [[UIScrollView alloc] init];
    }
    return _tableCellView;
}

- (NSMutableArray<CheckCellView *> *)cellArray {
    if (_cellArray == nil) {
        self.cellArray = [[NSMutableArray alloc] init];
        [self.cellArray addObject:self.firstCell];
    }
    return _cellArray;
}

#pragma mark - delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"respond");
    [self.titleField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore.

- (void)moveKeyboardFromRect:(CGRect)rect {
    //below
    if (rect.origin.y + rect.size.height > 274) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        float offset = rect.size.height + 90 + (rect.origin.y - 374);//键盘高度293
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}


- (void)keyboardBack {
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)deleteCell:(CheckCellView *)cell Height:(CGFloat)height{
    NSInteger index = [self.cellArray indexOfObject:cell];
    if (index != 0) {
        for (; index < [self.cellArray count] - 1; index++) {
            CGRect fomalRect = self.cellArray[index + 1].frame;
            NSLog(@" HEIGHT = %f",cell.frame.size.height);
            NSLog(@" newHeight = %f",height);
            fomalRect.origin.y -= height;
            self.cellArray[index + 1].frame = fomalRect;
        }
        [self.cellArray removeObject:cell];
        [cell removeFromSuperview];
        addFloat -= height;
    }
    else {
        cell.checkContentView.text = @"";
        for (; index < [self.cellArray count] - 1; index++) {
            CGRect fomalRect = self.cellArray[index + 1].frame;
            fomalRect.origin.y -= height - 57;
            self.cellArray[index + 1].frame = fomalRect;
        }
        addFloat -= height - 57;

    }
}

- (void)adjustCellHeight:(CheckCellView *)cell {
//    NSLog(@"changing frame");
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.checkContentView.frame.size.height + 20);
}

- (void)didPushEnterAddHeight:(CGFloat)height {
    NSLog(@"ADD A CELL");
    NSLog(@" 1 flaot = %f",addFloat);
    addFloat += height;
    NSLog(@" 2 flaot = %f",addFloat);
    
    CheckCellView * newCell = [[CheckCellView alloc] init];
    newCell.delegate = self;
    newCell.frame = CGRectMake(0,
                               addFloat,
                               self.view.frame.size.width,
                               57);
    
    [newCell.checkContentView becomeFirstResponder];
    newCell.checkContentView.inputAccessoryView = self.inputBottomView;
    
    [self.cellArray addObject:newCell];
    [self.tableCellView addSubview:newCell];
    self.tableCellView.contentSize = CGSizeMake(self.view.frame.size.width, addFloat + self.firstCell.frame.size.height);

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
