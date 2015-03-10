//
//  SGLAccordionTableView.h
//  TestTableView
//
//  Created by Jun Takahashi on 2015/03/08.
//  Copyright (c) 2015年 Jun Takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SGLAccordionTableViewDelegate <NSObject>

@optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableViewSection:(NSInteger)section expanded:(BOOL)expanded headerView:(UIView *)view;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end

@protocol SGLAccordionTableViewDataSource <NSObject>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

@end


@interface SGLAccordionTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

// アコーディオンの初期状態を格納する配列
@property (nonatomic,retain) NSMutableArray *sectionExpandedNumberWithBoolArray;
// 拡張時にTableViewの下にセルが隠れていた場合テーブルを上方向にスクロールしてセルを表示できるようにする (初期値 NO)
@property BOOL expandScrollAnimation;
// TableViewスクロール時にセクションが残らないようにするにはセクションヘッダーの最大値を設定 (初期値0でセクションヘッダーが残る)
@property float scrollSectionHeaderHeight;

// delegate
@property (nonatomic,assign) id<SGLAccordionTableViewDelegate> tableDelegate;
@property (nonatomic,assign) id<SGLAccordionTableViewDataSource> tableDataSource;

@end
