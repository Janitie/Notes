//
//  MainTableViewController.m
//  Notes
//
//  Created by 徐琬璇 on 2017/4/28.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "MainTableViewController.h"
#import "NoteTableViewCell.h"
#import "CheckTableViewCell.h"
#import "FirstTableViewCell.h"

#import "LogInViewController.h"
#import "ContentViewController.h"

#import "INSSearchBar.h"
#import "LLSlideMenu.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>

#import "NoteService.h"

@interface MainTableViewController () <INSSearchBarDelegate>

@property (nonatomic, strong)  LLSlideMenu * slideMenu;

//全屏手势
@property (nonatomic, strong) UIPanGestureRecognizer * leftSwipe;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * percent;

@property (nonatomic, strong) INSSearchBar *searchBarWithDelegate;
//@property (nonatomic, strong) UIView * searchView;


@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
//    init Content
    [self setupTableView];
    
//    left menu setting
    [self putLeftMenu];
    
//    navigationBar setting
    [self hideNavigationBarBottomLine];
    
//    new File
    [self.view addSubview:self.bottomBtn];
    
    [self makeConstraints];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] valueForKey:@"isLogin"];
    if (isLogin == YES) {
        NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        self.userName.text = userName;
        
        NSURL * userIcon = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userIcon"]];
        [self.faceBtn sd_setImageWithURL:userIcon];
    }
    
    // get Data
    [self loadData];
}

- (void) makeConstraints {
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(CGRectGetHeight(self.bottomBtn.frame));
        make.width.mas_equalTo(CGRectGetWidth(self.bottomBtn.frame));
    }];
}

#pragma mark - Data Handle
- (void)loadData {
    [NoteService fetchNotes:nil callback:^(BOOL isSuccess, NSArray<NoteObject *> *results) {
        if (isSuccess) {
            self.dataSource = results;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableView Setup

- (void)setupTableView {
    //register cell
    [self.tableView registerNib:[NoteTableViewCell cellNib]
         forCellReuseIdentifier:[NoteTableViewCell cellIdentifier]];
    [self.tableView registerNib:[CheckTableViewCell cellNib]
         forCellReuseIdentifier:[CheckTableViewCell cellIdentifier]];
    [self.tableView registerNib:[FirstTableViewCell cellNib]
         forCellReuseIdentifier:[FirstTableViewCell cellIdentifier]];
    
    [self.view addSubview:self.tableView];
}

//height
- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect tableViewFrame = [UIScreen mainScreen].bounds;
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;

        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

#pragma mark - Getter
- (NewButton *)bottomBtn {
    if (_bottomBtn == nil) {
        _bottomBtn = [NewButton new];
        _bottomBtn.delegate = self;
    }
    return _bottomBtn;
}

- (UIImageView *)faceBtn {
    if (_faceBtn == nil) {
        _faceBtn = [[UIImageView alloc] initWithFrame:CGRectMake(74, 71, 80, 80)];
        [_faceBtn setImage:[UIImage imageNamed:@"defaultUser"]];
        [_faceBtn setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction)];
        [_faceBtn addGestureRecognizer:tapGes];
        
        _faceBtn.layer.masksToBounds = YES;
        _faceBtn.layer.cornerRadius = CGRectGetHeight(_faceBtn.frame)/2.0f;
    }
    return _faceBtn;
}

- (NSArray *) dataSource {
    return _dataSource;
}

#pragma mark - navigationBar

- (void)hideNavigationBarBottomLine {
    
    self.searchBarWithDelegate = [[INSSearchBar alloc] initWithFrame:CGRectMake(20.0, 30.0, 44.0, 34.0)];
    self.searchBarWithDelegate.delegate = self;
    [self.view addSubview:self.searchBarWithDelegate];
    
    self.naviRight = [[UIButton alloc] initWithFrame:CGRectMake(320, 36, 22, 22)];
    [self.naviRight setImage:[UIImage imageNamed:@"allIcon"] forState:UIControlStateNormal];
    [self.naviRight addTarget:self action:@selector(naviRightButtonDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.naviRight];
    
}

- (void)naviRightButtonDo:(id)sender {
    static int touched = 0;
    if (touched % 3 == 0) {
        [self.naviRight setImage:[UIImage imageNamed:@"notesIcon"] forState:UIControlStateNormal];
    }
    else if (touched % 3 == 1) {
        [self.naviRight setImage:[UIImage imageNamed:@"checkIcon"] forState:UIControlStateNormal];
    }
    else if (touched % 3 == 2) {
        [self.naviRight setImage:[UIImage imageNamed:@"allIcon"] forState:UIControlStateNormal];
    }
    touched++;
}

#pragma mark - SlideMenu

- (void)putLeftMenu {
    _slideMenu = [[LLSlideMenu alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:_slideMenu];
    
    // 设置菜单宽度
    _slideMenu.ll_menuWidth = 227.0f;
    // 设置菜单背景色
//    _slideMenu.ll_menuBackgroundColor = [UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:1.0f];
    _slideMenu.ll_menuBackgroundColor = [UIColor colorWithRed:117/255.0f green:67/255.0f blue:185/255.0f alpha:0.8f];
    // 设置弹力和速度，  默认的是20,15,60
    _slideMenu.ll_springDamping = 30;       // 阻力
    _slideMenu.ll_springVelocity = 20;      // 速度
    _slideMenu.ll_springFramesNum = 30;     // 关键帧数量
    
//    Whats in that Slide View
    [_slideMenu addSubview:self.faceBtn];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(64, 156, 100, 28)];
    _userName.text = @"DefalutName";
    [_userName setTextColor:[UIColor whiteColor]];
    [_userName setTextAlignment:NSTextAlignmentCenter];
    [_slideMenu addSubview:_userName];
    
    UIButton * quitWechat = [[UIButton alloc] initWithFrame:CGRectMake(78, 614, 80, 25)];
    [quitWechat setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitWechat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitWechat setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [quitWechat addTarget:self action:@selector(quitWechat) forControlEvents:UIControlEventTouchUpInside];
    [_slideMenu addSubview:quitWechat];
    

    //侧栏滑动
    self.leftSwipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandle:)];
    self.leftSwipe.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_leftSwipe];

}
- (void)quitWechat {
    //quit
    
    //UI
    [self.faceBtn setImage:[UIImage imageNamed:@"defaultUser"]];
    self.userName.text = @"Default_User";
    
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    NSLog(@"quit wechat");
}

- (void)imageViewTapAction {
    [_slideMenu ll_closeSlideMenu];
    if (!_slideMenu.ll_isOpen) {
        LogInViewController * log = [[LogInViewController alloc] init];
        log.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:log animated:YES completion:nil];
    }
}

- (void)swipeLeftHandle:(UIScreenEdgePanGestureRecognizer *)recognizer {
    //menu opened,swipe is fobidden
    if (_slideMenu.ll_isOpen || _slideMenu.ll_isAnimating) {
        return;
    }
    
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percent updateInteractiveTransition:progress];
        _slideMenu.ll_distance = [recognizer translationInView:self.view].x;
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.4) {
            [self.percent finishInteractiveTransition];
            [_slideMenu ll_openSlideMenu];
        }
        else {
            [self.percent cancelInteractiveTransition];
            [_slideMenu ll_closeSlideMenu];
        }
        self.percent = nil;
    }
    
