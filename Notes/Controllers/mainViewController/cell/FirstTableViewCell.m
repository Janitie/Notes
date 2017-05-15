//
//  FirstTableViewCell.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/6.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Class Method
+ (CGFloat)cellHeight:(id)data {
    return 50.0f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:nil];
}
@end
