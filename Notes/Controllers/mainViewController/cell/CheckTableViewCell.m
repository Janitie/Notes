//
//  checkTableViewCell.m
//  Notes
//
//  Created by 徐琬璇 on 2017/4/28.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "CheckTableViewCell.h"

@implementation CheckTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Class Method

- (void)cellHeightLayout:(NSString *)content {
    self.content.lineBreakMode = NSLineBreakByWordWrapping;
    self.content.preferredMaxLayoutWidth = CGRectGetWidth(self.content.frame);
    self.content.text = content;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
