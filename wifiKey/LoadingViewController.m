//
//  LoadingViewController.m
//  wifiKey
//
//  Created by 寒山 on 2018/1/26.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import "LoadingViewController.h"
#import "GiFHUD.h"
#import "WifiListViewController.h"
@interface LoadingViewController (){
    GiFHUD* hud;
}
@end

@implementation LoadingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBar.hidden = YES;
}
-(void)gotoNextView{
    [hud dismiss];
    WifiListViewController *viewCotrol=[[WifiListViewController alloc]init];
    [self.navigationController pushViewController:viewCotrol animated:YES];
    
 
    
}
-(void)searchWifiAction{
    if (hud == nil) {
        hud = [[GiFHUD alloc] initWithView:self.view];
    }
    [hud show];
    
    [self performSelector:@selector(gotoNextView) withObject:nil afterDelay:10];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =RGBA_COLOR(236,236,236, 1.0);
    
    
    UIButton *createButton=[[UIButton alloc]init];
    [createButton setTitle:@"搜索"   forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(searchWifiAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createButton];
    

    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-60);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    // Do any additional setup after loading the view.
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
