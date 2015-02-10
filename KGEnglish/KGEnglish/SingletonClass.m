//
//  SingletonClass.m
//  PEnglish
//
//  Created by I-MAC on 1/23/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import "SingletonClass.h"

static SingletonClass *sharedMyManager = nil;

@implementation SingletonClass


+(id)sharedManager
{
    static SingletonClass *sharedMyManager = nil ;
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc]init];
    });
    return sharedMyManager;
}

#pragma mark Singleton Methods

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    if (self = [super init]) {
       
        self.viewW = [UIScreen mainScreen].bounds.size.width;
        self.viewH = [UIScreen mainScreen].bounds.size.height;
        self.isIpad = [self isiPadMethod];
    }
    return self;
}

-(BOOL) isiPadMethod {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}
-(NSString *)checkNullString : (NSString *)str
{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqualToString:@"<null>"]  || [str isEqualToString:@"(null)"] || [str isEqualToString:@""] || str.length == 0) {
        return @"";
    }
    return str;
}
-(float)getSystemVersion
{
    float iosVersion = 0.0 ;
    NSString * sysVersion = [[UIDevice currentDevice] systemVersion];
    if ([sysVersion compare:@"4.0" options:NSNumericSearch] == NSOrderedSame)
    {
        iosVersion = 4 ;
    }
    else if ([sysVersion compare:@"5.0" options:NSNumericSearch] == NSOrderedSame)
    {
        iosVersion = 5 ;
    }
    else if ([sysVersion compare:@"6.0" options:NSNumericSearch] == NSOrderedSame)
    {
        iosVersion = 6 ;
    }
    else if ([sysVersion compare:@"7.0" options:NSNumericSearch] == NSOrderedSame)
    {
        iosVersion = 7;
    }
    return  iosVersion ;

}
-(BOOL)isDeviceLandscape
{
    BOOL isLandscape;
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if ((orientation  == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight))
    {
        isLandscape = TRUE;
    }
    else
    {
        isLandscape = FALSE;
    }
    return isLandscape;
}
-(CGRect)carsoulFrame
{
    CGRect carouselFrame;
    if (isIpad)
    {
        carouselFrame = CGRectMake(0, 0, viewW, viewH);
    }
    return carouselFrame;
}
-(CGRect)labelFrame
{
    CGRect lblFrame ;
    BOOL isLandscape = [[SingletonClass sharedManager] isDeviceLandscape];
    
    if (isLandscape)
    {
        lblFrame = CGRectMake(80, 0, 400, 50);
    }
    else
    {
        lblFrame = CGRectMake(80, 0, 300, 50);
    }
    if (isIpad)
    {
        lblFrame = CGRectMake(150, 10, 700, 60);
    }
    return lblFrame;
}
-(CGRect)pageImageFrame
{
    CGRect  pageImageFrame ;
   
    if (isIpad)
    {
        pageImageFrame = CGRectMake(0, 0, 200, 600);
    }
    return pageImageFrame;
}
-(void)addKeyboardNotificationInVC:(UIViewController *)vc
{
    self.vc = vc ;

   
    [[NSNotificationCenter defaultCenter] addObserver:vc selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:vc selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
}
#pragma mark
#pragma mark Keyboard Method
#pragma mark

-(void) keyboardShown:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:self.vc];
}

-(void) keyboardHidden:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:self.vc];
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
   
   
}


@end
