//
//  DetailedViewController.h
//  BJ
//
//  Created by LiHongYu on 2016/11/11.
//  Copyright © 2016年 LiHongYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailedViewController;
@protocol DetailedViewControllerDelegate <NSObject>
-(void)DetailedViewController:(DetailedViewController *)addVc Didaddtext:(NSString *)text Didadddatetext:(NSString *)datetext;
@end

@interface DetailedViewController : UIViewController
@property (nonatomic,weak)id<DetailedViewControllerDelegate>delegate;

@property (nonatomic,strong)UITextView *textView;
@end
