//
//  WifiListViewController.m
//  wifiKey
//
//  Created by 寒山 on 2018/1/26.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import "WifiListViewController.h"
#import "WifiListTableViewCell.h"
#import "AddWifiViewController.h"

@interface WifiListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataSoure;
    WiFiListDB *wifiDB;
}
@property(nonatomic,retain)UITableView *tableView;

@end
static NSString *indenfity=@"WifiListTableViewCell";
@implementation WifiListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dataSoure = [wifiDB getAllContent];
    [self.tableView reloadData];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"WIFI万能钥匙";
    //self.navigationItem.leftBarButtonItems = nil;
    dataSoure=[NSMutableArray array];
    
    NSString* dataPath = [JRUtility getPathWithinDocumentDir:CONTENTDBNAME];
    
    //判断是否存在数据表
    if (!([dataPath length] > 0 && [[NSFileManager defaultManager] fileExistsAtPath:dataPath])) {
        //创建数据表
        wifiDB = [[WiFiListDB alloc] init];
        [wifiDB createContentTable];
    }
    else {
        wifiDB = [[WiFiListDB alloc] init];
    }
   
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,UIScreenW, UIScreenH-64)];
    //  self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[WifiListTableViewCell class] forCellReuseIdentifier:indenfity];
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundColor:[UIColor clearColor]];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addWifiAction) forControlEvents:UIControlEventTouchUpInside];
    [addBtn sizeToFit];
    UIBarButtonItem* saveBtn = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    NSArray* rightButtons = [NSArray arrayWithObject:saveBtn];
    self.navigationItem.rightBarButtonItems = rightButtons;
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSoure.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  77;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WifiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfity];
    cell.selectedBackgroundView.backgroundColor =kClearColor;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WiFiInfoModel *infoModel=dataSoure[indexPath.row];
    [cell setInfoModel:infoModel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)addWifiAction{
    AddWifiViewController *viewControl=[[AddWifiViewController alloc]init];
    [self.navigationController pushViewController:viewControl animated:YES];
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