//    Blur is better
    
    
    
    
  
}

#pragma mark - search bar delegate

- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(20.0, 30.0, CGRectGetWidth(self.view.bounds) - 80.0, 34.0);
}

- (void)searchBar:(INSSearchBar *)searchBar willStartTransitioningToState:(INSSearchBarState)destinationState
{
    // Do whatever you deem necessary.
//    _searchView = [[UIView alloc] initWithFrame:self.view.bounds];
//
//    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
//    //创建模糊view4
//    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effectView.frame = self.view.bounds;
//    [_searchView addSubview:effectView];
//    
//    [self.view addSubview:_searchView];
//    
//    [self.view bringSubviewToFront:_searchBarWithDelegate];
}

- (void)searchBar:(INSSearchBar *)searchBar didEndTransitioningFromState:(INSSearchBarState)previousState
{
    // Do whatever you deem necessary.
    
}

- (void)searchBarDidTapReturn:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
    
//    NSLog(@"searching %@",searchBar.searchField.text);
//    [_searchView removeFromSuperview];

}

- (void)searchBarTextDidChange:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteObject * note = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        return [FirstTableViewCell cellHeight:nil];
    }
    else if (note.isShared == false) {
        return [NoteTableViewCell cellHeight:nil];
    } else {
        NoteObject * note = self.dataSource[indexPath.row];
        // 用何種字體進行顯示
        UIFont *font = [UIFont systemFontOfSize:14];
        // 該行要顯示的內容
        NSString *content = note.content;
        // 計算出顯示完內容需要的最小尺寸
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(375.0f, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
        // 這裏返回需要的高度
        return size.height+50;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoteObject * note = self.dataSource[indexPath.row];
    UITableViewCell * cell = nil;
    if (indexPath.row == 0) {
        FirstTableViewCell * fCell = [tableView dequeueReusableCellWithIdentifier:[FirstTableViewCell cellIdentifier] forIndexPath:indexPath];
        cell = fCell;
        cell.userInteractionEnabled = NO;
    }
    else if (note.isShared == false) {
        NoteTableViewCell * nCell = [tableView dequeueReusableCellWithIdentifier:[NoteTableViewCell cellIdentifier] forIndexPath:indexPath];
        nCell.content.text = note.content;
        nCell.date.text = note.createAt;
        cell = nCell;
    } else {
        CheckTableViewCell * cCell = [tableView dequeueReusableCellWithIdentifier:[CheckTableViewCell cellIdentifier] forIndexPath:indexPath];
        cCell.content.text = note.content;
        cCell.time.text = note.createAt;
        cCell.title.text = note.title;
        cell = cCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    ContentViewController *detailViewController = [[ContentViewController alloc] initWithNibName:nil bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - newBtn delegate
- (void)leftButtonDidPush {
    ContentViewController * noteEdit = [[ContentViewController alloc] initWithBOOL:YES];
    [self.navigationController pushViewController:noteEdit animated:YES];
}

- (void)rightButtonDidPush {
    ContentViewController * checkEdit = [[ContentViewController alloc] initWithBOOL:NO];
    [self.navigationController pushViewController:checkEdit animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
