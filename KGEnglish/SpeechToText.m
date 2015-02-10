//
//  SpeechToText.m
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "SpeechToText.h"
#import <OpenEars/PocketsphinxController.h> // Please note that unlike in previous versions of OpenEars, we now link the headers through the framework.
#import <OpenEars/FliteController.h>
#import <OpenEars/LanguageModelGenerator.h>
#import <OpenEars/OpenEarsLogging.h>
#import <OpenEars/AcousticModel.h>

@implementation SpeechToText

@synthesize openEarsEventsObserver;

@synthesize pocketsphinxController;

@synthesize fliteController;

@synthesize usingStartLanguageModel;

@synthesize pathToGrammarToStartAppWith;

@synthesize pathToDictionaryToStartAppWith;

@synthesize pathToDynamicallyGeneratedGrammar;

@synthesize pathToDynamicallyGeneratedDictionary;

@synthesize slt;

-(void)initlizeObjectForTextToSpeechfromView:(UIView *)parentView
{
    
    self.objCommon = [[CommonFile alloc]init];
    self.parentView = parentView;
    
    //[OpenEarsLogging startOpenEarsLogging]; // Uncomment me for OpenEarsLogging
    
	[self.openEarsEventsObserver setDelegate:self]; // Make this class the delegate of OpenEarsObserver so we can get all of the messages about what OpenEars is doing.
    
    // This is the language model we're going to start up with. The only reason I'm making it a class property is that I reuse it a bunch of times in this example,
	// but you can pass the string contents directly to PocketsphinxController:startListeningWithLanguageModelAtPath:dictionaryAtPath:languageModelIsJSGF:
	
	self.pathToGrammarToStartAppWith = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"OpenEars1.languagemodel"];
    
	// This is the dictionary we're going to start up with. The only reason I'm making it a class property is that I reuse it a bunch of times in this example,
	// but you can pass the string contents directly to PocketsphinxController:startListeningWithLanguageModelAtPath:dictionaryAtPath:languageModelIsJSGF:
	self.pathToDictionaryToStartAppWith = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"OpenEars1.dic"];
    
       
    
	//self.usingStartLanguageModel = TRUE; // This is not an OpenEars thing, this is just so I can switch back and forth between the two models in this sample app.
	
}
#define kLevelUpdatesPerSecond 18 // We'll have the ui update 18 times a second to show some fluidity without hitting the CPU too hard.

//#define kGetNbest // Uncomment this if you want to try out nbest
#pragma mark -
#pragma mark Memory Management



#pragma mark -
#pragma mark Lazy Allocation

// Lazily allocated PocketsphinxController.
- (PocketsphinxController *)pocketsphinxController {
	if (pocketsphinxController == nil) {
		pocketsphinxController = [[PocketsphinxController alloc] init];
        //pocketsphinxController.verbosePocketSphinx = TRUE; // Uncomment me for verbose debug output
        pocketsphinxController.outputAudio = TRUE;
#ifdef kGetNbest
        pocketsphinxController.returnNbest = TRUE;
        pocketsphinxController.nBestNumber = 5;
#endif
	}
	return pocketsphinxController;
}

// Lazily allocated slt voice.
- (Slt *)slt {
	if (slt == nil) {
		slt = [[Slt alloc] init];
	}
	return slt;
}

// Lazily allocated FliteController.
- (FliteController *)fliteController {
	if (fliteController == nil) {
		fliteController = [[FliteController alloc] init];
        
	}
	return fliteController;
}

// Lazily allocated OpenEarsEventsObserver.
- (OpenEarsEventsObserver *)openEarsEventsObserver {
	if (openEarsEventsObserver == nil) {
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
	}
	return openEarsEventsObserver;
}

// The last class we're using here is LanguageModelGenerator but I don't think it's advantageous to lazily instantiate it. You can see how it's used below.

