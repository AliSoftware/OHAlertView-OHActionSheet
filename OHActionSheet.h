//
//  UIActionSheetEx.h
//  FoodReporter
//
//  Created by Olivier on 23/01/11.
//  Copyright 2011 FoodReporter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHActionSheet : UIActionSheet

typedef void (^OHActionSheetButtonHandler)(OHActionSheet* sheet,NSInteger buttonIndex);
@property (nonatomic, copy) OHActionSheetButtonHandler buttonHandler;

/////////////////////////////////////////////////////////////////////////////

+(void)showSheetInView:(UIView*)view
				 title:(NSString*)title
	 cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
	 otherButtonTitles:(NSArray *)otherButtonTitles
			completion:(OHActionSheetButtonHandler)completionBlock;

- (id)initWithTitle:(NSString*)title
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
		 completion:(OHActionSheetButtonHandler)completionBlock;

/////////////////////////////////////////////////////////////////////////////

-(void)showInView:(UIView*)view;
-(void)showInView:(UIView*)view withTimeout:(unsigned long)timeoutInSeconds timeoutButtonIndex:(NSInteger)timeoutButtonIndex;
-(void)showInView:(UIView*)view withTimeout:(unsigned long)timeoutInSeconds
timeoutButtonIndex:(NSInteger)timeoutButtonIndex timeoutMessageFormat:(NSString*)countDownMessageFormat;

@end
