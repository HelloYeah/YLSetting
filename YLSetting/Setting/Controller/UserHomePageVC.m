//
//  ViewController.h
//  YLSetting
//
//  Created by HelloYeah on 16/11/29.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "UserHomePageVC.h"
#import "UserInfoHeaderView.h"
#import "UIView+Frame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface UserHomePageVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UserInfoHeaderView * headerView;
@property (nonatomic,strong) UIButton * settingBtn;
@property (nonatomic,strong) UITableView *userHomeTableView;
@end

@implementation UserHomePageVC



#pragma mark - ******************** lift cycle *********************
- (void)viewDidLoad
{
   
    [super viewDidLoad];
    [self setUpSubViews];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

#pragma mark - ******************** layoutSubviews *********************

-  (void)setUpSubViews
{
    [self.view addSubview:self.userHomeTableView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.settingBtn];
}

#pragma mark - ******************** delegate *********************
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"test";
    return cell;
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat headH = - offsetY;
    if (headH <= 64 ) {
        headH = 64;
    }
    
    [self.headerView alphaWithHeight:headH orignHeight:kHeaderViewHeight];
}

#pragma mark 设置表
- (void)setTableView
{
    self.userHomeTableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);

}

- (UITableView *)userHomeTableView {

    if (!_userHomeTableView) {
        _userHomeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStylePlain];

        _userHomeTableView.delegate = self;
        _userHomeTableView.dataSource = self;
        _userHomeTableView.showsVerticalScrollIndicator = NO;
        _userHomeTableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);

    }
    return _userHomeTableView;
}

- (UserInfoHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[UserInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
        _headerView.checkUserInfomationBlock = ^{
            NSLog(@"点击了头像！！！");
        };
    }
    return _headerView;
}

- (UIButton *)settingBtn{
    
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 44, 20, 44, 44)];
        _settingBtn.imageView.contentMode = UIViewContentModeCenter;
        [_settingBtn setImage:[UIImage imageNamed:@"Setting"]  forState:UIControlStateNormal];
//        [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

@end