- (void) startListening :(NSString *)text{
    [self.objCommon initiateLoaderWithMessage:PLEASE_WAIT inView:self.parentView];
    self.speechText = text;
    // startListeningWithLanguageModelAtPath:dictionaryAtPath:languageModelIsJSGF always needs to know the grammar file being used,
    // the dictionary file being used, and whether the grammar is a JSGF. You must put in the correct value for languageModelIsJSGF.
    // Inside of a single recognition loop, you can only use JSGF grammars or ARPA grammars, you can't switch between the two types.
    
    // An ARPA grammar is the kind with a .languagemodel or .DMP file, and a JSGF grammar is the kind with a .gram file.
    
    // If you wanted to just perform recognition on an isolated wav file for testing, you could do it as follows:
    
    // NSString *wavPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"test.wav"];
    //[self.pocketsphinxController runRecognitionOnWavFileAtPath:wavPath usingLanguageModelAtPath:self.pathToGrammarToStartAppWith dictionaryAtPath:self.pathToDictionaryToStartAppWith languageModelIsJSGF:FALSE];  // Starts the recognition loop.
    
    // But under normal circumstances you'll probably want to do continuous recognition as follows:
    
    if (pocketsphinxController == nil) {
        pocketsphinxController = [[PocketsphinxController alloc] init];
    }
    [self.pocketsphinxController startListeningWithLanguageModelAtPath:self.pathToGrammarToStartAppWith dictionaryAtPath:self.pathToDictionaryToStartAppWith acousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:FALSE]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" in order to perform Spanish recognition instead of English.
}
#pragma mark -
#pragma mark OpenEarsEventsObserver delegate methods
#pragma mark
// What follows are all of the delegate methods you can optionally use once you've instantiated an OpenEarsEventsObserver and set its delegate to self.
// I've provided some pretty granular information about the exact phase of the Pocketsphinx listening loop, the Audio Session, and Flite, but I'd expect
// that the ones that will really be needed by most projects are the following:
//
//- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID;
//- (void) audioSessionInterruptionDidBegin;
//- (void) audioSessionInterruptionDidEnd;
//- (void) audioRouteDidChangeToRoute:(NSString *)newRoute;
//- (void) pocketsphinxDidStartListening;
//- (void) pocketsphinxDidStopListening;
//
// It isn't necessary to have a PocketsphinxController or a FliteController instantiated in order to use these methods.  If there isn't anything instantiated that will
// send messages to an OpenEarsEventsObserver, all that will happen is that these methods will never fire.  You also do not have to create a OpenEarsEventsObserver in
// the same class or view controller in which you are doing things with a PocketsphinxController or FliteController; you can receive updates from those objects in
// any class in which you instantiate an OpenEarsEventsObserver and set its delegate to self.

// An optional delegate method of OpenEarsEventsObserver which delivers the text of speech that Pocketsphinx heard and analyzed, along with its accuracy score and utterance ID.
- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    
	NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID); // Log it.
	if([hypothesis isEqualToString:@"CHANGE MODEL"]) { // If the user says "CHANGE MODEL", we will switch to the alternate model (which happens to be the dynamically generated model).
        
		// Here is an example of language model switching in OpenEars. Deciding on what logical basis to switch models is your responsibility.
		// For instance, when you call a customer service line and get a response tree that takes you through different options depending on what you say to it,
		// the models are being switched as you progress through it so that only relevant choices can be understood. The construction of that logical branching and
		// how to react to it is your job, OpenEars just lets you send the signal to switch the language model when you've decided it's the right time to do so.
		
		if(self.usingStartLanguageModel == TRUE) { // If we're on the starting model, switch to the dynamically generated one.
			
			// You can only change language models with ARPA grammars in OpenEars (the ones that end in .languagemodel or .DMP).
			// Trying to switch between JSGF models (the ones that end in .gram) will return no result.
			[self.pocketsphinxController changeLanguageModelToFile:self.pathToDynamicallyGeneratedGrammar withDictionary:self.pathToDynamicallyGeneratedDictionary];
			self.usingStartLanguageModel = FALSE;
		} else { // If we're on the dynamically generated model, switch to the start model (this is just an example of a trigger and method for switching models).
			[self.pocketsphinxController changeLanguageModelToFile:self.pathToGrammarToStartAppWith withDictionary:self.pathToDictionaryToStartAppWith];
			self.usingStartLanguageModel = TRUE;
		}
	}
	
 	
	// This is how to use an available instance of FliteController. We're going to repeat back the command that we heard with the voice we've chosen.
	//[self.fliteController say:[NSString stringWithFormat:@"You said %@",hypothesis] withVoice:self.slt];
}

