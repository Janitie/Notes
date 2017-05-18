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

- (instancetype)initWithBOOL:(BOOL)isNote;
- (void)setDataNoteObject:(NoteObject *)note;

@end
