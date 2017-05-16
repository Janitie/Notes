//
//  MainTableViewController.h
//  Notes
//
//  Created by 徐琬璇 on 2017/4/28.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewButton.h"


@interface MainTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,NewButtonDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIImageView * faceBtn;
@property (nonatomic, strong) UILabel * userName;

@property (nonatomic, strong) UIButton * naviRight;
@property (nonatomic, strong) NewButton * bottomBtn;

#pragma mark - Data Source
@property (nonatomic, strong) NSArray * dataSource;


@end