#ifdef kGetNbest
- (void) pocketsphinxDidReceiveNBestHypothesisArray:(NSArray *)hypothesisArray { // Pocketsphinx has an n-best hypothesis dictionary.
    NSLog(@"hypothesisArray is %@",hypothesisArray);
}
#endif
// An optional delegate method of OpenEarsEventsObserver which informs that there was an interruption to the audio session (e.g. an incoming phone call).
- (void) audioSessionInterruptionDidBegin {
	NSLog(@"AudioSession interruption began."); // Log it.
    
	[self.pocketsphinxController stopListening]; // React to it by telling Pocketsphinx to stop listening since it will need to restart its loop after an interruption.
}

// An optional delegate method of OpenEarsEventsObserver which informs that the interruption to the audio session ended.
- (void) audioSessionInterruptionDidEnd {
    [self.objCommon HideLoader];
	NSLog(@"AudioSession interruption ended."); // Log it.
    // We're restarting the previously-stopped listening loop.
    [self startListening:self.speechText];
	
}

// An optional delegate method of OpenEarsEventsObserver which informs that the audio input became unavailable.
- (void) audioInputDidBecomeUnavailable {
	NSLog(@"The audio input has become unavailable"); // Log it.
    [self.objCommon HideLoader];
	[self.pocketsphinxController stopListening]; // React to it by telling Pocketsphinx to stop listening since there is no available input
}

// An optional delegate method of OpenEarsEventsObserver which informs that the unavailable audio input became available again.
- (void) audioInputDidBecomeAvailable {
	NSLog(@"The audio input is available"); // Log it.
    [self startListening:self.speechText];
}

// An optional delegate method of OpenEarsEventsObserver which informs that there was a change to the audio route (e.g. headphones were plugged in or unplugged).
- (void) audioRouteDidChangeToRoute:(NSString *)newRoute {
	NSLog(@"Audio route change. The new audio route is %@", newRoute); // Log it.
    
	[self.pocketsphinxController stopListening]; // React to it by telling the Pocketsphinx loop to shut down and then start listening again on the new route
    [self startListening:self.speechText];
}

// An optional delegate method of OpenEarsEventsObserver which informs that the Pocketsphinx recognition loop hit the calibration stage in its startup.
// This might be useful in debugging a conflict between another sound class and Pocketsphinx. Another good reason to know when you're in the middle of
// calibration is that it is a timeframe in which you want to avoid playing any other sounds including speech so the calibration will be successful.
- (void) pocketsphinxDidStartCalibration {
	NSLog(@"Pocketsphinx calibration has started."); // Log it.
}

// An optional delegate method of OpenEarsEventsObserver which informs that the Pocketsphinx recognition loop completed the calibration stage in its startup.
// This might be useful in debugging a conflict between another sound class and Pocketsphinx.
- (void) pocketsphinxDidCompleteCalibration {
	NSLog(@"Pocketsphinx calibration is complete."); // Log it.
    
	self.fliteController.duration_stretch = .9; // Change the speed
	self.fliteController.target_mean = 1.2; // Change the pitch
	self.fliteController.target_stddev = 1.5; // Change the variance
	
    [self.fliteController say:self.speechText withVoice:self.slt];
    // The same statement with the pitch and other voice values changed.
	
	self.fliteController.duration_stretch = 1.0; // Reset the speed
	self.fliteController.target_mean = 1.0; // Reset the pitch
	self.fliteController.target_stddev = 1.0; // Reset the variance
}

