//
//  NavigationView.m
//  PaoFan
//
//  Created by 王忠良 on 16/8/12.
//  Copyright © 2016年 王忠良. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView
{
    UIView * _line;
    NSMutableArray * _allBtns;
}

-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andTitleFont:(NSInteger)fontSize
{
    if(self = [super initWithFrame:frame])
    {
        _titles = titles;
        _fontSize = fontSize;
        _allBtns = [NSMutableArray array];
        
        [self carpareUI];
    }
    return self;
}

//布局
-(void)carpareUI
{
    //按钮下面的橘黄色视图
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 3, 40, 3)];
    view.backgroundColor = [UIColor colorWithHexString:@"FFC670"];
    view.layer.cornerRadius = 5.0f;
    view.layer.masksToBounds = YES;
    _line = view;
    [self addSubview:view];
    for (int i = 0; i < _titles.count; i ++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * self.width / _titles.count, 0, self.width / _titles.count, self.height - 3);
        //btn.backgroundColor = [UIColor cyanColor];
        btn.tag  = 100 + i;
        if(i == 0)
        {
            view.centerX = btn.centerX;
            btn.selected = YES;
        }
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"FF7171"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_allBtns addObject:btn];
    }
    
}

//按钮的点击事件
-(void)btnClick:(UIButton *)sender
{
    for(UIButton * btn in _allBtns)
    {
        btn.selected = NO;
    }
    sender.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
       _line.centerX = sender.centerX;
    }];
    if([self.delegate conformsToProtocol:@protocol(NavigationViewDelegate) ])
    {
        [self.delegate navigationViewButtonClickWithIndex:sender.tag - 100];
    }
}

//滑动的时候调的方法
-(void)btnSelectedWithTag:(NSInteger)tag
{
    UIButton * btn = _allBtns[tag];
    
    for(UIButton * btn in _allBtns)
    {
        btn.selected = NO;
    }
    btn.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _line.centerX = btn.centerX;
    }];
}

@end
