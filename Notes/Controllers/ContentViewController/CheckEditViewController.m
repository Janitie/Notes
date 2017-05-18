//
//  CheckEditViewController.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckEditViewController.h"
#import "NoteService.h"
#import "SingleCheckCell.h"
#import "BSobject.h"

@interface CheckEditViewController ()<singleCheckDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NoteObject * _note;
    BOOL _isUpdating;
    float addFloat;
}

//@property (nonatomic, strong) CheckCellView * firstCell;
//@property (strong, nonatomic) IBOutlet UIScrollView *tableCellView;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property (strong, nonatomic) UITableView * tableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *keyboardDownButton;
@property (weak, nonatomic) IBOutlet UIButton *labelButton;
@property (strong, nonatomic) IBOutlet UIView *inputBottomView;

@property (strong, nonatomic) NSMutableArray<BSobject *> * cellStringArray;
@property (assign, nonatomic) BOOL isNote;

@end

@implementation CheckEditViewController

- (instancetype)initWithBOOL:(BOOL)isNote {
    if ([super init]) {
        self.isNote = isNote;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self settings];
    [self setViewData];
}

- (void)settings {
    self.titleField.inputAccessoryView = self.inputBottomView;
    self.titleField.delegate = self;
    
    [self.tableView registerNib:[SingleCheckCell cellNib]   forCellReuseIdentifier:[SingleCheckCell cellIdentifier]];
    [self.view addSubview:self.tableView];
    
}

- (void)setDataNoteObject:(NoteObject *)note {
    _note = note;
    NSLog(@"saveData = %@",_note.content);

    _isUpdating = YES;
}


- (void)setViewData {
    self.titleField.text = _note.title;

    NSArray * rawArray = [_note.content componentsSeparatedByString:@"%cObject%["];
    NSMutableArray * rawMArray = [rawArray mutableCopy];
    [rawMArray removeObject:[rawMArray firstObject]];
//    for (NSString * string in rawMArray) {
//        NSLog(@" raw string = %@",string);
//    }
    
    NSMutableArray * noteArray = [NSMutableArray array];
    for (NSString * string in rawMArray) {
        BSobject * newObj = [BSobject new];
        NSString * firstChar = [string substringToIndex:1];
        if ([firstChar isEqualToString:@"x"]) {
            newObj.status = YES;
        }
        else if ([firstChar isEqualToString:@" "]) {
            newObj.status = NO;
        }
        newObj.content = [string substringFromIndex:2];
        [noteArray addObject:newObj];
//        [self.cellStringArray addObject:newObj];
//        NSLog(@"newContent = %@",newObj.content);
    }
    
    if (noteArray.count > 0) {
        self.cellStringArray = noteArray;
    }

}



#pragma mark - buttonDo

- (IBAction)backButtonDo:(id)sender {
//    for (BSobject * obj in self.cellStringArray) {
//        NSLog(@"back string = %@",obj.content);
//    }
//    
    NSString * content = [self assortContentString];
    NSLog(@"final content = %@",content);
    //从新建入口入,新建check
    if (_isUpdating == NO) {
        //只有存在一个任务才新建
        if (![content isEqualToString:@""]) {
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
    //从cell入口入，先显示已有界面
    else {
        //当全空时删除
        if ([content isEqualToString:@""]) {
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
                             Content:content
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

- (IBAction)keyboardDownBtnDo:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)labelButtonDo:(id)sender {
    NSLog(@"label");
}

- (NSString *)assortContentString {
    NSString * content = @"";
    
    for (BSobject * obj in self.cellStringArray) {
        NSString * eachString = @"";
        if (![obj.content isEqualToString:@""]) {
            if (obj.status == NO) {
                eachString = [eachString stringByAppendingString:@"%cObject%[ ]"];
            }
            else {
                eachString = [eachString stringByAppendingString:@"%cObject%[x]"];
            }
        }
        eachString = [eachString stringByAppendingString:obj.content];
        content = [content stringByAppendingString:eachString];
    }
    NSLog(@"content = %@",content);
    return content;
    
}


#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 83, self.view.frame.size.width, 551)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray<BSobject *> *)cellStringArray {
    if (_cellStringArray == nil) {
        self.cellStringArray = [[NSMutableArray alloc] init];
        [self.cellStringArray addObject:[BSobject new]];
    }
    return _cellStringArray;
}


#pragma mark - TitleField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"respond");
    [self.titleField resignFirstResponder];
    return YES;
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellStringArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * string = self.cellStringArray[indexPath.row].content;
    if ([string isEqualToString:@""]) {
        return 50.0f;
    } else {
        UIFont * font = [UIFont systemFontOfSize:14];
//        NSLog(@"cell string = %@",string);
        CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(261.0f,500.f) lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat cellHeight = size.height + 35.0f;
        return cellHeight;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * content = self.cellStringArray[indexPath.row].content;
    BOOL status = self.cellStringArray[indexPath.row].status;
    
    SingleCheckCell * eCell = [tableView dequeueReusableCellWithIdentifier:[SingleCheckCell cellIdentifier] forIndexPath:indexPath];
    eCell.indexNumber = indexPath.row;
    eCell.delegate = self;
    eCell.textView.inputAccessoryView = self.inputBottomView;
    eCell.statusDone = status;
    eCell.textView.text = content;
    eCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return eCell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark - cell Delegate

- (void)stringDidChange:(NSString *)string fromIndex:(NSInteger)index {
    if (index < [self.cellStringArray count]) {
        self.cellStringArray[index].content = string;
    } else {
        BSobject * obj = [BSobject new];
        obj.content = string;
        [self.cellStringArray insertObject:obj atIndex:index];
    }
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)stringDidConfirm:(NSString *)string fromIndex:(NSInteger)index{
    
    if (index == [self.cellStringArray count] - 1) {
        [self.cellStringArray addObject:[BSobject new]];
    }
    [self.tableView reloadData];
//    NSLog(@"index = %ld",index);
//    if (index+1 > [self.cellStringArray count]) {
//        [self.cellStringArray addObject:string];
//    }
//    else {
//        self.cellStringArray[index] = string;
//    }
//    for (NSString * strin in _cellStringArray) {
//        NSLog(@"each string = %@",strin);
//    }
//    
//    [self.tableView reloadData];
}

- (void)deleteCellFromIndex:(NSInteger)index {
    NSString * content = self.cellStringArray[index].content;
    if (content.length > 0) {
        self.cellStringArray[index].content = @"";
        [self.tableView reloadData];
        return;
    }
    
    if (index == 0 && [self.cellStringArray count] <= 1) {
        return;
    }
    [self.cellStringArray removeObjectAtIndex:index];
    [self.tableView reloadData];
}

- (void)statusDidChangeTo:(BOOL)status fromIndex:(NSInteger)index {
    self.cellStringArray[index].status = status;
}


#pragma mark - keyBoard Notif
- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
//    NSLog(@"keyBoard:%f", keyboardSize.height);  //293
    ///keyboardWasShown = YES;
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
