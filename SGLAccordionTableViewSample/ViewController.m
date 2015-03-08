//
//  ViewController.m
//  SGLAccordionTableViewSample
//
//  Created by Jun Takahashi on 2015/03/08.
//  Copyright (c) 2015年 Jun Takahashi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *exArray = [NSMutableArray array];
    
    // 初期の開閉状態を保存
    [exArray insertObject:[NSNumber numberWithBool:YES] atIndex:0];
    [exArray insertObject:[NSNumber numberWithBool:NO] atIndex:1];
    
    // 開閉の初期状態を格納
    _tbl_sample.sectionExpandedNumberWithBoolArray = exArray;
    
    // delegate設定
    _tbl_sample.delegate = _tbl_sample;
    _tbl_sample.dataSource = _tbl_sample;
    _tbl_sample.tableDelegate = self;
    _tbl_sample.tableDataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tbl_sample.frame.size.width, 50)];
    label.backgroundColor = [UIColor lightGrayColor];

    label.text = [NSString stringWithFormat:@"Section%ld", section];
    
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row%ld", indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableViewSection:(NSInteger)section expanded:(BOOL)expanded headerView:(UIView *)view{
    
    NSLog(@"SectionHeader%ld Tapped!",section);
}

@end
