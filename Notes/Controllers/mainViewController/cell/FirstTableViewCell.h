//
//  FirstTableViewCell.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/6.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell

+ (CGFloat)cellHeight:(id)data;

+ (NSString *)cellIdentifier;

+ (UINib *)cellNib;

@end
