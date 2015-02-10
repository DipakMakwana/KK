//
//  SingletonClass.h
//  PEnglish
//
//  Created by I-MAC on 1/23/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

@property (nonatomic,readwrite) int viewW;
@property (nonatomic,readwrite) int viewH;
@property(nonatomic,assign) BOOL isIpad;

@property (nonatomic,retain) UIViewController *vc ;

/* Singleton method */

+(id)sharedManager;

-(NSString *)checkNullString : (NSString *)str;

-(float)getSystemVersion;

-(BOOL)isDeviceLandscape;

-(CGRect)pageImageFrame;

-(CGRect)labelFrame;

-(CGRect)carsoulFrame;

-(void)addKeyboardNotificationInVC:(UIViewController *)vc;

@end
