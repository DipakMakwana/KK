//
//  CommonFile.h
//  TCP
//
//  Created by I-MAC on 9/20/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import "Constant.h"


@protocol buttonClickDelegate <NSObject>

@optional

-(void)addButtonClicked:(id)sender string:(NSString *)string;
-(void)cancelButtonClicked:(id)sender;

@end
@interface CommonFile : NSObject <UITextFieldDelegate,UIAlertViewDelegate>
{
     id<buttonClickDelegate> delegate;
}


@property (nonatomic,retain) UIView *parentView;
@property (nonatomic,retain) UITextField *txt;
@property (nonatomic,retain) UIView *viewLoader;
@property (nonatomic,retain) UIProgressView *progress;
@property (nonatomic,retain) id  delegate;

-(void)removeViewWithAnimation:(UIView *)view x:(int)x y:(int)y w:(int)w h:(int)h delay:(int)delay;
-(void)initiateLoaderWithMessage : (NSString *)str inView : (UIView *)view;

-(UIButton *) ConfigureButton:(CGRect)frame tag:(int)tag type :(int)type title:(NSString *)title  tColor:(UIColor *)tColor bColor:(UIColor *)bColor imageName:(NSString *)imageName methodName:(SEL)methodName;
-(void)HideLoader;

-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize fontName:(NSString *)fontName;


-(UIView *)insertValueAlertViewFrame:(CGRect)frame lblTitle:(NSString *)lblTitle placeHolderText:(NSString *)placeHolderText addTag:(int)addTag;


@end
