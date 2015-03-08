//
//  ViewController.h
//  SGLAccordionTableViewSample
//
//  Created by Jun Takahashi on 2015/03/08.
//  Copyright (c) 2015年 Jun Takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGLAccordionTableView.h"

@interface ViewController : UIViewController<SGLAccordionTableViewDelegate,SGLAccordionTableViewDataSource>


@property (weak, nonatomic) IBOutlet SGLAccordionTableView *tbl_sample;

@end

