//
//  SpeechToText.h
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Slt/Slt.h>

@class PocketsphinxController;
@class FliteController;
#import <OpenEars/OpenEarsEventsObserver.h>
@interface SpeechToText : NSObject <OpenEarsEventsObserverDelegate>



/* Text To Voice */
@property (nonatomic, retain) Slt *slt;

@property (nonatomic, retain) OpenEarsEventsObserver *openEarsEventsObserver;
@property (nonatomic, retain) PocketsphinxController *pocketsphinxController;
@property (nonatomic, retain) FliteController *fliteController;

// Things which help us show off the dynamic language features.
@property (nonatomic, retain) NSString *pathToGrammarToStartAppWith;
@property (nonatomic, retain) NSString *pathToDictionaryToStartAppWith;
@property (nonatomic, retain) NSString *pathToDynamicallyGeneratedGrammar;
@property (nonatomic, retain) NSString * pathToDynamicallyGeneratedDictionary;
@property (nonatomic,retain) NSString *speechText;

@property (nonatomic,retain) UIView *parentView;

@property (nonatomic, assign) BOOL usingStartLanguageModel;
@property (nonatomic,retain) CommonFile *objCommon;


-(void)initlizeObjectForTextToSpeechfromView:(UIView *)parentView;

- (void) startListening :(NSString *)text;


@end
