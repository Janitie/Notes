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

@end

@implementation CheckEditViewController

- (instancetype)initWithBOOL:(BOOL)isNote {
    if ([super init]) {
        self.isNote = isNote;
        
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
}

- (IBAction)backButtonDo:(id)sender {
    if (_isUpdating == NO) {
        //只要有一个不空就新建
        if (![self.titleField.text isEqualToString:@""]) {
            [NoteService creatNewNoteWithTitle:self.titleField.text
                                       content:@""
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
}

- (IBAction)keyboardDownBtnDo:(id)sender {
    [self.titleField resignFirstResponder];
    [self.firstCell.checkContentView resignFirstResponder];
}

- (IBAction)labelButtonDo:(id)sender {
    NSLog(@"label");
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"respond");
    [self.titleField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore.


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


- (void)adjustCellHeight {
    NSLog(@"changing frame");
    self.firstCell.frame = CGRectMake(0, self.firstCell.frame.origin.y, self.firstCell.frame.size.width, self.firstCell.checkContentView.frame.size.height + 20);
}

- (void)didPushEnterAddHeight:(CGFloat)height {
    NSLog(@"ADD A CELL");
    NSLog(@" 1 flaot = %f",addFloat);
    CheckCellView * newCell = [[CheckCellView alloc] init];
    newCell.delegate = self;
    newCell.frame = CGRectMake(0,
                               self.firstCell.frame.origin.y + self.firstCell.frame.size.height + addFloat,
                               self.view.frame.size.width,
                               57);
    
    newCell.checkContentView.inputView = self.inputBottomView;
    [self.tableCellView addSubview:newCell];
    addFloat += height;
    NSLog(@" 2 flaot = %f",addFloat);
    self.tableCellView.contentSize = CGSizeMake(self.view.frame.size.width, addFloat);

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
