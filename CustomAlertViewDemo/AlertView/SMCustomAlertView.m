//
//  SMCustomAlertView.m
//  UIWindowDemo
//
//  Created by Yang on 02/05/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import "SMCustomAlertView.h"
#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间

@interface SMCustomAlertView()

@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *confirmBtn;

@end

@implementation SMCustomAlertView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title alertMessage:(NSString *)msg confirmBlock:(void (^)(void))confirmBlock cancelBlock: (void (^)(void))cancelBlock{
    if (self=[super initWithFrame:frame]) {
        [self customUIWith:frame title:title message:msg];
        _cancelblock = cancelBlock;
        _confirmblock = confirmBlock;
        
    }
    return self;
}

-(void)customUIWith:(CGRect)frame title:(NSString *)title message:(NSString*)msg{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
//    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    backgroundView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    backgroundView.image = [UIImage imageNamed:@"alertbg"];
    
    [self addSubview:backgroundView];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 190, 20)];
    _title.textColor = [UIColor blackColor];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:15];
    [self addSubview:_title];
    
    _content = [[UILabel alloc]initWithFrame:CGRectMake(12, 40, 228, 70)];
    _content.numberOfLines = 0;
    _content.textAlignment = NSTextAlignmentLeft;
    _content.textColor = [UIColor blackColor];
    _content.font = [UIFont systemFontOfSize:15];
    [self addSubview:_content];
    
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setBackgroundImage:[UIImage imageNamed:@"alertCanclebtn"] forState:UIControlStateNormal];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _cancleBtn.frame = CGRectMake(20, 120, 70, 30);
    [self addSubview:_cancleBtn];
    [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"alertSuerbtn"] forState:UIControlStateNormal];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.frame = CGRectMake(150, 120, 70, 30);
    [self addSubview:_confirmBtn];
    [_confirmBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _title.text = title;
    _content.text = msg;
}

-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    UIView *oldView = [keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    
    UIView *frontView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    frontView.tag = TagValue;
    frontView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [frontView addGestureRecognizer:tap];
    frontView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [keyWindow addSubview:frontView];
    
    [keyWindow addSubview:self];
    self.center = keyWindow.center;//此处已可以显示view了
    ////以下为动画效果：先让view设为透明，size缩小为原来的0.1倍，然后通过动画恢复原有size，并设为不透明
    self.alpha = 0;//让view设为透明
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);//size缩小为原来的0.1倍
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity; //size设为原有的大小
        self.alpha = 1;//设为不透明
    }];
}


//弹出隐藏
-(void)hide{
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgview) {
                [bgview removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
}

-(void)cancleBtnClick{
    [self hide];
    if (_cancelblock) {
        _cancelblock();
    }
}
-(void)sureBtnClick{
    [self hide];
    if (_confirmblock) {
        _confirmblock();
    }
}


@end
