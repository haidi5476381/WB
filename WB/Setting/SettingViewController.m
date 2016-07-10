//
//  SettingViewController.m
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonInfoTableViewCell.h"
#import "AccountViewController.h"
#import "SitComViewController.h"
@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_settingTableView;
    NSArray *_oneTitleArray;
    NSArray *_twoTitleArray;
     NSArray *_threeTitleArray;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _oneTitleArray = [NSArray arrayWithObjects:@"情景模式", nil];
    _twoTitleArray = [NSArray arrayWithObjects:@"账号管理", nil];
    _threeTitleArray = [NSArray arrayWithObjects:@"按键震动",@"按键音效", @"常见问题", nil];
    // Do any additional setup after loading the view from its nib.
    _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _settingTableView.dataSource = self;
    _settingTableView.delegate = self;
    [self.view addSubview:_settingTableView];
}



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _oneTitleArray.count;
    }else if (section == 1) {
        
        return _twoTitleArray.count;
    }else if (section == 2) {
        
        return _threeTitleArray.count;
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30.0f;
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10.0f;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headView.backgroundColor = [UIColor redColor];
    return headView;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    PersonInfoTableViewCell *personCell = [tableView dequeueReusableCellWithIdentifier:KPersonInfoTableViewCell];
    if (personCell == nil) {
        personCell = [PersonInfoTableViewCell personInfoTableViewCell];
        cell = personCell;
    }
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonInfoTableViewCell *personInfoCell = (PersonInfoTableViewCell *) cell;
    [personInfoCell updateTitle];
    if(indexPath.section == 0) {
        
        personInfoCell.titleLabel.text = [_oneTitleArray objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 1) {
        
        personInfoCell.titleLabel.text = [_twoTitleArray objectAtIndex:indexPath.row];
    }else if(indexPath.section == 2) {
        
        personInfoCell.titleLabel.text = [_threeTitleArray objectAtIndex:indexPath.row];
    }
    if (indexPath.section < 2) {
        personInfoCell.subTitleLabel.hidden = YES;
    }else {
        
        
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        
        SitComViewController *sitConVc = [[SitComViewController alloc] initWithNibName:@"SitComViewController" bundle:nil];
        [self.navigationController pushViewController:sitConVc animated:YES];
        
    }else if (indexPath.section == 1) {
        
        AccountViewController *accountVc = [[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil];
        [self.navigationController pushViewController:accountVc animated:YES];
    }
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
