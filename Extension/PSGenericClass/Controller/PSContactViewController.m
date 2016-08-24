//
//  PSContactViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSContactViewController.h"
#import "PSMobileBookViewController.h"

@interface PSContactViewController ()
{
    UILabel * _textLabel;
    
    UIButton * _localMobileBtn;
    
    UIButton * _dataListBtn;
    
}
@end

@implementation PSContactViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    
    
    
    
    
}

- (void)initUI
{
    
    NSDictionary * attributeDict = @{NSForegroundColorAttributeName:BlueColor};
    NSString * text = @"GCD处理列表 数据 ，以及消息通知 网络 和 本地数据库的结合使用 : 在这里主要是介绍下自己处理大列表的数据 的一套系统逻辑。 主要目的在于 如何去捋涮 大列表处理数据的一整套逻辑。 1.读取本地缓存数据  2.gcd 处理数据  3.网络获取数据  4.消息通知 5.在这里我也写了一个 读取本地手机通讯录的类库，功能介绍的话看具体类库。  小技巧：使用c语言去 封装一些 oc 的大长度的的系统代码 ，比如 gcd，通知 ，或者NSUserDefaults等等";
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:text];
    [string setAttributes:attributeDict range:[text rangeOfString:@"GCD处理列表 数据 ，以及消息通知 网络 和 本地数据库的结合使用"]];
    
    attributeDict = @{NSForegroundColorAttributeName:RedColor};
    [string setAttributes:attributeDict range:[text rangeOfString:@"1.读取本地缓存数据  2.gcd 处理数据  3.网络获取数据  4.消息通知 5.在这里我也写了一个 读取本地手机通讯录的类库，功能介绍的话看具体类库。"]];
    
    
    _textLabel = NewClass(UILabel);
    _textLabel.x = HalfF(30);
    _textLabel.y = INVALID_VIEW_HEIGHT + HalfF(40);
    _textLabel.height = HalfF(500);
    _textLabel.width = SCREEN_WIDTH - 2*_textLabel.x;
    _textLabel.textAlignment = NSTextAlignmentLeft;
    _textLabel.font = FontOfSize(15);
    _textLabel.textColor = RGB(51, 51, 51);
    _textLabel.attributedText =  string;
    
    _textLabel.numberOfLines = 0;
    [self.view addSubview:_textLabel];
    
    
    _localMobileBtn = [self instanceSender];
    _localMobileBtn.x = (SCREEN_WIDTH - 2*_localMobileBtn.width) / 3;
    _localMobileBtn.y = CGRectGetMaxY(_textLabel.frame) + HalfF(88);
    [_localMobileBtn setTitle:@"手机通讯录" forState:(UIControlStateNormal)];
    [self.view addSubview:_localMobileBtn];
    
    
    _dataListBtn = [self instanceSender];
    _dataListBtn.x = (SCREEN_WIDTH - 2*_localMobileBtn.width) / 3  + CGRectGetMaxX(_localMobileBtn.frame);
    _dataListBtn.y = _localMobileBtn.y;
    [_dataListBtn setTitle:@"数据列表" forState:(UIControlStateNormal)];
    [self.view addSubview:_dataListBtn];
    
}

- (UIButton *)instanceSender
{
    UIButton * button = NewClass(UIButton);
    button.backgroundColor = RGB(68, 159, 255);
    button.width = HalfF(200);
    button.height = HalfF(88);
    
    [button setLayerWithCr:5.0f];
    [button addTarget:self action:@selector(clickEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
- (void)clickEvent:(UIButton*)sender
{
    LogFunctionName();
    
    if (sender == _localMobileBtn) {
        
        PSMobileBookViewController  * vc = [[PSMobileBookViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender == _dataListBtn)
    {
        
    }  
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
