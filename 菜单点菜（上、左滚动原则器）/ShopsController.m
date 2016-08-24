//
//  ShopsController.m
//  PaoFan
//
//  Created by 王忠良 on 16/8/22.
//  Copyright © 2016年 王忠良. All rights reserved.
//

#import "ShopsController.h"
#import "FeiLeiView.h"
#import "NavigationView.h"
#import "GoodsCell.h"
#import "GoodsItem.h"
#import "GoodsDetailController.h"

@interface ShopsController ()<UIScrollViewDelegate,FenLeiDelegate,UITableViewDelegate,UITableViewDataSource,GoodsCellDelegate>
@property (nonatomic, strong) UIScrollView * baseScrollView;//底层滑动视图
@property (nonatomic, strong) UIImageView * headerView;
@property (nonatomic, strong) NavigationView * navigationView;//选择视图
@property (nonatomic, strong) FeiLeiView * flView;//选择视图
@property (nonatomic, strong) NSMutableArray * dataSource;//数据源
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ShopsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithRightButtonItemImage:nil andLeftButtonItemImage:[UIImage imageNamed:@"nav_icon_back_"]];
    
    [self createBaseScrollView];
    [self createHeaderView];
    [self createNavigationView];
    [self createFenLeiView];
    [self createButtomView];
    [self createUITableView];
}

-(NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
        for(int i = 0; i < 8; i++)
        {
            GoodsItem * goodsItem = [[GoodsItem alloc] init];
            goodsItem.goodsImage = @"sjdp_image";
            goodsItem.goodsName = @"干煸荷兰豆";
            goodsItem.goodsPrice = @"23.00";
            goodsItem.assisNum = @"45";
            goodsItem.numOfMonth = @"123";
            [_dataSource addObject:goodsItem];
        }
    }
    return _dataSource;
}

//创建底层的滑动视图
-(void)createBaseScrollView
{
    UIScrollView * baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64 -52)];
    baseScrollView.delegate = self;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.contentSize = CGSizeMake(0, kScreenH - 64 + 1 -52);
    self.baseScrollView = baseScrollView;
    [self.view addSubview:baseScrollView];
}

//头视图
-(void)createHeaderView
{
    UIImage * image = [UIImage imageNamed:@"bg_sjdp"];
    UIImageView * headerView = [[UIImageView alloc] initWithImage:image];
    headerView.frame = CGRectMake(0, 0, kScreenW, image.size.height);
    self.headerView = headerView;
    headerView.userInteractionEnabled = YES;
    [self.baseScrollView addSubview:headerView];
    
    //店铺图片
    UIImageView * shopsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_qq"]];
    [headerView addSubview:shopsImage];
    [shopsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(28);
        make.left.equalTo(headerView.mas_left).offset(25);
    }];
    
    //店铺名称
    UILabel * shopsName = [[UILabel alloc] init];
    shopsName.textColor = [UIColor whiteColor];
    shopsName.text = @"店铺名称";
    shopsName.textAlignment = NSTextAlignmentCenter;
    shopsName.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [headerView addSubview:shopsName];
    [shopsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopsImage.mas_top).offset(15);
        make.left.equalTo(shopsImage.mas_right).offset(15);
    }];
    
    //店铺公告
    UILabel * shopsNotice = [[UILabel alloc] init];
    shopsNotice.textColor = [UIColor whiteColor];
    shopsNotice.text = @"今天店铺刚开张,所有的商品全都半价";
    shopsNotice.textAlignment = NSTextAlignmentLeft;
    shopsNotice.font = [UIFont systemFontOfSize:14];
    shopsNotice.numberOfLines = 0;
    [headerView addSubview:shopsNotice];
    [shopsNotice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopsName.mas_bottom).offset(15);
        make.left.equalTo(shopsName.mas_left);
        make.width.offset(150);
    }];
    
    //收藏
    UIButton * collect = [UIButton buttonWithType:UIButtonTypeCustom];
    [collect setImage:[UIImage imageNamed:@"red_hart"] forState:UIControlStateNormal];
    [collect setTitle:@"收藏" forState:UIControlStateNormal];
    collect.titleLabel.font = [UIFont systemFontOfSize:14];
    [collect setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [collect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headerView addSubview:collect];
    [collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right).offset(-35);
        make.top.equalTo(shopsNotice.mas_top);
    }];
    
    //线
    UIImageView * line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_sjdp"]];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headerView.mas_bottom).offset(-35);
        make.left.equalTo(headerView.mas_left).offset(35);
        make.right.equalTo(headerView.mas_right).offset(-35);
    }];
}


-(void)createNavigationView
{
    NSArray * arr = @[@"点菜",@"评价",@"商家"];
    self.navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, self.headerView.y + self.headerView.height, kScreenW, 50) andTitles:arr andTitleFont:16];
    self.navigationView.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:self.navigationView];
}

