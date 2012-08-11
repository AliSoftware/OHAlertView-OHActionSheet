//
//  OHAlertView.h
//  FoodReporter
//
//  Created by Olivier on 30/12/10.
//  Copyright 2010 FoodReporter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHAlertView : UIAlertView

typedef void(^OHAlertViewButtonHandler)(OHAlertView* alert, NSInteger buttonIndex);
@property (nonatomic, copy) OHAlertViewButtonHandler buttonHandler;

/////////////////////////////////////////////////////////////////////////////

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
			 otherButtons:(NSArray *)otherButtonTitles
		   onButtonTapped:(OHAlertViewButtonHandler)handler;


// Commodity method
+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
				 okButton:(NSString *)okButton // same as using a 1-item array for otherButtons
		   onButtonTapped:(OHAlertViewButtonHandler)handler;


-(id)initWithTitle:(NSString *)title message:(NSString *)message
	  cancelButton:(NSString *)cancelButtonTitle
	  otherButtons:(NSArray *)otherButtonTitles
	onButtonTapped:(OHAlertViewButtonHandler)handler;

/////////////////////////////////////////////////////////////////////////////

-(void)showWithTimeout:(unsigned long)timeoutInSeconds
    timeoutButtonIndex:(NSInteger)timeoutButtonIndex;

-(void)showWithTimeout:(unsigned long)timeoutInSeconds
    timeoutButtonIndex:(NSInteger)timeoutButtonIndex
  timeoutMessageFormat:(NSString*)countDownMessageFormat; // use "%lu" for the countdown value placeholder

@end
