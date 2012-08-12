//
//  AlertsExExampleAppDelegate.m
//  AlertsExExample
//
//  Created by Olivier on 31/01/11.
//  Copyright 2011 AliSoftware. All rights reserved.
//

#import "OHAlertsExampleAppDelegate.h"
#import "OHAlertView.h"
#import "OHActionSheet.h"


@implementation OHAlertsExampleAppDelegate
@synthesize window = _window;
@synthesize status = _status;


-(IBAction)showAlert1
{
	[OHAlertView showAlertWithTitle:@"Alert Demo"
							  message:@"Welcome to this sample"
						 cancelButton:nil
							 okButton:@"Thanks!"
					   onButtonTapped:^(OHAlertView* alert, NSInteger buttonIndex)
	 {
		 self.status.text = @"Welcome !";
	 }];
}

/////////////////////////////////////////////////////////////////////////////


-(IBAction)showAlert2
{
	[OHAlertView showAlertWithTitle:@"Your order"
							  message:@"Want some ice cream?"
						 cancelButton:@"No thanks"
							 okButton:@"Yes please!"
					   onButtonTapped:^(OHAlertView *alert, NSInteger buttonIndex)
	 {
		 NSLog(@"button tapped: %d",buttonIndex);
		 
		 if (buttonIndex == alert.cancelButtonIndex) {
			 self.status.text = @"Your order has been cancelled";
		 } else {
			 
			 NSArray* flavors = [NSArray arrayWithObjects:@"chocolate",@"vanilla",@"strawberry",@"coffee",nil];
			 [OHAlertView showAlertWithTitle:@"Flavor"
									   message:@"Which flavor do you prefer?"
								  cancelButton:@"Cancel"
								  otherButtons:flavors
								onButtonTapped:^(OHAlertView *alert, NSInteger buttonIndex)
			  {
				  NSLog(@"button tapped: %d",buttonIndex);
				  if (buttonIndex == alert.cancelButtonIndex) {
					  self.status.text = @"Your order has been cancelled";
				  } else {
					  
					  NSString* flavor = [flavors objectAtIndex:(buttonIndex-alert.firstOtherButtonIndex)];
					  self.status.text = [NSString stringWithFormat:@"You ordered a %@ ice cream.",flavor];
					  
				  }
			  }];
			 
		 }
		 
	 }];
}

-(IBAction)showAlert3
{
    OHAlertView* alert =
	[[OHAlertView alloc] initWithTitle:@"Alert Demo"
                               message:@"This is a demo message"
                          cancelButton:nil
                          otherButtons:[NSArray arrayWithObject:@"OK"]
                        onButtonTapped:^(OHAlertView* alert, NSInteger buttonIndex)
	 {
         if (buttonIndex == -1)
         {
             self.status.text = @"Demo alert dismissed automatically after timeout!";
         }
         else
         {
             self.status.text = @"Demo alert dismissed by user!";
         }
	 }];
    [alert showWithTimeout:12 timeoutButtonIndex:-1];
#if ! __has_feature(objc_arc)
    [alert release];
#endif
}


/////////////////////////////////////////////////////////////////////////////


-(IBAction)showSheet1
{
	NSArray* flavours = [NSArray arrayWithObjects:@"chocolate",@"vanilla",@"strawberry",nil];
	
	[OHActionSheet showSheetInView:self.window
							   title:@"Ice cream?"
				   cancelButtonTitle:@"Maybe later"
			  destructiveButtonTitle:@"No thanks!"
				   otherButtonTitles:flavours
						  completion:^(OHActionSheet *sheet, NSInteger buttonIndex)
	 {
		 NSLog(@"button tapped: %d",buttonIndex);
		 if (buttonIndex == sheet.cancelButtonIndex) {
			 self.status.text = @"Your order has been postponed";
		 } else if (buttonIndex == sheet.destructiveButtonIndex) {
			 self.status.text = @"Your order has been cancelled";
		 } else {
			 NSString* flavour = [flavours objectAtIndex:(buttonIndex-sheet.firstOtherButtonIndex)];
			 self.status.text = [NSString stringWithFormat:@"You ordered a %@ ice cream.",flavour];
		 }
	 }];
}

-(IBAction)showSheet2
{
	NSArray* flavours = [NSArray arrayWithObjects:@"apple",@"pear",@"banana",nil];

	OHActionSheet* sheet =
	[[OHActionSheet alloc] initWithTitle:@"What's your favorite fruit?"
                 cancelButtonTitle:@"Don't care"
            destructiveButtonTitle:nil
                 otherButtonTitles:flavours
                        completion:^(OHActionSheet *sheet, NSInteger buttonIndex)
	 {
		 NSLog(@"button tapped: %d",buttonIndex);
		 if (buttonIndex == sheet.cancelButtonIndex) {
			 self.status.text = @"You didn't answer the question";
		 } else if (buttonIndex == -1) {
			 self.status.text = @"The action sheet timed out";
		 } else {
			 NSString* fruit = [flavours objectAtIndex:(buttonIndex-sheet.firstOtherButtonIndex)];
			 self.status.text = [NSString stringWithFormat:@"Your favorite fruit is %@.",fruit];
		 }
	 }];
    
    [sheet showInView:self.window withTimeout:8 timeoutButtonIndex:-1];
#if ! __has_feature(objc_arc)
    [sheet release];
#endif
}



/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: App LifeCycle
/////////////////////////////////////////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

#if ! __has_feature(objc_arc)
- (void)dealloc {
    [_window release];
    [_status release];
    [super dealloc];
}
#endif

@end
