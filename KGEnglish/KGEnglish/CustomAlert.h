//
//  CustomAlert.h
//  TCP
//
//  Created by Indies on 09/09/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomAlert : NSObject

+(void)alertTitle:(NSString *) alertTitle alertMessage :(NSString *)alertMessage delegate :(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle alertTag:(int)alertTag;


@end
