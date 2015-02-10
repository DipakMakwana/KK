//
//  WordDictionaryVC.h
//  PEnglish
//
//  Created by I-MAC on 12/12/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordVC.h"
@interface WordDictionaryVC : UIViewController
{
    int catID;
    int selectedIndex;
      
}

@property (nonatomic,weak) IBOutlet UITableView *tableCategory;
@property (nonatomic,weak) IBOutlet UITableView *tableWords;
@property (nonatomic,retain) UIView *customView;
@property (nonatomic,weak) IBOutlet UIButton *btnRemoveCat;
@property (nonatomic,weak) IBOutlet UIButton *btnRemoveWord;
@property (nonatomic,retain) UIImageView *coverImage;
@property (nonatomic,retain) CommonFile *objCommon;
@property (nonatomic,retain) NSMutableArray *catArray;
@property (nonatomic,retain) NSMutableArray *wordArray;

@end
