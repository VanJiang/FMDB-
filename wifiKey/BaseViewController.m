//
//  BaseViewController.m
//  CheKu
//
//  Created by JIMU on 15/3/27.
//  Copyright (c) 2015年 puxiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor =RGBA_COLOR(236,236,236, 1.0);

//    self.navigationBar.tintColor = kWhiteColor.CGColor;
//    self.navigationBar.barTintColor = RGBA_COLOR(93,157,255, 1.0).CGColor;

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)]];
    
    // Do any additional setup after loading the view.
}

- (void)backButtonAction
{
    if (_type == ViewControllerJumpTypePresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
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
