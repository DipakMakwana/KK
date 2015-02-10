//
//  Database.h
//  PEnglish
//
//  Created by I-MAC on 12/5/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <sqlite3.h>

@interface Database : NSObject
{
     sqlite3 *database;
     sqlite3_stmt    *statement;
}
@property (nonatomic,strong) NSString *databasePath;
@property (nonatomic,strong) NSMutableArray *tempArray;


/* Insert  Data Method  */
-(BOOL)insertDataInCategory:(NSString *)string;
-(BOOL)insertDataInWordTable:(NSString *)string catId:(int)catID;

/* Retrive Data Method */
-(NSMutableArray *)getImagesforAlphabet;
-(NSMutableArray *)getWordsFromDatabase;
-(NSMutableArray *)getVowelsFromDatabase;
-(NSMutableArray *)getCategory;
-(NSMutableArray *)getImagesforColor;
-(NSMutableArray *)getImagesforAnimal;
-(NSMutableArray *)getImagesOfLightAndHeavyObj;
-(NSMutableArray *)getImagesOfThinAndThickObj;
-(NSMutableArray *)getTransportImages;
-(NSMutableArray *)getOppositeObjectImages;
-(NSMutableArray *)getImagesforBirdsAndAnimalAndIsBird:(BOOL)isBird;
-(NSMutableArray *)getFlowerImages;

-(NSMutableArray *)getWordsByCatID:(int)catId;
-(NSMutableArray *)getImagesforAnimalYoungOnce;

/*Delete Data Method */
-(BOOL)deleteCategoryByCatId:(int)catID;
-(BOOL)deleteWordByCatId:(int)catID;
-(BOOL)deleteWordByWordId:(int)wordID;

@end
