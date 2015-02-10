//
//  WordDictionaryVC.m
//  PEnglish
//
//  Created by I-MAC on 12/12/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "WordDictionaryVC.h"

@interface WordDictionaryVC ()

@end

@implementation WordDictionaryVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma  mark 
#pragma  mark  View Life Cycle
#pragma  mark
- (void)viewDidLoad
{
    [super viewDidLoad];
   /* AppDelegate * appDelegate  = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];*/
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [self removeCustomViewFromMemory];
    self.objCommon = [[CommonFile alloc]init];
    self.objCommon.delegate = self;
    catID = 0 ;
    Database * objDB = [[Database alloc]init];
    self.catArray = [objDB getCategory];
    self.wordArray = [objDB getWordsFromDatabase];
    [self.tableCategory reloadData];
    [self.tableWords reloadData];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma  mark
#pragma  mark Cover Animation Method
#pragma  mark

-(void)animationForCoverImage
{
    self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    self.coverImage.image = [UIImage imageNamed:COVER_IMAGE2];
    [self.view addSubview:self.coverImage];
    [self performSelector:@selector(Animation) withObject:nil afterDelay:1];
}
-(void)Animation{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.coverImage cache:YES];
    [UIView commitAnimations];
    self.coverImage.image = nil;
    [self performSelector:@selector(removeCoverImageFromMemory) withObject:nil afterDelay:4];
}
-(void)removeCoverImageFromMemory
{
    if (self.coverImage) {
        [self.coverImage removeFromSuperview];
        self.coverImage = nil;
    }
}

