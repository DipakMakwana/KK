//
//  CustomAlert.m
//  TCP
//
//  Created by Indies on 09/09/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "CustomAlert.h"

@implementation CustomAlert


+(void)alertTitle:(NSString *) alertTitle alertMessage :(NSString *)alertMessage delegate :(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle alertTag:(int)alertTag
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    alert.tag =alertTag;
    [alert show];

}
@end
