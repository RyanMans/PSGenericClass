//
//  PSInfoViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/13.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSInfoViewController.h"
#import "PSBottomBar.h"
#define Max_OffsetY  50

#import "PSContactViewController.h"
@interface PSInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    CGFloat _lastPosition;
    BOOL _isViewDisAppear;
}
@property (nonatomic,strong)PSBottomBar * bottomBar;
@property (nonatomic,strong)UIImageView * avatarView;
@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UIView * headBackView;
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UITableView * displayTableView;
@end

@implementation PSInfoViewController
- (void)dealloc
{
    _headBackView = nil;
    _headImageView = nil;
    _displayTableView = nil;
    _bottomBar = nil;
}
#pragma mark -懒加载-
- (UITableView*)displayTableView
{
    if (!_displayTableView) {
        _displayTableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        _displayTableView.showsVerticalScrollIndicator = NO;
        
    }
    return _displayTableView;
}

- (UIView*)headBackView
{
    if (!_headBackView) {
        _headBackView = NewClass(UIView);
        _headBackView.userInteractionEnabled = YES;
        _headBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HalfF(400));
        _headBackView.backgroundColor = RGB(32,177,232);
    }
    return _headBackView;
}

- (UIImageView*)headImageView
{
    if (!_headImageView)
    {
        _headImageView = NewClass(UIImageView);
        _headImageView.image = [UIImage imageNamed:@"bg"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor orangeColor];
    }
    return _headImageView;
}

- (UIImageView*)avatarView
{
    if (!_avatarView) {
        _avatarView = NewClass(UIImageView);
        _avatarView.image = [UIImage imageNamed:@"userhead"];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        _avatarView.size = CGSizeMake(HalfF(160), HalfF(160));
        [_avatarView setLayerWithCr:_avatarView.width / 2];
    }
    return _avatarView;
}

- (UILabel*)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = NewClass(UILabel);
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = FontOfSize(16);
        _messageLabel.textColor = WhiteColor;
    }
    return _messageLabel;
}

- (PSBottomBar*)bottomBar
{
    if (!_bottomBar) {
        
        WeakSelf(ws);
        _bottomBar = [[PSBottomBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - HalfF(128),SCREEN_WIDTH , HalfF(128))];
        _bottomBar.block = ^(BottomBarType type)
        {
            [ws clickBottomBarEvent:type];
        };
    }
    return _bottomBar;
}

- (void)clickBottomBarEvent:(BottomBarType)type
{
    if (type == BottomBarType_Original)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar ps_setTransformIdentity];
        }];

    }
    else if (type == BottomBarType_Up)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar ps_setTranslationY:- INVALID_VIEW_HEIGHT];
        }];
    }
}
#pragma mark --
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    LogFunctionName();
    
    [self.navigationController.navigationBar isRset:YES];
    [self scrollViewDidScroll:self.displayTableView];

//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    LogFunctionName();

    [super viewDidAppear:NO];
    
//    _isViewDisAppear = YES;
//    [self scrollViewDidScroll:self.displayTableView];


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _isViewDisAppear = NO;

    [self.navigationController.navigationBar ps_reset];

}
- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar ps_reset];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetHeaderView];
    
    self.displayTableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.displayTableView];
    
    [self.view addSubview:self.bottomBar];
    
    _displayTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.bottomBar.height)];
    
    [self.navigationController.navigationBar ps_setBackgroundColor:ClearColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:(UIBarButtonItemStylePlain) target:self action:@selector(showMoreEvent:)];
    
}
- (void)resetHeaderView
{
    self.headImageView.frame = self.headBackView.bounds;
    [self.headBackView addSubview:self.headImageView];
 
    self.avatarView.centerX = self.headBackView.centerX;
    self.avatarView.centerY = self.headBackView.centerY -  HalfF(70);
    [self.headBackView addSubview:self.avatarView];
    
    NSString * text = [NSString stringWithFormat:@"%@ : %@",_contactModel.name,_contactModel.mobile];
    
    self.messageLabel.text = text;
    self.messageLabel.y = CGRectGetMaxY(self.avatarView.frame) + HalfF(20);
    self.messageLabel.size = SizeWithAttributes(_messageLabel.text, _messageLabel.font);
    self.messageLabel.centerX = self.headBackView.centerX;
    [self.headBackView addSubview:self.messageLabel];
    
}
- (void)showMoreEvent:(UIBarButtonItem*)sender
{
    LogFunctionName();
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除联系人" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        //删除联系人 ，使用广播中心刷新页面
        
        [PSLocalDataStorageInstance removeMobileContactMessage:IsSafeString(_contactModel.recordID)];
        
        [PSMsgCenterInstance sendMessage:MsgTypeMobileContactNeedReload userParam:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1)
    {
        [actionSheet removeFromSuperview];
    }
}

#pragma mark -代理-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HalfF(100);
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentity = @"PSInfoViewController";
    
    UITableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentity];
    }
    tableViewCell.textLabel.text = @"图片下拉放大，导航上拉渐变";
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    PSContactViewController * tempVC = NewClass(PSContactViewController);
    [self.navigationController pushViewController:tempVC animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    
    NSLog(@"上下偏移量 OffsetY:%f ->",offset_Y);
    
    //1.处理图片放大
    CGFloat imageH = self.headBackView.size.height;
    CGFloat imageW = SCREEN_WIDTH;
    
    //下拉
    if (offset_Y < 0)
    {
        CGFloat totalOffset = imageH + ABS(offset_Y);
        CGFloat f = totalOffset / imageH;
        
        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
        self.headImageView.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offset_Y, imageW * f, totalOffset);
    }
    else
    {
        self.headImageView.frame = self.headBackView.bounds;
    }
    
    //2.处理导航颜色渐变  3.底部工具栏动画

//    if (_isViewDisAppear == NO) {
//        return;
//    }
    if (offset_Y > Max_OffsetY)
    {
        
        CGFloat alpha = MIN(1, 1 - ((Max_OffsetY + INVALID_VIEW_HEIGHT - offset_Y) / INVALID_VIEW_HEIGHT));
        
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
        
        if (offset_Y - _lastPosition > 5)
        {
            //向上滚动
            _lastPosition = offset_Y;
            
            [self bottomForwardDownAnimation];
        }
        else if (_lastPosition - offset_Y > 5)
        {
            // 向下滚动
            _lastPosition = offset_Y;
            [self bottomForwardUpAnimation];
        }

    }
    else
    {
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
        
        [self bottomForwardUpAnimation];
    }
    
    //滚动至顶部

    if (offset_Y < 0) {
        [self bottomForwardUpAnimation];

    }
    
    //滚动至底部
    CGSize size = _displayTableView.contentSize;
    
    float y = offset_Y + _displayTableView.height;
    float h = size.height;
    float reload_distance = 10;
    
    if (y > h - _bottomBar.height + reload_distance)
    {
        [self bottomForwardUpAnimation];
    }
}

- (void)bottomForwardDownAnimation
{
    CopyAsWeak(self, ws);
    [UIView animateWithDuration:0.2 animations: ^{
        ws.bottomBar.transform = CGAffineTransformMakeTranslation(0, ws.bottomBar.height);
    } completion: ^(BOOL finished) {
    }];
}

- (void)bottomForwardUpAnimation
{
    CopyAsWeak(self, ws);
    [UIView animateWithDuration:0.2 animations: ^{
        ws.bottomBar.transform = CGAffineTransformIdentity;
    } completion: ^(BOOL finished) {
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
