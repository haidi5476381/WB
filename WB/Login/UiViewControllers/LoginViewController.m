//
//  LoginViewController.m
//  WB
//
//  Created by 余海华 on 16/6/21.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"
#import "LoginFootView.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *loginTableView;
    __block NSArray *_placeTitleArray;
    NSString *_userName;
    NSString *_passWord;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _placeTitleArray = [NSArray arrayWithObjects:@"请输入账号",@"请输入密码", nil];
    // Do any additional setup after loading the view from its nib.
    loginTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    loginTableView.dataSource = self;
    loginTableView.delegate = self;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    LoginFootView *loginFootView = [LoginFootView loginFootView];
    UITapGestureRecognizer *passwordTap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(forgetPassword)];
    [loginFootView.forgetButton addGestureRecognizer:passwordTap];
    
    UITapGestureRecognizer *registerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registered)];
    [loginFootView.registerButton addGestureRecognizer:registerTap];
    [footView addSubview:loginFootView];
    [loginFootView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(footView.mas_top);
        make.leading.equalTo(footView.mas_leading);
        make.trailing.equalTo(footView.mas_trailing);
        make.bottom.equalTo(footView.mas_bottom);
    }];
    loginTableView.tableFooterView = footView;
  
    [self.view addSubview:loginTableView];
}

-(void) forgetPassword{
    
    ForgetViewController *forgetVc = [[ForgetViewController alloc] initWithNibName:@"ForgetViewController" bundle:nil];
    [self.navigationController pushViewController:forgetVc animated:YES];
    
}

-(void)registered {
    
    RegisterViewController *registerVc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVc animated:YES];
}


#pragma mark UITableView
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
}



-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLoginTableViewCell];
    if (cell == nil) {
        cell = [LoginTableViewCell loginTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LoginTableViewCell *loginCell = (LoginTableViewCell *) cell;
    loginCell.titleContextTextField.tag = indexPath.row;
    loginCell.block = ^(UITextField *textField) {
        NSString *textFieldString = nil;
        switch (textField.tag) {
            case 0: {
                textFieldString = _userName;
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [button setBackgroundImage:[[UIImage imageNamed:@"login_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                textField.leftView = button;
                textField.leftViewMode = UITextFieldViewModeAlways;
                textField.secureTextEntry = YES;
            }
                break;
            case 1: {
             
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [button setBackgroundImage:[[UIImage imageNamed:@"login_lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                textField.leftView = button;
                textField.leftViewMode = UITextFieldViewModeAlways;
                textField.secureTextEntry = YES;
                textFieldString = _passWord ;
            }
                break;
            default:break;
                
        }
        
        if (textFieldString == nil) {
            textField.placeholder = [_placeTitleArray objectAtIndex:indexPath.row];
   
        }else {
            textField.text = textFieldString;
        }
        
        switch (textField.tag) {
            case 1:
                textField.secureTextEntry = YES;
                break;
                
            default:
                break;
        }
    };
    @weakify(self);
    loginCell.textFieldBlock = ^(UITextField *contextField) {
        @strongify(self);
        switch (contextField.tag) {
            case 0:
                _userName = [contextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                break;
            case 1:
                _passWord = [contextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                break;
            default:
                break;
        }
    };
    loginCell.yanCodeButton.hidden = YES;
    if(indexPath.row == 1) {
        loginCell.topLineView.hidden = YES;
        
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
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
