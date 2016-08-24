//
//  FeiLeiView.m
//  PaoFan
//
//  Created by 王忠良 on 16/8/8.
//  Copyright © 2016年 王忠良. All rights reserved.
//

#import "FeiLeiView.h"

@interface FeiLeiView()
@property (nonatomic, strong) NSMutableArray * allBtns;//所有的按钮
@end

@implementation FeiLeiView

//懒加载所有的按钮
-(NSMutableArray *)allBtns
{
    if(_allBtns == nil)
    {
        _allBtns = [NSMutableArray array];
    }
    return _allBtns;
}


//通过图片数组创建选择视图
-(instancetype)initWithFrame:(CGRect)frame andNorImages:(NSArray *)norImage andSelImage:(NSArray *)selImage
{
    if(self = [super initWithFrame:frame])
    {
        _norImages = norImage;
        _selImages = selImage;
        [self createAllBtns];
    }
    return self;
}

//创建所有的按钮
-(void)createAllBtns
{
    //底层视图
    UIScrollView * baseScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:baseScrollView];
    
    //按钮的高度
    CGFloat btnHeight = (self.height - 20) / 10;
    if(_selImages.count < 9)
    {
        baseScrollView.contentSize = CGSizeMake(0, self.height);
    }
    else
    {
        baseScrollView.contentSize = CGSizeMake(0, (btnHeight + 1)*_selImages.count);
    }
    UIImage * image = [UIImage imageNamed:@"bg_btn_nor3_"];
    CGSize imageSize = image.size;
    //所有的按钮
    for(int i = 0; i< 9; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i * (btnHeight + 1), imageSize.width, imageSize.height);
        if(i < _selImages.count)
        {
            [btn setImage:[UIImage imageNamed:_norImages[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:_selImages[i]] forState:UIControlStateSelected];
        }
        else
        {
            btn.enabled = NO;
            btn.backgroundColor = [UIColor whiteColor];
        }
        btn.tag = 100+ i;
        if(btn.tag == 100)
        {
            btn.selected = YES;
        }
        [self.allBtns addObject:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [baseScrollView addSubview:btn];
    }
}




////通过文字数组创建选择视图
-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    if(self = [super initWithFrame:frame])
    {
        _allBtns = [NSMutableArray array];
        self.titles = titles;
        [self compareUI];
    }
    return self;
}

-(void)compareUI
{
    //底层视图
    self.baseScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.baseScrollView.backgroundColor = [UIColor clearColor];
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.baseScrollView];
    
    for (int i = 0; i < self.titles.count; i ++)
    {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i * 61, self.width, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.baseScrollView addSubview:lineView];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 1 + i * 61, self.baseScrollView.width, 60);
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"5C5C5C"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"EBEBEB"]];
        btn.tag = 100 + i;
        if(i == 0)
        {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_allBtns addObject:btn];
        [self.baseScrollView addSubview:btn];
    }
    self.baseScrollView.contentSize = CGSizeMake(0, 61 * self.titles.count + 1);
}

-(void)btnClick:(UIButton *)sender
{
    for(UIButton * btn in self.allBtns)
    {
        btn.selected = NO;
        btn.userInteractionEnabled = YES;
    }
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    if ([self.delegate conformsToProtocol:@protocol(FenLeiDelegate)])
    {
        [self.delegate FenLeiBtnClick:sender.tag];
    }
}


-(void)titleBtnClick:(UIButton *)sender
{
    for(UIButton * btn in self.allBtns)
    {
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithHexString:@"EBEBEB"]];
        btn.userInteractionEnabled = YES;
    }
    sender.selected = YES;
    [sender setBackgroundColor:[UIColor whiteColor]];
    sender.userInteractionEnabled = NO;
    if ([self.delegate conformsToProtocol:@protocol(FenLeiDelegate)])
    {
        [self.delegate FenLeiBtnClick:sender.tag];
    }
}
@end
