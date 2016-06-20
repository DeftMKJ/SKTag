//
//  MKJSecondViewController.m
//  TagListLayoutDemo
//
//  Created by 宓珂璟 on 16/6/20.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "MKJSecondViewController.h"
#import "MKJTagViewTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
@interface MKJSecondViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

static NSString *identyfy = @"MKJTagViewTableViewCell";

@implementation MKJSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"滚动视图插入Tag";
    [self.tableView registerNib:[UINib nibWithNibName:identyfy bundle:nil] forCellReuseIdentifier:identyfy];
    // 去掉多余的空cell
    self.tableView.tableFooterView = [UIView new];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKJTagViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfy forIndexPath:indexPath];
    [self configCell:cell indexpath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (void)configCell:(MKJTagViewTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    [cell.tagView removeAllTags];
    cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
    cell.tagView.padding = UIEdgeInsetsMake(20, 20, 20, 20);
    cell.tagView.lineSpacing = 20;
    cell.tagView.interitemSpacing = 30;
    cell.tagView.singleLine = NO;
    // 给出两个字段，如果给的是0，那么就是变化的,如果给的不是0，那么就是固定的
        cell.tagView.regularWidth = 80;
        cell.tagView.regularHeight = 30;
    NSArray *arr = [self.dataSource[indexpath.row] valueForKey:@"first"];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SKTag *tag = [[SKTag alloc] initWithText:arr[idx]];
        
        tag.font = [UIFont systemFontOfSize:12];
        tag.textColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0  blue:arc4random() % 256 / 255.0  alpha:1];
        tag.bgColor =[UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0  blue:arc4random() % 256 / 255.0  alpha:1];
        tag.cornerRadius = 5;
        tag.enable = YES;
        tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        [cell.tagView addTag:tag];
    }];
    
    cell.tagView.didTapTagAtIndex = ^(NSUInteger index)
    {
        NSLog(@"点击了%ld",index);
    };
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:identyfy configuration:^(id cell) {
       
        [self configCell:cell indexpath:indexPath];
    }];
}



- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@{@"first":@[@"奥迪A4",@"特斯拉",@"凯迪拉克",@"法拉利",@"雷克萨斯",@"拖拉机自行车",@"上海手拉面包车"]},@{@"first":@[@"NSString",@"NSMutableArr	Ωay",@"NSMutableDictionary",@"UIKit",@"UIViewController",@"UITableViewCell",@"UITableViewReusableView",@"UICollectionView",@"CIImage",@"CGContextRef",@"CoreText",@"Runtime"]},@{@"first":@[@"蓝色",@"白色",@"屎黄色",@"超级无敌屎黄色",@"超级无敌长毛的屎黄色",@"超级无敌已经长毛而且很硬的屎黄色",@"绿色",@"白色",@"请太色",@"蓝湖色",@"黄色",@"红色",@"橙色弄",@"舒服的舒服舒服",@"所得税的圣诞树上",@"黑色",@"贼黑贼黑色",@"红蓝白色",@"青",@"湖绿色黄色蓝",@"白色白色白白色"]}]];
    }
    return _dataSource;
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
