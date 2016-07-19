//
//  DevicesViewController.m
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "DevicesViewController.h"
#import "SettingItemTableViewCell.h"
#import "YaokongViewController.h"
#import "ItemTableViewCell.h"
#import "ItemAddViewController.h"

/// controller
#import "YDVCPickerViewController.h"
#import "WBTVViewController.h"

@interface DevicesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_settingitemTableView;
    UITableView *_itemTableView;
    
    NSArray *_settingItemTitleArray;
    NSArray *_settingItemImageArray;
}
@end

@implementation DevicesViewController

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets=NO;
    _settingItemTitleArray = [NSArray arrayWithObjects:@"智能遥控器", @"智能插座",nil];
    _settingItemImageArray = [NSArray arrayWithObjects:@"device_btn_airconditioner_n",@"device_btn_airconditioner_n", nil];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navibar_btn_plus" highImageName:@"navibar_btn_plus" target:self action:@selector(add)];
    [self setItemTableView];
    [self layoutItemView];
    
    //    // 显示“传送门”，注意在添加rootVC后调用
    [YDVCPickerViewController showFinderWithClassPrefix:@[@"WB"]];
}

-(void) layoutItemView {
    
    _itemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _itemTableView.dataSource = self;
    _itemTableView.delegate = self;
    [self.view addSubview:_itemTableView];
}



-(void) add {
    
    
    [self.view addSubview:_settingitemTableView];
    [_settingitemTableView reloadData];
}



-(void) setItemTableView {
    
    _settingitemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110) style:UITableViewStylePlain];
    _settingitemTableView.dataSource = self;
    _settingitemTableView.delegate = self;
    _settingitemTableView.scrollEnabled = NO;

}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_settingitemTableView]) {
        return 55.0f;
    }else if ([tableView isEqual:_itemTableView]) {
        
        return 80.0f;
    }
    return 0.0f;
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_settingitemTableView]) {
        
        return 2;
    }
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if ([tableView isEqual:_settingitemTableView]) {
        
        SettingItemTableViewCell *settingItemCell = [tableView dequeueReusableCellWithIdentifier:KSettingItemTableViewCell];
        if (settingItemCell == nil) {
            settingItemCell = [SettingItemTableViewCell settingItemTableViewCell];
            cell = settingItemCell;
        }
    }else if ([tableView isEqual:_itemTableView]) {
        
        ItemTableViewCell *itemTableCell = [tableView dequeueReusableCellWithIdentifier:KItemTableViewCell];
        if (itemTableCell == nil) {
            itemTableCell = [ItemTableViewCell itemTableViewCell];
            cell = itemTableCell;
        }
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_settingitemTableView]) {
        
        SettingItemTableViewCell *settingCell = (SettingItemTableViewCell *)cell;
        settingCell.itemImageView.image = [UIImage imageNamed:[_settingItemImageArray objectAtIndex:indexPath.row]];
        settingCell.itemTitleLabel.text = [_settingItemTitleArray objectAtIndex:indexPath.row];
    }else if([tableView isEqual:_itemTableView]) {
        
        ItemTableViewCell *itemCell = (ItemTableViewCell *) cell;
        itemCell.itemImageView.image = [UIImage imageNamed:[_settingItemImageArray objectAtIndex:indexPath.row]];
        itemCell.itemTitleLabel.text = @"智能插座";
        itemCell.itemSubTitleLabel.text = @"温度:20c 湿度：50%";
        itemCell.leftImageView.image = [UIImage imageNamed:@"devicelist_btn_swichon"];
    }
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_settingitemTableView]) {
        
      
        YaokongViewController *yaoKongVc = [[YaokongViewController alloc] initWithNibName:@"YaokongViewController" bundle:nil];
        
        [self.navigationController pushViewController:yaoKongVc animated:YES];
        
        [_settingitemTableView removeFromSuperview];
        _settingitemTableView = nil;
        
    }else if([tableView isEqual:_itemTableView]) {
        
        if (indexPath.section == 1) {
            
            
        }
        
        
    }
    
}


//左滑菜单项
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _itemTableView) {
        
        __weak typeof(self) wkSelf=self;
        //添加
        UITableViewRowAction *addAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"添加" handler:^(UITableViewRowAction *  action, NSIndexPath *  indexPath) {
            //
            //        [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
            //        [tableView setEditing:NO animated:YES];
            //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            ItemAddViewController *itemAddVc = [[ItemAddViewController alloc] initWithNibName:@"ItemAddViewController" bundle:nil];
            [self.navigationController pushViewController:itemAddVc animated:YES];
        }];
        //编辑
        UITableViewRowAction *editAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
            //        id obj=[wkSelf.dataArray objectAtIndex:indexPath.row];
            //        [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
            //        [wkSelf.dataArray insertObject:obj atIndex:0];
            //        [tableView setEditing:NO animated:YES];
            //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            [tableView reloadData];
            //        });
        }];
        
        //删除
        UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
            //        id obj=[wkSelf.dataArray objectAtIndex:indexPath.row];
            //        [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
            //        [wkSelf.dataArray insertObject:obj atIndex:0];
            //        [tableView setEditing:NO animated:YES];
            //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            [tableView reloadData];
            //        });
        }];
        
        addAction.backgroundColor=IWColor(101, 198, 187);
        editAction.backgroundColor = IWColor(81, 179, 216);
        deleteAction.backgroundColor = [UIColor redColor];
        
        return @[deleteAction,editAction,addAction];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
