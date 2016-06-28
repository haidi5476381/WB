//
//  RegisterViewController.m
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginButtonView.h"
#import "LoginTableViewCell.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *registerTableView;
    NSArray *_placeTitleArray;
    NSString *_userName;
    NSString *_password;
    NSString *_confirmPassword;
    NSString *_yanPassword;
}

@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placeTitleArray = [NSArray arrayWithObjects:@"请输入手机号码或者邮箱",@"输入密码", @"确定密码",@"请输入短信验证码",nil];
    // Do any additional setup after loading the view from its nib.
    registerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    registerTableView.dataSource = self;
    registerTableView.delegate = self;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    footView.backgroundColor = [UIColor redColor];
    LoginButtonView *loginFootView = [LoginButtonView loginButtonView];
    [loginFootView.loginButton setTitle:@"确定" forState:UIControlStateNormal];
    [loginFootView.loginButton addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:loginFootView];
    [loginFootView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(footView.mas_top);
        make.leading.equalTo(footView.mas_leading);
        make.trailing.equalTo(footView.mas_trailing);
        make.bottom.equalTo(footView.mas_bottom);
    }];
    registerTableView.tableFooterView = footView;
    
    [self.view addSubview:registerTableView];
}

-(void) registered {
    
    
    
}
#pragma mark UITableView
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _placeTitleArray.count;
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
                [button setBackgroundImage:[[UIImage imageNamed:@"login_lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
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
                textFieldString = _password ;
            }
                break;
            case 2: {
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [button setBackgroundImage:[[UIImage imageNamed:@"login_lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                textField.leftView = button;
                textField.leftViewMode = UITextFieldViewModeAlways;
                textField.secureTextEntry = YES;
                textFieldString = _confirmPassword ;
            }
                break;
            case 3: {
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [button setBackgroundImage:[[UIImage imageNamed:@"login_lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                textField.leftView = button;
                textField.leftViewMode = UITextFieldViewModeAlways;
                textField.secureTextEntry = YES;
                textFieldString = _yanPassword ;
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
            case 2:
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
                _password = [contextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                break;
            default:
                break;
        }
    };
    loginCell.yanCodeButton.hidden = YES;
    if(indexPath.row == _placeTitleArray.count - 1) {
        loginCell.topLineView.hidden = YES;
          loginCell.yanCodeButton.hidden = NO;
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
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
