//
//  SGLAccordionTableView.m
//  TestTableView
//
//  Created by Jun Takahashi on 2015/03/08.
//  Copyright (c) 2015年 Jun Takahashi. All rights reserved.
//

#import "SGLAccordionTableView.h"

@implementation SGLAccordionTableView{
    NSMutableArray *sectionHeaderArray;
}

#define headerBasedNo 50000

// delegate,dataSourceの設定
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.dataSource = self;
        _sectionExpandedNumberWithBoolArray = [NSMutableArray array];
        _expandScrollAnimation = NO;
    }
    return self;
}

// テーブルのセクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_tableDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        // delegate先でセクション数を取得
        return [_tableDataSource numberOfSectionsInTableView:tableView];
    }
    
    return 0;
}

//セクションヘッダーの高さ指定
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([_tableDelegate respondsToSelector:@selector(tableView: heightForHeaderInSection:)]) {
        // delegate先でテーブルの高さを取得
        return [_tableDelegate tableView:tableView heightForHeaderInSection:section];
    }
    
    // 初期値
    return self.sectionHeaderHeight;
}

// セクションヘッダーのタイトルを設定
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([_tableDataSource respondsToSelector:@selector(tableView: titleForHeaderInSection:)]) {
        // dataSource先でセクションタイトルを取得
        return [_tableDataSource tableView:tableView titleForHeaderInSection:section];
    }
    
    // 初期値としてnilを返却
    return nil;
    
}

// セクションのヘッダービュー
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // ヘッダーの幅(TableViewの横幅)を取得
    CGFloat width = tableView.frame.size.width;
    // ヘッダーの高さを取得
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    // ヘッダービューの生成
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    // ヘッダーにタイトルを設定
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    // ヘッダーの背景色を設定
    headerLabel.backgroundColor = self.sectionIndexBackgroundColor;
    
    // 返却用のViewを生成
    UIView *headerView = headerLabel;
    
    if ([_tableDelegate respondsToSelector:@selector(tableView: viewForHeaderInSection:)]) {
        // delegate先でセクションタイトルを取得
        headerView = [_tableDelegate tableView:tableView viewForHeaderInSection:section];
    }
    
    // タップイベントが感知できるよう設定変更
    headerView.userInteractionEnabled = YES;
    for (UIView *v in [headerView subviews]) {
        v.userInteractionEnabled = YES;
    }

    // タップイベントが感知できるようtabに番号を設定
    NSInteger tag = headerBasedNo + section;
    headerView.tag = tag;
    
    // ヘッダーをarrayに格納
    if (sectionHeaderArray.count == 0 || sectionHeaderArray == nil) {
        sectionHeaderArray = [NSMutableArray array];
    }
    
    // 初回生成時はオブジェクトをinsert、再生成時はreplace
    if (sectionHeaderArray.count > section) {
        [sectionHeaderArray replaceObjectAtIndex:section withObject:headerView];
    }else{
        [sectionHeaderArray insertObject:headerView atIndex:section];
    }
    
    return headerView;
}

