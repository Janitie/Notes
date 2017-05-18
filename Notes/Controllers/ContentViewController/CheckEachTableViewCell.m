//
//  CheckEachTableViewCell.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/18.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckEachTableViewCell.h"

@implementation CheckEachTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.statusDone = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Button Do

- (IBAction)statusDo:(id)sender {
    NSLog(@"status!");
}



+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:nil];
}
@end
