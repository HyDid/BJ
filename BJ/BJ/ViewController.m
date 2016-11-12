//
//  ViewController.m
//  BJ
//
//  Created by LiHongYu on 2016/11/11.
//  Copyright © 2016年 LiHongYu. All rights reserved.
//

#import "ViewController.h"
#import "DetailedViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DetailedViewControllerDelegate>

@property (nonatomic,strong)UITableView *customTableview;
@property (copy,nonatomic) NSMutableArray *textArray;
@property (copy,nonatomic) NSMutableArray *datetextArray;
@property (assign,nonatomic) BOOL Quanxuan;

@property (nonatomic,strong)UIView *detailedView;
@property (strong,nonatomic)UITextView *textView;

@end

static int HeadH = 60;
static int ButtonH = 40;
@implementation ViewController

-(NSMutableArray *)textArray{
    if (_textArray == nil) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}
-(NSMutableArray *)datetextArray{
    if (_datetextArray == nil) {
        _datetextArray = [NSMutableArray array];
    }
    return _datetextArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableview];
    _Quanxuan = NO;
}

-(void)addTableview{
    UITableView *customTableview = [[UITableView alloc]init];
    customTableview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    customTableview.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
//    customTableview.separatorStyle = NO;
    customTableview.bounces = NO;
    customTableview.delegate = self;
    customTableview.dataSource = self;
    self.customTableview = customTableview;
    [self.view addSubview:customTableview];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeadH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc]init];
    headview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeadH);
    headview.backgroundColor = [UIColor colorWithRed:87/255.0 green:190/255.0 blue:177/255.0 alpha:1.0];
    UIButton *addDetailedButton = [[UIButton alloc]init];
    addDetailedButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-ButtonH*2, HeadH-ButtonH, ButtonH*2, ButtonH);
    [addDetailedButton setTitle:@"添加" forState:UIControlStateNormal];
    addDetailedButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addDetailedButton addTarget:self action:@selector(addDetailedButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *selectButton = [[UIButton alloc]init];
    selectButton.frame = CGRectMake(0, HeadH-ButtonH, ButtonH*2, ButtonH);
    [selectButton setTitle:@"全选" forState:UIControlStateNormal];
    selectButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectButton addTarget:self action:@selector(selectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headview addSubview:selectButton];
    [headview addSubview:addDetailedButton];
    
    return headview;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];;
    
    cell.textLabel.text = self.textArray[indexPath.row];
    cell.detailTextLabel.text = self.datetextArray[indexPath.row];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.customTableview  cellForRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIView *detailedView = [[UIView alloc]init];
    detailedView.frame = self.customTableview.frame;
    detailedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(ButtonH/2, HeadH+ButtonH/2, [UIScreen mainScreen].bounds.size.width-ButtonH, [UIScreen mainScreen].bounds.size.height/3);
    textView.text = cell.textLabel.text;
    self.textView = textView;
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(ButtonH/2, HeadH+ButtonH/2+[UIScreen mainScreen].bounds.size.height/3, [UIScreen mainScreen].bounds.size.width-ButtonH, [UIScreen mainScreen].bounds.size.height/13);
    btn.backgroundColor = [UIColor colorWithRed:87/255.0 green:190/255.0 blue:177/255.0 alpha:1.0];
    [btn setTitle:@"返回/修改" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.tag = indexPath.row;
    NSLog(@"%ld",(long)btn.tag);
    [btn addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
    [detailedView addSubview:btn];
    [detailedView addSubview:textView];
    self.detailedView = detailedView;
    [self.customTableview addSubview:detailedView];
    

    }
-(void)DetailedViewController:(DetailedViewController *)addVc Didaddtext:(NSString *)text Didadddatetext:(NSString *)datetext{
    
    [self.textArray addObject:text];
    [self.datetextArray addObject:datetext];
    [self.customTableview reloadData];
}


-(void)selectButtonAction{
    
    
    if (_Quanxuan) {
        self.customTableview.editing = YES;
    }else{
        self.customTableview.editing = NO;
    }
    _Quanxuan = !_Quanxuan;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        [self.textArray removeObject:self.textArray[indexPath.row]];
        [self.datetextArray removeObject:self.textArray[indexPath.row]];
        [self.customTableview reloadData];
        
    }
    
}



-(void)addDetailedButtonAction{
    DetailedViewController *Detaile = [[DetailedViewController alloc]init];
    Detaile.delegate = self;
    [self presentViewController:Detaile animated:YES completion:nil];
    self.Quanxuan = NO;
    [self selectButtonAction];

}

-(void)removeAction:(UIButton *)btn{
    

    [self.textArray replaceObjectAtIndex:btn.tag withObject:self.textView.text];
    [self.customTableview reloadData];
    
    [btn.superview removeFromSuperview];
    
}


@end
