//
//  AccountViewController.m
//  WB
//
//  Created by 余海华 on 16/7/5.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginTableViewCell.h"

@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_accountTableView;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _accountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _accountTableView.delegate = self;
    _accountTableView.dataSource = self;
    [self.view addSubview:_accountTableView];
    // Do any additional setup after loading the view from its nib.
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLoginTableViewCell];
    if (cell == nil) {
        cell = [LoginTableViewCell loginTableViewCell];
    }
    return cell;
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
