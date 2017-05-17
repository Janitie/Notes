//
//  CheckEditViewController.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckEditViewController.h"
#import "CheckSonCell.h"
#import "NoteService.h"

@interface CheckEditViewController ()
{
    NoteObject * _note;
    
    BOOL _isUpdating;
}

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.titleField.delegate = self;
    
    [self.tableView registerNib:[CheckSonCell cellNib]
         forCellReuseIdentifier:[CheckSonCell cellIdentifier]];
    
    self.titleField.inputAccessoryView = self.inputBottomView;
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
}

- (IBAction)labelButtonDo:(id)sender {
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"respond");
    [self.titleField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore.


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckSonCell * sonCell = [tableView dequeueReusableCellWithIdentifier:[CheckSonCell cellIdentifier] forIndexPath:indexPath];
//    sonCell.inputAccessoryView = self.inputBottomView;
    return sonCell;
}




#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
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
