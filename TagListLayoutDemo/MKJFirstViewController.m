//
//  MKJFirstViewController.m
//  TagListLayoutDemo
//
//  Created by 宓珂璟 on 16/6/20.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "MKJFirstViewController.h"
#import "UIImage+ImageCompress.h"
#import "SKTagView.h"
@interface MKJFirstViewController () <UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) SKTagView *tagView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UILabel *label;

@end

@implementation MKJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 360, 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入要搜索的文字";
    self.searchBar.showsCancelButton = YES;
    // 键盘确认按钮的名字
    self.searchBar.returnKeyType = UIReturnKeyNext;
    // 把默认灰色背景浮层给去掉
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.backgroundImage = [UIImage new];
    UITextField *searBarTextField = [self.searchBar valueForKey:@"_searchField"];
    if (searBarTextField)
    {
        [searBarTextField setBackgroundColor:[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]];
        searBarTextField.borderStyle = UITextBorderStyleRoundedRect;
        searBarTextField.layer.cornerRadius = 5.0f;
    }
    else
    {
        // 通过颜色画一个Image出来
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1] forSize:CGSizeMake(28, 28)];
        [self.searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
    }
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    [self.searchBar becomeFirstResponder];
    [self configTagView];
}


// 配置
- (void)configTagView
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 100, 30)];
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:13];
    self.label.text = @"历史搜索";
    [self.view addSubview:self.label];
    
    [self.tagView removeAllTags];
    self.tagView = [[SKTagView alloc] init];
    // 整个tagView对应其SuperView的上左下右距离
    self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    // 上下行之间的距离
    self.tagView.lineSpacing = 10;
    // item之间的距离
    self.tagView.interitemSpacing = 20;
    // 最大宽度
    self.tagView.preferredMaxLayoutWidth = 375;
//    @property (assign, nonatomic) CGFloat regularWidth; //!< 固定宽度
//    @property (nonatomic,assign ) CGFloat regularHeight; //!< 固定高度
    // 原作者没有能加固定宽度的，自己修改源码加上了固定宽度和高度,默认是0，就是标签式布局，如果实现了，那么就是固定宽度高度
//    self.tagView.regularWidth = 100;
//    self.tagView.regularHeight = 30;
    // 开始加载
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       // 初始化标签
        SKTag *tag = [[SKTag alloc] initWithText:self.dataSource[idx]];
        // 标签相对于自己容器的上左下右的距离
        tag.padding = UIEdgeInsetsMake(3, 15, 3, 15);
        // 弧度
        tag.cornerRadius = 3.0f;
        // 字体
        tag.font = [UIFont boldSystemFontOfSize:12];
        // 边框宽度
        tag.borderWidth = 0;
        // 背景
        tag.bgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        // 边框颜色
        tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        // 字体颜色
        tag.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
        // 是否可点击
        tag.enable = YES;
        // 加入到tagView
        [self.tagView addTag:tag];
    }];
    // 点击事件回调
    self.tagView.didTapTagAtIndex = ^(NSUInteger idx){
        
        NSLog(@"点击了第%ld个",idx);
        
    };
    
    // 获取刚才加入所有tag之后的内在高度
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height;
    NSLog(@"高度%lf",tagHeight);
    self.tagView.frame = CGRectMake(0, 120, 375, tagHeight);
    [self.tagView layoutSubviews];
    [self.view addSubview:self.tagView];

}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    if (searchText.length == 0) {
        // 没有文字了
        self.label.hidden = NO;
        self.tagView.hidden = NO;
    }
    else
    {
        self.label.hidden = YES;
        self.tagView.hidden = YES;
    }
}

// 网上找来的searbar修改右边文字的方法

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    (lldb) po self.searchBar.subviews[0].subviews
//    <__NSArrayM 0x7ffba1e08330>(
//                                <UISearchBarBackground: 0x7ffba1c670e0; frame = (0 0; 360 44); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7ffba1c201a0>>,
//                                <UISearchBarTextField: 0x7ffba1c905b0; frame = (0 0; 0 0); text = ''; clipsToBounds = YES; opaque = NO; layer = <CALayer: 0x7ffba1c90360>>,
//                                <UINavigationButton: 0x7ffba1c982c0; frame = (0 0; 53 30); opaque = NO; layer = <CALayer: 0x7ffba1c98800>>
//                                )
    
    
//    
//    (lldb) po self.searchBar.subviews
//    <__NSArrayM 0x7ffba1e77280>(
//                                <UIView: 0x7ffba1c8a470; frame = (0 0; 360 44); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x7ffba1c7ddc0>>
//                                )
    
//    searchBar.showsCancelButton = YES;
//    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
//        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
//            UIButton * cancel =(UIButton *)view;
//            [cancel setTitle:@"搜索" forState:UIControlStateNormal];
//            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
//            cancel.tintColor = [UIColor redColor];
//        }
//    }
}


-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@"余罪",@"恐怖游轮",@"放牛班的春天",@"当幸福来敲门",@"哈利波特",@"死亡密码",@"源代码",@"盗梦空间",@"疯狂动物城",@"X战警",@"西游降魔篇",@"这个男人来自地球",@"致命ID致命ID致命ID致命ID",@"搏击俱乐部",@"冰雪世界"]];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
