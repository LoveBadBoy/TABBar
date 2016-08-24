//
//  FeiLeiView.h
//  PaoFan
//
//  Created by 王忠良 on 16/8/8.
//  Copyright © 2016年 王忠良. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FenLeiDelegate <NSObject>

-(void)FenLeiBtnClick:(NSInteger)tag;//按钮的点击事件

@end

@interface FeiLeiView : UIView

@property (nonatomic, copy) NSArray * norImages;//默认图片
@property (nonatomic, copy) NSArray * selImages;//选中图片
@property (nonatomic, strong) UIScrollView * baseScrollView;
@property (nonatomic, copy) NSArray * titles;
@property (nonatomic, weak) id<FenLeiDelegate>delegate;


//通过图片数组创建选择视图
-(instancetype)initWithFrame:(CGRect)frame andNorImages:(NSArray *)norImage andSelImage:(NSArray *)selImage;


//通过文字数组创建选择视图
-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

@end
