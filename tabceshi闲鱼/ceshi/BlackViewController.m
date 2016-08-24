//
//  BlackViewController.m
//  ceshi
//
//  Created by 赵宏 on 16/8/22.
//  Copyright © 2016年 赵宏. All rights reserved.
//

#import "BlackViewController.h"
#import "LBHomeViewController.h"
@interface BlackViewController ()

@end

@implementation BlackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;

}
- (IBAction)back:(id)sender {


    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"234");
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
