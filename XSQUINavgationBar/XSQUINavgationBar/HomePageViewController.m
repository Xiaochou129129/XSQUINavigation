//
//  HomePageViewController.m
//  XSQUINavgationBar
//
//  Created by 谢松樵 on 2017/12/6.
//  Copyright © 2017年 谢松樵. All rights reserved.
//

#import "HomePageViewController.h"
#import "UIImage+XSQAlpha.h"

#define SCREEN_HEIGHT                       [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH                        [[UIScreen mainScreen]bounds].size.width

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat offset;
}
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIImageView *bannar;

@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    offset = scrollView.contentOffset.y;
    NSLog(@"%f",offset);
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"title_bg"] imageByApplyingAlpha:(offset / 200)>0.99?0.99:(offset / 200)] forBarMetrics:UIBarMetricsDefault];
    //设置普通颜色
    //[self.navigationController.navigationBar setBackgroundImage:[[UIImage new] imageByApplyingAlpha:(offset / 200)>0.99?0.99:(offset / 200)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableView不偏移设置
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view from its nib.
}



- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.bannar;
        
    }
    return _tableView;
}

- (UIImageView *)bannar{
    if (_bannar == nil) {
        _bannar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tu"]];
        _bannar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }
    return _bannar;
}
#pragma mark tableView deleagate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"1111";
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