#pragma mark
#pragma mark Action Method
#pragma mark
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)removeCustomViewFromMemory
{
    if (self.customView) {
        [self.customView removeFromSuperview];
        self.customView = nil ;
    }
}
-(IBAction)addCategoryButtonClicked
{
    [self removeCustomViewFromMemory];
    [self resetTableView:self.tableCategory button:self.btnRemoveCat];

    CGRect frame ;
    if ([[SingletonClass sharedManager]isIpad])
         frame = CGRectMake(100, 80, 300, 200);
    else frame = CGRectMake(20, 70, 200, 130);

    self.customView = [self.objCommon insertValueAlertViewFrame:frame lblTitle:@"Category" placeHolderText:@"Category Name" addTag:CAT_B_T];
     [self.view addSubview:self.customView];
}
-(IBAction)addWordButtonClicked
{
    [self removeCustomViewFromMemory];
    [self resetTableView:self.tableWords button:self.btnRemoveWord];

    CGRect frame ;
    if (isIpad)
        frame = CGRectMake(self.tableCategory.frame.size.width +100, 80, 300, 200);
    else   frame =   CGRectMake(260, 45, 200, 130);
    
    self.customView = [self.objCommon insertValueAlertViewFrame:frame lblTitle:@"Word" placeHolderText:@"Word Name" addTag:WORD_B_T];
    [self.view addSubview:self.customView];

}
-(IBAction)removeCategoryButtonClicked
{
    [self deleteRowOfTableView:self.tableCategory button:self.btnRemoveCat];
}
-(IBAction)removeWordButtonClicked
{
    [self deleteRowOfTableView:self.tableWords button:self.btnRemoveWord];
}
-(void)resetTableView:(UITableView *)tableView button:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    tableView.editing = NO;
}
-(void)deleteRowOfTableView:(UITableView * )tableView button:(UIButton *)button
{
    if (tableView.editing) {
        [self resetTableView:tableView button:button];
    }
    else {
        [button setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        tableView.editing = YES;
    }
}
#pragma  mark 
#pragma  mark  Custom Delegarte Method
#pragma  mark

-(void)addButtonClicked:(id)sender string:(NSString *)string
{
    if ([sender tag] == CAT_B_T) { // INSERT DATA IN TO CATEGORY
        [self addCategory:string];
    }
    else if ([sender tag] == WORD_B_T) { // INSERT DATA IN TO WORD
        [self addWord:string];
    }
}

-(void)addCategory:(NSString *)string
{
    Database * objDB = [[Database alloc]init];
    BOOL isAdded =  [objDB insertDataInCategory:string];
    
    if (isAdded) {
        [CustomAlert alertTitle:SUCCESS alertMessage:DATA_INSERT_S delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];
        [self.catArray removeAllObjects];
        self.catArray = [objDB getCategory];
        [self.tableCategory reloadData];
        NSLog(@"temp = %@ ",self.catArray);
    }
    else{
        [CustomAlert alertTitle:FAILURE alertMessage:DATA_INSERT_F delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];
    }
    [self removeViewthroughTag:CAT_B_T];
}
-(void)addWord:(NSString *)string
{
    Database * objDB = [[Database alloc]init];
    BOOL isAdded =  [objDB insertDataInWordTable:string catId:catID];
    if (isAdded) {
        [CustomAlert alertTitle:SUCCESS alertMessage:DATA_INSERT_S delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];
        [self.wordArray removeAllObjects];
        self.wordArray = [objDB getWordsByCatID:catID];
        [self.tableWords reloadData];
    }
    else{
        [CustomAlert alertTitle:FAILURE alertMessage:DATA_INSERT_F delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];
    }
     [self removeViewthroughTag:WORD_B_T];
}
-(void)cancelButtonClicked:(id)sender
{
    if ([sender tag] == CAT_B_T) {
        [self removeViewthroughTag:CAT_B_T];
    }
    else{
        [self removeViewthroughTag:WORD_B_T];
    }
}
#pragma mark
#pragma mark Other Method
#pragma mark
-(void)removeViewthroughTag:(int )viewTag
{
    for (UIView * view in  self.view.subviews){
        if ([view viewWithTag:viewTag]) {
            [view removeFromSuperview];
        }
    }
}
#pragma  mark
#pragma  mark  UITable View  Method
#pragma  mark

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(int)section{
    
    int rowCount = 0;
    if (tableView == self.tableCategory) {
        rowCount = self.catArray.count;
        
    }else if (tableView == self.tableWords) {
        rowCount = self.wordArray.count;
        
    }return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (tableView == self.tableCategory) {
        
        cell.textLabel.text = [[self.catArray objectAtIndex:indexPath.row] valueForKey:FLD_CAT_NAME];
        cell.layer.borderColor = [OC CGColor];
        cell.layer.borderWidth = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor    = OC;
        cell.selectedBackgroundView =view;
        
    }
    else if (tableView == self.tableWords) {
        cell.textLabel.text = [[self.wordArray objectAtIndex:indexPath.row] valueForKey:FLD_WORD_NAME];
        cell.layer.borderColor = [OC CGColor];
        cell.layer.borderWidth = 1;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
   return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Database * objDB = [[Database alloc]init];
    if (tableView == self.tableCategory) {
     
        catID = [[[self.catArray objectAtIndex:indexPath.row]valueForKey:FLD_CAT_ID] integerValue];
        [self.wordArray removeAllObjects];
        if (catID == 1) {
            self.wordArray = [objDB getWordsFromDatabase];
        }
        else  {
            self.wordArray = [objDB getWordsByCatID:catID];
        }
        [self.tableWords reloadData];
    }
    else if (tableView == self.tableWords) {
        
        selectedIndex = indexPath.row;

        //catID = [[[self.wordArray objectAtIndex:indexPath.row]valueForKey:FLD_CAT_ID] integerValue];
        
        [self performSegueWithIdentifier:WORD_VC sender:self];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:WORD_VC]) {
         WordVC *obj = [segue destinationViewController];
        obj.selectedIndex = selectedIndex;
        obj.wordArray = self.wordArray ;
        //obj.wordDic = [self.wordArray objectAtIndex:selectedIndex];
    }
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Database * objDB = [[Database alloc]init];
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Do whatever data deletion you need to do...
        // Delete the row from the data source
        if (tableView == self.tableCategory) {
            catID = [[[self.catArray objectAtIndex:indexPath.row]valueForKey:FLD_CAT_ID] integerValue];
            [objDB  deleteCategoryByCatId:catID];
            [objDB  deleteWordByCatId:catID];
            
            
          [self.catArray removeObjectAtIndex:indexPath.row];
        }
        else
        {
            int wordID = [[[self.wordArray  objectAtIndex:indexPath.row]valueForKey:FLD_WORD_ID] integerValue];
            [objDB deleteWordByWordId:wordID];
            [self.wordArray removeObjectAtIndex:indexPath.row];
        }
        
        
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView endUpdates];
    [tableView reloadData];
    
  
   
}

#pragma  mark 
#pragma  mark  Memory Managment Method
#pragma  mark
-(void)dealloc
{
    self.objCommon.delegate = nil;
    [self nilObject:self.objCommon];
    [self nilObject:self.tableCategory];
    [self nilObject:self.tableWords];
    [self nilObject:self.catArray];
    [self nilObject:self.wordArray];
    
   
}
-(void)nilObject:(id)object
{
    if (object) {
        object = nil ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
