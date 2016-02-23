//
//  CustomCell.h
//  TableviewEdit
//
//  Created by Alex on 16/2/23.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CustomSelectBlock)(BOOL selected,NSInteger row);

@interface CustomCell : UITableViewCell

@property (assign, nonatomic) NSInteger row;
@property (strong, nonatomic) UIButton *btnSelect;
@property (getter=isCustomSelected) BOOL customSelected;
@property (copy, nonatomic) CustomSelectBlock customSelectedBlock;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

- (IBAction)selectAction:(id)sender;

@end
