//
//  CheckSonCell.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckSonCell.h"

@implementation CheckSonCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.Checkcontent.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)statusBtnDo:(id)sender {
    NSLog(@"status!");
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"cell return");
    return YES;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:nil];
}

@end
