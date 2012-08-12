//
//  AlertsExExampleAppDelegate.h
//  AlertsExExample
//
//  Created by Olivier on 31/01/11.
//  Copyright 2011 AliSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHAlertsExampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UILabel *status;

-(IBAction)showAlert1;
-(IBAction)showAlert2;
-(IBAction)showAlert3;
-(IBAction)showSheet1;
-(IBAction)showSheet2;

@end

