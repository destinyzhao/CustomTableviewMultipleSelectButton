//
//  ViewController.m
//  TableviewEdit
//
//  Created by Alex on 16/2/23.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  数据源
 */
@property (strong, nonatomic) NSMutableArray *dataArray;
/**
 *  选中的数据
 */
@property (strong, nonatomic) NSMutableArray *selectData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化数组
    _selectData = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    // 设置编辑状态下可以多选
    _tableView.allowsSelectionDuringEditing = YES;
    
    // 测试数据
    [self loadData];
}

#pragma mark -
#pragma mark - 初始化测试数据
- (void)loadData
{
    for (NSInteger i = 0; i < 40; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"Model-%ld",i]];
    }
}

#pragma mark -
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.contentLbl.text = [_dataArray objectAtIndex:indexPath.row];
    cell.row = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof (self) weakSelef = self;
    cell.customSelectedBlock = ^(BOOL selected,NSInteger row){
        if (selected) {
            [weakSelef.selectData addObject:[_dataArray objectAtIndex:row]];
            NSLog(@"%@",weakSelef.selectData);
        }
        else
        {
            [weakSelef.selectData removeObject:[_dataArray objectAtIndex:row]];
            NSLog(@"%@",weakSelef.selectData);
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为Cell的重用机制，所以当Cell滑进屏幕时会重用在重用队列中的Cell，导致Cell自定义选中状态不定。处理方式在Cell将要显示出来的时候判断一下做处理。
    if ([self.selectData containsObject:[_dataArray objectAtIndex:indexPath.row]]) {
        cell.customSelected = YES;
        [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"ic_checkbox_checked"] forState:UIControlStateNormal];
    }else
    {
        cell.customSelected = NO;
        [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"ic_checkbox_unchecked"] forState:UIControlStateNormal];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView.editing) {
        [cell selectAction:cell.btnSelect];
    }

}

#pragma mark -
#pragma mark - UITableView Editing Delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 隐藏多选按钮,添加自定义多选按钮
    return UITableViewCellEditingStyleDelete & UITableViewCellEditingStyleInsert;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editBtnClicked:(id)sender {
    if (!_tableView.editing) {
        _tableView.editing  = YES;
    }
    else
    {
        _tableView.editing = NO;
    }
}

@end
