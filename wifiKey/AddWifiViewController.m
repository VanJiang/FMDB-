//
//  AddWifiViewController.m
//  wifiKey
//
//  Created by 寒山 on 2018/1/26.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import "AddWifiViewController.h"

@interface AddWifiViewController (){
    NSInteger selectIndex;
    UITextField *wifiNameTextField;
    UITextField *wifiPasswordTextField;
    WiFiListDB *wifiDB;
}

@end

@implementation AddWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新增WiFi密码";
    wifiDB = [[WiFiListDB alloc] init];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    leftView.backgroundColor = [UIColor clearColor];
    
    wifiNameTextField=[[UITextField alloc]init];
    wifiNameTextField.font=FONT_BOLD(12);
    wifiNameTextField.backgroundColor=kWhiteColor;
    wifiNameTextField.layer.masksToBounds=YES;
    wifiNameTextField.layer.cornerRadius=5.0;
    wifiNameTextField.layer.borderWidth=1;
    wifiNameTextField.layer.borderColor=RGBA_COLOR(93,157,255, 1.0).CGColor;
    wifiNameTextField.placeholder=@"点击输入WiFi热点名称";
    wifiNameTextField.leftView=leftView;
    wifiNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:wifiNameTextField];
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    leftView2.backgroundColor = [UIColor clearColor];
    
    wifiPasswordTextField=[[UITextField alloc]init];
    wifiPasswordTextField.font=FONT_BOLD(12);
    wifiPasswordTextField.backgroundColor=kWhiteColor;
    wifiPasswordTextField.layer.masksToBounds=YES;
    wifiPasswordTextField.layer.cornerRadius=5.0;
    wifiPasswordTextField.layer.borderWidth=1;
    wifiPasswordTextField.layer.borderColor=RGBA_COLOR(93,157,255, 1.0).CGColor;
    wifiPasswordTextField.placeholder=@"请输入WiFi密码";
    wifiPasswordTextField.leftView=leftView2;
    wifiPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:wifiPasswordTextField];
    
    
    
    UIButton *createButton=[[UIButton alloc]init];
    [createButton setImage:[UIImage imageNamed:@"creatPassword"] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(creatPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createButton];
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"6位",@"8位",@"10位",@"12位",@"14位",@"16位",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
  
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.tintColor = RGBA_COLOR(93,157,255, 1.0);
    // 有基本四种样式
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    selectIndex=8;
    
    
    UIButton *comfireButton=[[UIButton alloc]init];
    [comfireButton setImage:[UIImage imageNamed:@"comfird"] forState:UIControlStateNormal];
    [comfireButton addTarget:self action:@selector(creatWiFiAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:comfireButton];
    
    
    [wifiNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
        make.right.equalTo(self.view).offset(-38);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@30);
    }];
    
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-38);
        make.top.equalTo(wifiNameTextField.mas_bottom).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@90);
    }];
    
    [wifiPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
        make.right.equalTo(createButton.mas_left).offset(-10);
        make.top.equalTo(wifiNameTextField.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];
  
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
        make.right.equalTo(self.view).offset(-38);
        make.top.equalTo(wifiPasswordTextField.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    [comfireButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(segmentedControl.mas_bottom).offset(15);
        make.height.equalTo(@40);
        make.width.equalTo(@(327*0.8));
    }];
    
    // Do any additional setup after loading the view.
}
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            selectIndex=6;
            break;
        case 1:
            selectIndex=8;
            break;
        case 2:
            selectIndex=10;
            break;
        case 3:
            selectIndex=12;
            break;
        case 4:
            selectIndex=14;
            break;
        case 5:
            selectIndex=16;
            break;
        default:
            break;
    }
    //selectIndex=Index;
}
-(void)creatPasswordAction{
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < selectIndex; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    wifiPasswordTextField.text=resultStr;

}
-(void)creatWiFiAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if([wifiNameTextField.text length]==0){
        [ShowMessage showMessage:@"请输入WiFi热点的名称"];
        return;
    }else if([wifiPasswordTextField.text length]==0){
        [ShowMessage showMessage:@"请输入WiFi热点的密码"];
        return;
    }
    WiFiInfoModel *infomodel=[[WiFiInfoModel alloc]init];
    infomodel.creatTime=[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    infomodel.wifiPassword=wifiPasswordTextField.text;
    infomodel.wifiName=wifiNameTextField.text;
    if([wifiDB addContent:infomodel]){
        [ShowMessage showMessage:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ShowMessage showMessage:@"添加失败"];
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
