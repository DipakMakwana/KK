//
//  CountObjectsVC.h
//  PEnglish
//
//  Created by I-MAC on 12/26/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountObjectsVC : UIViewController
{
    int number ;
   
}

@property (nonatomic,weak) IBOutlet UILabel *lblNo;

@property (nonatomic,weak) IBOutlet UITextField *txtAns;

@end
