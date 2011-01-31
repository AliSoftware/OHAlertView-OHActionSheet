//
//  AlertsExExampleAppDelegate.m
//  AlertsExExample
//
//  Created by Olivier on 31/01/11.
//  Copyright 2011 AliSoftware. All rights reserved.
//

#import "AlertsExExampleAppDelegate.h"
#import "UIAlertViewEx.h"
#import "UIActionSheetEx.h"


@implementation AlertsExExampleAppDelegate
@synthesize window;


-(IBAction)showAlert1 {
	[UIAlertViewEx showAlertWithTitle:@"Alert Demo"
							  message:@"Welcome to this sample"
						 cancelButton:nil
							 okButton:@"Thanks!"
					   onButtonTapped:^(UIAlertViewEx* alert, NSInteger buttonIndex)
	 {
		 status.text = @"Welcome !";
	 }];
}

/////////////////////////////////////////////////////////////////////////////


-(IBAction)showAlert2 {
	[UIAlertViewEx showAlertWithTitle:@"Your order"
							  message:@"Want some ice cream?"
						 cancelButton:@"No thanks"
							 okButton:@"Yes please!"
					   onButtonTapped:^(UIAlertViewEx *alert, NSInteger buttonIndex)
	 {
		 NSLog(@"button tapped: %d",buttonIndex);
		 
		 if (buttonIndex == alert.cancelButtonIndex) {
			 status.text = @"Your order has been cancelled";
		 } else {
			 
			 NSArray* flavors = [NSArray arrayWithObjects:@"chocolate",@"vanilla",@"strawberry",@"coffee",nil];
			 [UIAlertViewEx showAlertWithTitle:@"Flavor"
									   message:@"Which flavor do you prefer?"
								  cancelButton:@"Cancel"
								  otherButtons:flavors
								onButtonTapped:^(UIAlertViewEx *alert, NSInteger buttonIndex)
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
	
	[UIActionSheetEx showSheetInView:self.window
							   title:@"Ice cream?"
				   cancelButtonTitle:@"Maybe later"
			  destructiveButtonTitle:@"No thanks!"
				   otherButtonTitles:flavours
						  completion:^(UIActionSheetEx *sheet, NSInteger buttonIndex)
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
