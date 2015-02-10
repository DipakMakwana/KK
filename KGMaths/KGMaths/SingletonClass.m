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
    if (self = [super init])
    {
        self.viewW = [UIScreen mainScreen].bounds.size.width;
        self.viewH = [UIScreen mainScreen].bounds.size.height;
        NSLog(@"viewW %d viewH %d",self.viewW,self.viewH);
        self.isIpad = [self isiPadMethod];
    }
    return self;
}

-(BOOL) isiPadMethod
{
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

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
