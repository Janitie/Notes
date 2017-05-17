//
//  CheckSonCell.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckCellTextFieldDelegate <NSObject>

- (void)addRawContent:(NSString *)content;

@end

@interface CheckSonCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UITextField *Checkcontent;

+ (NSString *)cellIdentifier;
+ (UINib *)cellNib;


@end
