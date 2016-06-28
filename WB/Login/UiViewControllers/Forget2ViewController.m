//
//  Forget2ViewController.m
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "Forget2ViewController.h"
#import "LoginButtonView.h"
#import "LoginTableViewCell.h"

@interface Forget2ViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_forget2TableView;
    NSArray *_placeTitleArray;
    NSString *_userName;
    NSString *_passWord;
}

@end

@implementation Forget2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placeTitleArray = [NSArray arrayWithObjects:@"设置新密码",@"重复新密码", nil];
    // Do any additional setup after loading the view from its nib.
    _forget2TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _forget2TableView.dataSource = self;
    _forget2TableView.delegate = self;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    footView.backgroundColor = [UIColor redColor];
    LoginButtonView *loginFootView = [LoginButtonView loginButtonView];
    [loginFootView.loginButton setTitle:@"确定" forState:UIControlStateNormal];
    [loginFootView.loginButton addTarget:self action:@selector(confirmed) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:loginFootView];
    [loginFootView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(footView.mas_top);
        make.leading.equalTo(footView.mas_leading);
        make.trailing.equalTo(footView.mas_trailing);
        make.bottom.equalTo(footView.mas_bottom);
    }];
    _forget2TableView.tableFooterView = footView;
    
    [self.view addSubview:_forget2TableView];
}

-(void) confirmed {
    
    
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