// An optional delegate method of OpenEarsEventsObserver which informs that the Pocketsphinx recognition loop has entered its actual loop.
// This might be useful in debugging a conflict between another sound class and Pocketsphinx.
- (void) pocketsphinxRecognitionLoopDidStart {
    
	NSLog(@"Pocketsphinx is starting up."); // Log it.
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx is now listening for speech.
- (void) pocketsphinxDidStartListening {
	
	NSLog(@"Pocketsphinx is now listening."); // Log it.
	
	
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx detected speech and is starting to process it.
- (void) pocketsphinxDidDetectSpeech {
	NSLog(@"Pocketsphinx has detected speech."); // Log it.
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx detected a second of silence, indicating the end of an utterance.
// This was added because developers requested being able to time the recognition speed without the speech time. The processing time is the time between
// this method being called and the hypothesis being returned.
- (void) pocketsphinxDidDetectFinishedSpeech {
	NSLog(@"Pocketsphinx has detected a second of silence, concluding an utterance."); // Log it.
//    [self.objCommon HideLoader];
    
    [self.pocketsphinxController stopListening];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2];
}


// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx has exited its recognition loop, most
// likely in response to the PocketsphinxController being told to stop listening via the stopListening method.
- (void) pocketsphinxDidStopListening {
	NSLog(@"Pocketsphinx has stopped listening."); // Log it.
    
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx is still in its listening loop but it is not
// Going to react to speech until listening is resumed.  This can happen as a result of Flite speech being
// in progress on an audio route that doesn't support simultaneous Flite speech and Pocketsphinx recognition,
// or as a result of the PocketsphinxController being told to suspend recognition via the suspendRecognition method.
- (void) pocketsphinxDidSuspendRecognition {
	NSLog(@"Pocketsphinx has suspended recognition."); // Log it.
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx is still in its listening loop and after recognition
// having been suspended it is now resuming.  This can happen as a result of Flite speech completing
// on an audio route that doesn't support simultaneous Flite speech and Pocketsphinx recognition,
// or as a result of the PocketsphinxController being told to resume recognition via the resumeRecognition method.
- (void) pocketsphinxDidResumeRecognition {
	NSLog(@"Pocketsphinx has resumed recognition."); // Log it.
}

// An optional delegate method which informs that Pocketsphinx switched over to a new language model at the given URL in the course of
// recognition. This does not imply that it is a valid file or that recognition will be successful using the file.
- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
	NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

// An optional delegate method of OpenEarsEventsObserver which informs that Flite is speaking, most likely to be useful if debugging a
// complex interaction between sound classes. You don't have to do anything yourself in order to prevent Pocketsphinx from listening to Flite talk and trying to recognize the speech.
- (void) fliteDidStartSpeaking {
	NSLog(@"Flite has started speaking"); // Log it.
    
    
}

// An optional delegate method of OpenEarsEventsObserver which informs that Flite is finished speaking, most likely to be useful if debugging a
// complex interaction between sound classes.
- (void) fliteDidFinishSpeaking {
	NSLog(@"Flite has finished speaking"); // Log it.
    
    [self.pocketsphinxController stopListening];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];
    
}
-(void)delayMethod
{
    [self.objCommon HideLoader];
}

- (void) pocketSphinxContinuousSetupDidFail { // This can let you know that something went wrong with the recognition loop startup. Turn on [OpenEarsLogging startOpenEarsLogging] to learn why.
	NSLog(@"Setting up the continuous recognition loop has failed for some reason, please turn on [OpenEarsLogging startOpenEarsLogging] in OpenEarsConfig.h to learn more."); // Log it.
}

- (void) shutDown {
    NSLog(@"Hi I'm on thread %@",[NSThread currentThread]);
}

- (void) testRecognitionCompleted { // A test file which was submitted for direct recognition via the audio driver is done.
	NSLog(@"A test file which was submitted for direct recognition via the audio driver is done."); // Log it.
    [self.pocketsphinxController stopListening];
    
}


@end
