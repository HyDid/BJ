//
//  DetailedViewController.m
//  BJ
//
//  Created by LiHongYu on 2016/11/11.
//  Copyright © 2016年 LiHongYu. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()
@property (nonatomic,strong)UIView *custemview;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,copy)NSString *dateString;
@end

static int HeadH = 60;
static int ButtonH = 40;

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefault];
    
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    [dateFormatter setDateFormat:@"MM/dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.dateString = dateString;
}

-(void)setDefault{
    UIView *custemview = [[UIView alloc]init];
    custemview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    custemview.backgroundColor = [UIColor whiteColor];
    self.custemview = custemview;
    [self.view addSubview:custemview];
    
    UIView *headview = [[UIView alloc]init];
    headview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeadH);
    headview.backgroundColor = [UIColor colorWithRed:87/255.0 green:190/255.0 blue:177/255.0 alpha:1.0];
    UIButton *addBtn = [[UIButton alloc]init];
    addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-ButtonH*2, HeadH-ButtonH, ButtonH*2, ButtonH);
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.frame = CGRectMake(0, HeadH-ButtonH, ButtonH*2, ButtonH);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headview addSubview:addBtn];
    [headview addSubview:cancelBtn];
    [self.custemview addSubview:headview];
    
    
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(ButtonH/2, HeadH+ButtonH/2, [UIScreen mainScreen].bounds.size.width-ButtonH, [UIScreen mainScreen].bounds.size.height/3);
    self.textView = textView;
    [self.custemview addSubview:textView];
}

-(void)cancelBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addBtnAction{
    [self.delegate DetailedViewController:self Didaddtext:self.textView.text Didadddatetext:self.dateString];
    [self cancelBtnAction];
}

@end
