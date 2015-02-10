//
//  AppDelegate.h
//  KGEnglish
//
//  Created by I-MAC on 4/9/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/* Global Method */
-(void)setBackgroundColorForViewController:(UIViewController *)viewController bColor:(UIColor *)bColor;

-(void)saveImage:(UIView *)parentView;
@end