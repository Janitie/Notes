//
//  CheckEditViewController.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteObject.h"

@interface CheckEditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleField;


@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *keyboardDownButton;
@property (weak, nonatomic) IBOutlet UIButton *labelButton;
@property (strong, nonatomic) IBOutlet UIView *inputBottomView;


@property (assign, nonatomic) BOOL isNote;

- (instancetype)initWithBOOL:(BOOL)isNote;
- (void)setDataNoteObject:(NoteObject *)note;


@end
