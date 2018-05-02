//
//  SMCustomAlertView.h
//  UIWindowDemo
//
//  Created by Yang on 02/05/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelBlock)(void);
typedef void (^ConfirmBlock)(void);

@interface SMCustomAlertView : UIView

@property(nonatomic, copy) CancelBlock cancelblock;
@property(nonatomic, copy) ConfirmBlock confirmblock;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title alertMessage:(NSString *)msg confirmBlock:(void (^)(void))confirmBlock cancelBlock: (void (^)(void))cancelBlock;

-(void)show;

-(void)hide;


@end