// テーブルの行の数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // sectionExpandedNumberWithBoolArrayの設定内容確認
    if (_sectionExpandedNumberWithBoolArray == nil) {
        _sectionExpandedNumberWithBoolArray = [NSMutableArray array];
    }
    
     // 開閉状態の初期設定
    NSInteger maxSection = [self numberOfSectionsInTableView:self];
    if (maxSection > _sectionExpandedNumberWithBoolArray.count) {
        NSInteger insertCount = _sectionExpandedNumberWithBoolArray.count - 1;
        for(NSInteger i = insertCount; i <= maxSection; i++) {
            [_sectionExpandedNumberWithBoolArray insertObject:[NSNumber numberWithBool:YES] atIndex:i];
        }
     }
    
    // Number型で保存されたboolを変換
    NSNumber *obj = _sectionExpandedNumberWithBoolArray[section];
    
    // NSNumber型でない場合開帳状態として登録
    if (![obj isKindOfClass:[NSNumber class]]) {
        [_sectionExpandedNumberWithBoolArray replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:YES]];
    }
    
    if (obj != nil) {
        BOOL isExpanded = [obj boolValue];
        
        if (isExpanded) {
            if ([_tableDataSource respondsToSelector:@selector(tableView: numberOfRowsInSection:)]) {
                // dataSource先で行数を取得
                return [_tableDataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    
    // 拡張されていない場合、delegate先に実装されていない場合は0を返却
    return 0;
}

// テーブルの行の高さ
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_tableDelegate respondsToSelector:@selector(tableView: heightForRowAtIndexPath:)]) {
        // delegate先でテーブルの高さを取得
        return [_tableDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    // 初期値
    return self.rowHeight;
}

// セルの描画処理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_tableDataSource respondsToSelector:@selector(tableView: cellForRowAtIndexPath:)]) {
        // dataSource先でセルを取得
        return [_tableDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    // delegate先に実装されたいない場合
    return [UITableViewCell new];
}

// セルタップ時の動作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_tableDelegate respondsToSelector:@selector(tableView: didSelectRowAtIndexPath:)]) {
        // delegate先でセルタップ時の編集作業を実施
        [_tableDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 親のメソッド実行
    [super touchesBegan:touches withEvent:event];
    
    // タッチされたViewを取得
    UITouch *touchedObj = [touches anyObject];
    UIView *touchedView = touchedObj.view;
    
    // タップされた領域がセクションの上に貼り付けられたViewである場合
    // 親のセクションビューを検索する
    // タップされた領域がCellの場合はタグを検索中断する
    while (headerBasedNo > touchedView.tag && [touchedView isKindOfClass:[UITableView class]] == NO ) {
        touchedView = [touchedView superview];
    }
    
    // ヘッダーのタップ判定
    if (touchedView.tag >= headerBasedNo) {
        // セクション番号を取得
        NSInteger section = touchedView.tag%headerBasedNo;
        
        // セクションの拡張状態の更新
        // 現在の拡張状態
        NSNumber *obj = _sectionExpandedNumberWithBoolArray[section];
        BOOL currentStatus = [obj boolValue];
        
        // 状態を反転させて再設定
        BOOL isExpanded = !currentStatus;
        NSNumber *changedStatus = [NSNumber numberWithBool:!currentStatus];
        [_sectionExpandedNumberWithBoolArray replaceObjectAtIndex:section withObject:changedStatus];
        
        // 開帳時の行数を取得
        NSInteger count = 0;
        if ([_tableDataSource respondsToSelector:@selector(tableView: numberOfRowsInSection:)]) {
            // delegate先で行数を取得
            count =  [_tableDataSource tableView:self numberOfRowsInSection:section];
        }
        
        // アコーディオンの開閉を実施
        if(isExpanded){
            [self expandSection:section rowCount:count];
        }else{
            [self collapseSection:section rowCount:count];
        }
        
        // アコーディオンが開閉された事をdelegate先へ通知
        // 開閉が行われたセクションのヘッダーを取得
        UIView *headerView = sectionHeaderArray[section];
        
        if ([_tableDelegate respondsToSelector:@selector(tableViewSection: expanded: headerView:)]) {
            // delegate先ヘッダーの編集処理を実施
            [_tableDelegate tableViewSection:section expanded:isExpanded headerView:headerView];
        }
    }
    
}

// セクション開閉時のヘッダー編集処理
-(void)tableViewSection:(NSInteger)section expanded:(BOOL)expanded headerView:(UIView *)view{
    
}

// 縮小アニメーション
- (void)collapseSection:(NSInteger)section rowCount:(NSInteger)count{
    NSMutableArray *indexPaths = [NSMutableArray new];
    for(int i = 0; i < count; i++){
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

//拡張アニメーション
- (void)expandSection:(NSInteger)section rowCount:(NSInteger)count{
    NSMutableArray *indexPaths = [NSMutableArray new];
    
    for(int i = 0; i < count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    if (_expandScrollAnimation) {
        // 拡張時、該当セクションが隠れていた場合TableViewに表示されるようにスクロールする
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

@end
