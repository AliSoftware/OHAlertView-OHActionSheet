//
//  AlertsExExampleAppDelegate.h
//  AlertsExExample
//
//  Created by Olivier on 31/01/11.
//  Copyright 2011 AliSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHAlertsExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UILabel* status;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;

-(IBAction)showAlert1;
-(IBAction)showAlert2;
-(IBAction)showSheet1;

@end

