//
//  OHAlertView.h
//  FoodReporter
//
//  Created by Olivier on 30/12/10.
//  Copyright 2010 FoodReporter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OHAlertView;
@interface OHAlertView : UIAlertView<UIAlertViewDelegate> {
@private
#if NS_BLOCKS_AVAILABLE
	void (^_completionBlock)(OHAlertView*,NSInteger);
#endif
	id<UIAlertViewDelegate> _finalDelegate;
	SEL _finalSelector;
}

/////////////////////////////////////////////////////////////////////////////

#if NS_BLOCKS_AVAILABLE
+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
			 otherButtons:(NSArray *)otherButtonTitles
		   onButtonTapped:(void(^)(OHAlertView* alert, NSInteger buttonIndex))completion;


// Commodity method
+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
				 okButton:(NSString *)okButton // same as using a 1-item array for otherButtons
		   onButtonTapped:(void(^)(OHAlertView* alert, NSInteger buttonIndex))completion;


-(id)initWithTitle:(NSString *)title message:(NSString *)message
	  cancelButton:(NSString *)cancelButtonTitle
	  otherButtons:(NSArray *)otherButtonTitles
	onButtonTapped:(void(^)(OHAlertView* alert, NSInteger buttonIndex))completion;
#endif

-(void)setDelegate:(id)aDelegate didDismissSelector:(SEL)aSelector;
@property(nonatomic, retain) NSDictionary* userInfo;

/////////////////////////////////////////////////////////////////////////////

@end
