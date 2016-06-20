//
//  ViewController.m
//  TagListLayoutDemo
//
//  Created by 宓珂璟 on 16/6/20.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "ViewController.h"
#import "MKJFirstViewController.h"
#import "MKJSecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
- (IBAction)pushFirst:(id)sender
{
    MKJFirstViewController *first = [[MKJFirstViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:first];
    
    
    [self.navigationController presentViewController:nvc animated:YES completion:nil];
}
- (IBAction)pushSecond:(id)sender
{
    MKJSecondViewController *first = [[MKJSecondViewController alloc]init];
    [self.navigationController pushViewController:first animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
