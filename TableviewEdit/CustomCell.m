//
//  CustomCell.m
//  TableviewEdit
//
//  Created by Alex on 16/2/23.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "CustomCell.h"

#define BTN_SELECT_WIDTH 40
#define BTN_SELECT_HEIGHT 40

@implementation CustomCell

- (void)awakeFromNib {
    
    /*
        实现原理:编辑状态下，向右滑动的是ContentView，backgroundView 并没有一起滑动，所以在backgroundView 上增加一个
        选择按钮。
     */
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    backgroundView.backgroundColor = [UIColor clearColor];
    self.btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSelect.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:self.btnSelect];
    [self.btnSelect setBackgroundImage:[UIImage imageNamed:@"ic_checkbox_unchecked"] forState:UIControlStateNormal];
    [self.btnSelect addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundView = backgroundView;
    
}


- (void)updateBtnSelectFram
{
    self.btnSelect.frame = CGRectMake( 2, (self.frame.size.height - BTN_SELECT_HEIGHT)/2, BTN_SELECT_WIDTH, BTN_SELECT_HEIGHT);
}

- (IBAction)selectAction:(id)sender {
    
    if (!_customSelected) {
        _customSelected = YES;
        [self.btnSelect setBackgroundImage:[UIImage imageNamed:@"ic_checkbox_checked"] forState:UIControlStateNormal];
    }else
    {
        _customSelected = NO;
        [self.btnSelect setBackgroundImage:[UIImage imageNamed:@"ic_checkbox_unchecked"] forState:UIControlStateNormal];
    }
    
    !_customSelectedBlock ?: _customSelectedBlock(_customSelected, _row);
}

@end
