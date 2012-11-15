//
//  OHAlertView.m
//  FoodReporter
//
//  Created by Olivier on 30/12/10.
//  Copyright 2010 FoodReporter. All rights reserved.
//

#import "OHAlertView.h"

@interface OHAlertView () <UIAlertViewDelegate> @end



@implementation OHAlertView
@synthesize buttonHandler = _buttonHandler;

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Constructors

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
			 otherButtons:(NSArray *)otherButtonTitles
		   onButtonTapped:(OHAlertViewButtonHandler)handler
{
	OHAlertView* alert = [[self alloc] initWithTitle:title message:message
                                        cancelButton:cancelButtonTitle
                                        otherButtons:otherButtonTitles
                                      onButtonTapped:handler];
	[alert show];
#if ! __has_feature(objc_arc)
	[alert autorelease];
#endif
}

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
				 okButton:(NSString *)okButton // same as using a 1-item array for otherButtons
		   onButtonTapped:(void(^)(OHAlertView* alert, NSInteger buttonIndex))handler
{
	[self showAlertWithTitle:title message:message
				cancelButton:cancelButtonTitle
				otherButtons:okButton ? [NSArray arrayWithObject:okButton] : nil
			  onButtonTapped:handler];
}


+(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
            dismissButton:(NSString *)dismissButtonTitle
{
    [self showAlertWithTitle:title message:message
                cancelButton:dismissButtonTitle
                otherButtons:nil
              onButtonTapped:nil];
}


-(id)initWithTitle:(NSString *)title message:(NSString *)message
	  cancelButton:(NSString *)cancelButtonTitle
	  otherButtons:(NSArray *)otherButtonTitles
	onButtonTapped:(void(^)(OHAlertView* alert, NSInteger buttonIndex))handler
{
	// Note: need to send at least the first button because if the otherButtonTitles parameter is nil, self.firstOtherButtonIndex will be -1
	NSString* firstOther = (otherButtonTitles && ([otherButtonTitles count]>0)) ? [otherButtonTitles objectAtIndex:0] : nil;
	self = [super initWithTitle:title message:message
					   delegate:self
			  cancelButtonTitle:cancelButtonTitle
			  otherButtonTitles:firstOther,nil];
    
	if (self)
    {
		for(NSInteger idx = 1; idx<[otherButtonTitles count];++idx) {
			[self addButtonWithTitle: [otherButtonTitles objectAtIndex:idx] ];
		}
		self.buttonHandler = handler;
	}
	return self;
}

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

-(void)showWithTimeout:(unsigned long)timeoutInSeconds
    timeoutButtonIndex:(NSInteger)timeoutButtonIndex
{
    [self showWithTimeout:timeoutInSeconds
       timeoutButtonIndex:timeoutButtonIndex
     timeoutMessageFormat:@"(Alert dismissed in %lus)"];
}

-(void)showWithTimeout:(unsigned long)timeoutInSeconds
    timeoutButtonIndex:(NSInteger)timeoutButtonIndex
  timeoutMessageFormat:(NSString*)countDownMessageFormat
{
    __block dispatch_source_t timer = nil;
    __block unsigned long countDown = timeoutInSeconds;
    
    // Add some timer sugar to the completion handler
    OHAlertViewButtonHandler finalHandler = [self.buttonHandler copy];
    self.buttonHandler = ^(OHAlertView* bhAlert, NSInteger bhButtonIndex)
    {
        // Cancel and release timer
        dispatch_source_cancel(timer);
#if ! __has_feature(objc_arc)
        dispatch_release(timer);
#endif
        timer = nil;
        
        // Execute final handler
        finalHandler(bhAlert, bhButtonIndex);
    };
#if ! __has_feature(objc_arc)
    [finalHandler release];
#endif
    
    NSString* baseMessage = self.message;
    dispatch_block_t updateMessage = countDownMessageFormat ? ^{
        self.message = [NSString stringWithFormat:@"%@\n\n%@", baseMessage, [NSString stringWithFormat:countDownMessageFormat, countDown]];
    } : ^{ /* NOOP */ };
    updateMessage();
    
    // Schedule timer every second to update message. When timer reach zero, dismiss the alert
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), 1*NSEC_PER_SEC, 0.1*NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        --countDown;
        updateMessage();
        if (countDown <= 0)
        {
            [self dismissWithClickedButtonIndex:timeoutButtonIndex animated:YES];
        }
    });
    
    // Show the alert and start the timer now
    [self show];
    dispatch_resume(timer);
}

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Memory Mgmt

#if ! __has_feature(objc_arc)
-(void)dealloc {
	[_buttonHandler release];
	[super dealloc];
}
#endif

/////////////////////////////////////////////////////////////////////////////
#pragma mark - UIAlertView Delegate Methods

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (self.buttonHandler)
    {
		self.buttonHandler(self,buttonIndex);
	}
}

@end
