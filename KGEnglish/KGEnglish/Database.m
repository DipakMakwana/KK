//
//  Database.m
//  PEnglish
//
//  Created by I-MAC on 12/5/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "Database.h"

@implementation Database
-(void)createDatabase
{
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    self.databasePath = [docsDir stringByAppendingPathComponent: DB_ALPHABET];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: self.databasePath ] == NO) {
        const char *dbpath = [self.databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            NSString *str = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT , %@ TEXT ,%@ VARCHAR,%@ VARCHAR,%@ VARCHAR,%@ VARCHAR)",TBL_ALPHABET,FLD_ALPHABET_NAME,FLD_IMAGE_1,FLD_IMAGE_2,FLD_IMAGE_3,FLD_IMAGE_4];
               const char *sql_stmt = [str UTF8String];
            
                if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                    
                }
            sqlite3_close(database);
        }
     }
        NSLog(@"Data base already Created 2 ");
}
#pragma mark 
#pragma mark  Retrive Data From Database
#pragma mark

-(NSMutableArray *)getImagesforAlphabet
{
    [self createDatabase];
     NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_ALPHABET];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getImagesforColor
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_COLOR];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getImagesforAnimalYoungOnce
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_ANIMAL];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getImagesforBirdsAndAnimalAndIsBird:(BOOL)isBird
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@ where isBird=%d",TBL_BIRDS_ANIMAL,isBird];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getImagesforAnimal
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_BIRDS_ANIMAL];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getFlowerImages
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_FLOWER];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getImagesOfLightAndHeavyObj
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_LIGHT_HEAVY];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getImagesOfThinAndThickObj
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_THIN_THICK];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getTransportImages
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_TRANSPORT];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getOppositeObjectImages
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_EQUAL_OPPISITE];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getWordsFromDatabase
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_WORD];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getVowelsFromDatabase
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_VOWEL];
    [self getDataFromQuery:query];
    return self.tempArray;
}

-(NSMutableArray *)getCategory
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@",TBL_CATEGPRY];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSMutableArray *)getWordsByCatID:(int)catId
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat:@"select * from %@ where %@ = %d",TBL_WORD,FLD_CAT_ID,catId];
    [self getDataFromQuery:query];
    return self.tempArray;
}
-(NSString *)getImagePathFromImageName:(NSString *)imageName
{
    [self createDatabase];
    NSArray *dirPaths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *imagePath = [docsDir stringByAppendingPathComponent: imageName];
    return imagePath;
}

#pragma mark
#pragma mark Insertion Method
#pragma mark

-(BOOL)insertDataInCategory:(NSString *)string
{
    [self createDatabase];
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO %@ (%@) VALUES ('%@')",TBL_CATEGPRY,FLD_CAT_NAME,string];
   BOOL isAdded =  [self updateData:insertSQL];
    return  isAdded;
    NSLog(@"isadded = %d",isAdded);
}

-(BOOL)insertDataInWordTable:(NSString *)string catId:(int)catID
{
    [self createDatabase];
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO %@ (%@ ,%@) VALUES (%d,'%@')",TBL_WORD,FLD_CAT_ID,FLD_WORD_NAME,catID,string];
    BOOL isAdded =  [self updateData:insertSQL];
    return  isAdded;
    NSLog(@"isadded = %d",isAdded);
}
-(BOOL)deleteCategoryByCatId:(int)catID
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat: @"DELETE FROM %@  WHERE %@=%d",TBL_CATEGPRY,FLD_CAT_ID,catID];
    BOOL isDeleted =  [self updateData:query];
    return  isDeleted;
    NSLog(@"isDeleted = %d",isDeleted);
}
-(BOOL)deleteWordByCatId:(int)catID
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat: @"DELETE FROM %@  WHERE %@=%d",TBL_WORD,FLD_CAT_ID,catID];
    BOOL isDeleted =  [self updateData:query];
    return  isDeleted;
    NSLog(@"isDeleted = %d",isDeleted);
}
-(BOOL)deleteWordByWordId:(int)wordID
{
    [self createDatabase];
    NSString *query = [NSString stringWithFormat: @"DELETE FROM %@  WHERE %@=%d",TBL_WORD,FLD_WORD_ID,wordID];
    BOOL isDeleted =  [self updateData:query];
    return  isDeleted;
    NSLog(@"isDeleted = %d",isDeleted);
}

/*
 NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO %@ (%@, %@,%@ ,%@, %@) VALUES ('B', \'apple\', \'arrow\', \'aeroplane\', \'alligator\')",TBL_ALPHABET,FLD_ALPHABET_NAME ,FLD_IMAGE_1,FLD_IMAGE_2,FLD_IMAGE_3,FLD_IMAGE_4];

 */
- (BOOL) updateData:(NSString *)query
{
     const char *dbpath = [_databasePath UTF8String];
    BOOL isAdded = FALSE;
    
    NSLog(@"Query = %@ ",query);
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
       
        const char *insert_stmt = [query UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            isAdded  = TRUE;

        } else {
           NSLog(@"Failed to add contact");
            isAdded  = FALSE;
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return  isAdded;
}
#pragma mark
#pragma mark General  Method
#pragma mark
- (void) getDataFromQuery:(NSString *)query
{
    self.tempArray = [[NSMutableArray alloc]init];
      const char *dbpath = [self.databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = [query UTF8String];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
//       Loop through all the returned rows (should be just one)
                while( sqlite3_step(statement) == SQLITE_ROW )
                {
                    [self getStringFromColumn]; // Called every time when row is incremented by 1
                }
                NSLog(@"Record does not found ");
           
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
}
-(void)getStringFromColumn
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
  
    int colCount  = sqlite3_column_count(statement); // No of colomn
    
    for (int i = 0 ; i<colCount; i++)
    {
        char* colName= (char*)sqlite3_column_name(statement, i);
        NSString *colomnName =[self convertStringFromChar:colName];
        
        char* str = (char*)sqlite3_column_text(statement, i);
        NSString *value = [self convertStringFromChar:str];
        
        [dictionary setValue:value  forKey:colomnName];
          }
    [self.tempArray addObject:dictionary];

}
-(NSString *)convertStringFromChar:(char *)charStr
{
    NSString *str = charStr == NULL ? nil :[[NSString alloc] initWithUTF8String:charStr];
    return  str;

}
@end
