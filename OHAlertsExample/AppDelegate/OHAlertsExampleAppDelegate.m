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
@synthesize window;


-(IBAction)showAlert1 {
	[OHAlertView showAlertWithTitle:@"Alert Demo"
							  message:@"Welcome to this sample"
						 cancelButton:nil
							 okButton:@"Thanks!"
					   onButtonTapped:^(OHAlertView* alert, NSInteger buttonIndex)
	 {
		 status.text = @"Welcome !";
	 }];
}

/////////////////////////////////////////////////////////////////////////////


-(IBAction)showAlert2 {
	[OHAlertView showAlertWithTitle:@"Your order"
							  message:@"Want some ice cream?"
						 cancelButton:@"No thanks"
							 okButton:@"Yes please!"
					   onButtonTapped:^(OHAlertView *alert, NSInteger buttonIndex)
	 {
		 NSLog(@"button tapped: %d",buttonIndex);
		 
		 if (buttonIndex == alert.cancelButtonIndex) {
			 status.text = @"Your order has been cancelled";
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
					  status.text = @"Your order has been cancelled";
				  } else {
					  
					  NSString* flavor = [flavors objectAtIndex:(buttonIndex-alert.firstOtherButtonIndex)];
					  status.text = [NSString stringWithFormat:@"You ordered a %@ ice cream.",flavor];
					  
				  }
			  }];
			 
		 }
		 
	 }];
}


/////////////////////////////////////////////////////////////////////////////


-(IBAction)showSheet1 {
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
			 status.text = @"Your order has been postponed";
		 } else if (buttonIndex == sheet.destructiveButtonIndex) {
			 status.text = @"Your order has been cancelled";
		 } else {
			 NSString* flavour = [flavours objectAtIndex:(buttonIndex-sheet.firstOtherButtonIndex)];
			 status.text = [NSString stringWithFormat:@"You ordered a %@ ice cream.",flavour];
		 }
	 }];
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

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
