//
//  NavigationView.h
//  PaoFan
//
//  Created by 王忠良 on 16/8/12.
//  Copyright © 2016年 王忠良. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationViewDelegate <NSObject>

-(void)navigationViewButtonClickWithIndex:(NSInteger)index;

@end

@interface NavigationView : UIView

@property (nonatomic, copy) NSArray * titles;//名称数组

@property (nonatomic, assign) NSInteger fontSize;//字体大小

@property (nonatomic, copy) NSString * norColorStr;//默认下的字体颜色

@property (nonatomic, copy) NSString * selColorStr;//选中状态下的字体颜色

@property (nonatomic, weak) id<NavigationViewDelegate>delegate;
//创建一个导航视图
-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andTitleFont:(NSInteger)fontSize;

-(void)btnSelectedWithTag:(NSInteger)tag;
@end
