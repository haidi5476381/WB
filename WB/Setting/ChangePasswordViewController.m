//
//  ChangePasswordViewController.m
//  WB
//
//  Created by 余海华 on 16/7/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LoginTableViewCell.h"
@interface ChangePasswordViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_changeTableView;
    NSArray *_titleArray;
    NSArray *_placeArray;
}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    _titleArray = [NSArray arrayWithObjects:@"当前密码", @"新密码",@"确认密码",nil];
    _placeArray = [NSArray arrayWithObjects:@"请输入当前密码", @"请输入新密码",@"请重新输入新密码",nil];
    _changeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _changeTableView.dataSource = self;
    _changeTableView.delegate = self;
    _changeTableView.backgroundColor = [UIColor clearColor];
    _changeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = IWColor(240, 240, 240);
    [self.view addSubview:_changeTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void) save {
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 20.0f;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    headView.backgroundColor = IWColor(240, 240, 240);
    return headView;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLoginTableViewCell];
    if (cell == nil) {
        cell = [LoginTableViewCell loginTableViewCell];
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LoginTableViewCell *loginCell = (LoginTableViewCell *) cell;
    loginCell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    loginCell.titleContextTextField.placeholder = [_placeArray objectAtIndex:indexPath.row];
    loginCell.titleContextTextField.textAlignment = NSTextAlignmentCenter;
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
