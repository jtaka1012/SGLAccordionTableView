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

    // delegate設定
    _tbl_sample.tableDelegate = self;
    _tbl_sample.tableDataSource = self;
    
    // ** tableDataSource設定後に実施 **/
    // 開閉の初期状態を格納
    NSMutableArray *esArray = [NSMutableArray array];
    
    [esArray insertObject:[NSNumber numberWithBool:YES] atIndex:0];
    [esArray insertObject:[NSNumber numberWithBool:NO] atIndex:1];
    [esArray insertObject:[NSNumber numberWithBool:YES] atIndex:2];
    [esArray insertObject:[NSNumber numberWithBool:NO] atIndex:3];
    [esArray insertObject:[NSNumber numberWithBool:YES] atIndex:4];
    [_tbl_sample setExpandStatus:esArray];

    // セクションヘッダーがスクロールするようにセクションヘッダーの最大値を設定
    _tbl_sample.scrollSectionHeaderHeight = 100;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1 || section == 4) {
        return 50;
    }
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tbl_sample.frame.size.width, 100)];
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

- (IBAction)pushedResetButton:(id)sender {
    
    // セクションの開閉状態を取得
    NSMutableArray *array = _tbl_sample.expandStatusArray;
    
    for (NSNumber *n in array) {
        NSLog(@"値は%d",[n boolValue]);
    }
    
}
@end
