//
//  checkTableViewCell.h
//  Notes
//
//  Created by 徐琬璇 on 2017/4/28.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;


- (void)cellHeightLayout:(NSString *)content;

+ (NSString *)cellIdentifier;

+ (UINib *)cellNib;

@end
