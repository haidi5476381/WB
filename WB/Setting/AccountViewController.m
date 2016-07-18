//
//  AccountViewController.m
//  WB
//
//  Created by 余海华 on 16/7/5.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginTableViewCell.h"
#import "PersonInfoTableViewCell.h"
#import "ChangePasswordViewController.h"

@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_accountTableView;
    NSArray *_titleArray;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    _titleArray = [NSArray arrayWithObjects:@"用户名",@"密码", nil];
    _accountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _accountTableView.delegate = self;
    _accountTableView.dataSource = self;
    _accountTableView.backgroundColor = [UIColor clearColor];
    _accountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = IWColor(240, 240, 240);
    [self.view addSubview:_accountTableView];
    // Do any additional setup after loading the view from its nib.
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    headView.backgroundColor = IWColor(240, 240, 240);
    return headView;
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 20.0f;
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
    

    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
            LoginTableViewCell *loginCell = [tableView dequeueReusableCellWithIdentifier:KLoginTableViewCell];
        if (loginCell == nil) {
            loginCell = [LoginTableViewCell loginTableViewCell];
      
        }
              cell = loginCell;
    }else if (indexPath.section == 1) {
        
        PersonInfoTableViewCell *personInfoCell = [tableView dequeueReusableCellWithIdentifier:KPersonInfoTableViewCell];
        if (personInfoCell == nil) {
            personInfoCell = [PersonInfoTableViewCell personInfoTableViewCell];
        }
              cell = personInfoCell;
    }
   
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        LoginTableViewCell * loginCell = (LoginTableViewCell *) cell;
        loginCell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 1) {
        
        PersonInfoTableViewCell *personInfoCell = (PersonInfoTableViewCell *) cell;
        personInfoCell.titleLabel.text = @"修改密码";
        personInfoCell.subTitleLabel.hidden = YES;
        [personInfoCell updateTitle];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        ChangePasswordViewController *changeVc = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
        [self.navigationController pushViewController:changeVc animated:YES];
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