//创建分类视图
-(void)createFenLeiView
{
    NSArray * arr = @[@"热销",@"折扣",@"主食",@"饮料",@"甜品",@"酒水"];
    self.flView = [[FeiLeiView alloc] initWithFrame:CGRectMake(0, self.headerView.height + self.navigationView.height, 116, kScreenH - 64 - self.navigationView.height - self.headerView.height - 52) andTitles:arr];
    self.flView.delegate = self;
    [self.baseScrollView addSubview:self.flView];
}

//创建商品视图
-(void)createUITableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.flView.width, self.headerView.height + self.navigationView.height, kScreenW - self.flView.width, kScreenH - 64 - self.navigationView.height - self.headerView.height - 52) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    self.tableView = tableView;
    [self.baseScrollView addSubview:tableView];
}

//创建购物车商品数量和多少钱起送
-(void)createButtomView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - 52 -64, kScreenW, 52)];
    [self.view addSubview:view];
    
    UIButton * gwc = [UIButton buttonWithType:UIButtonTypeCustom];
    [gwc setImage:[UIImage imageNamed:@"gucspsl"] forState:UIControlStateNormal];
    [view addSubview:gwc];
    [gwc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top);
        make.left.equalTo(view.mas_left);
    }];
    
    UIButton * qsPrice = [UIButton buttonWithType:UIButtonTypeCustom];
    [qsPrice setImage:[UIImage imageNamed:@"dsqqs"] forState:UIControlStateNormal];
    [view addSubview:qsPrice];
    [qsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gwc.mas_top);
        make.left.equalTo(gwc.mas_right);
    }];
}

//返回按钮的点击事件
-(void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isEqual:self.baseScrollView])
    {
        if(scrollView.contentOffset.y > 10)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.baseScrollView.frame = CGRectMake(0, -self.headerView.height, kScreenH, kScreenH - 64 + self.headerView.height);
                self.baseScrollView.contentSize = CGSizeMake(0, kScreenH - 64 + 1 + self.headerView.height);
                self.flView.frame = CGRectMake(0, self.headerView.height + self.navigationView.height, 116, kScreenH - 64 - self.navigationView.height - 52);
                self.flView.baseScrollView.frame = CGRectMake(0, 0, self.flView.width, self.flView.height);
                self.tableView.frame = CGRectMake(self.flView.width, self.headerView.height + self.navigationView.height, kScreenW - self.flView.width, kScreenH - 64 - self.navigationView.height - 52);
            }];
        }
        if(scrollView.contentOffset.y < -10)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.baseScrollView.frame = CGRectMake(0, 0, kScreenH, kScreenH - 64 - 52);
                self.baseScrollView.contentSize = CGSizeMake(0, kScreenH - 64 + 1 - 52);
                self.flView.frame = CGRectMake(0, self.headerView.height + self.navigationView.height, 116, kScreenH - 64 - self.navigationView.height - 52 - self.headerView.height);
                self.flView.baseScrollView.frame = CGRectMake(0, 0, self.flView.width, self.flView.height);
                self.tableView.frame = CGRectMake(self.flView.width, self.headerView.height + self.navigationView.height, kScreenW - self.flView.width, kScreenH - 64 - self.navigationView.height - self.headerView.height - 52);
            }];
        }
    }
}


#pragma mark - FenLeiDelegate
-(void)FenLeiBtnClick:(NSInteger)tag
{
    switch (tag - 100) {
        case 0:
            MyLog(@"热销");
            break;
        case 1:
            MyLog(@"折扣");
            break;
        case 2:
            MyLog(@"主食");
            break;
        case 3:
            MyLog(@"饮料");
            break;
        case 4:
            MyLog(@"甜品");
            break;
        case 5:
            MyLog(@"酒水");
            break;
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsItem * item = self.dataSource[indexPath.row];
    GoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GOODS"];
    if(!cell)
    {
        cell = [[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GOODS"];
    }
    cell.delegate = self;
    cell.goodsImage.image = [UIImage imageNamed:item.goodsImage];
    cell.goodsName.text = item.goodsName;
    cell.goodsPrice.text = item.goodsPrice;
    cell.numOfMonth.text = item.numOfMonth;
    cell.assistNum.text = item.assisNum;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsItem * item = self.dataSource[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    GoodsDetailController * goodsDetailVC = [[GoodsDetailController alloc] init];
    goodsDetailVC.titleStr = item.goodsName;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

#pragma mark - GoodsCellDelegate
-(void)goodsCellBtnsClick:(UIButton *)sender
{
    GoodsCell * cell = (GoodsCell *)(sender.superview.superview);
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
    MyLog(@"%ld-----%ld",path.row,sender.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
