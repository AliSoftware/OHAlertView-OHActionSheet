//
//  UIActionSheetEx.h
//  FoodReporter
//
//  Created by Olivier on 23/01/11.
//  Copyright 2011 FoodReporter. All rights reserved.
//

#import <UIKit/UIKit.h>

#if NS_BLOCKS_AVAILABLE

@class OHActionSheet;
@interface OHActionSheet : UIActionSheet<UIActionSheetDelegate> {
@private
	void (^_completionBlock)(OHActionSheet*,NSInteger);
}

/////////////////////////////////////////////////////////////////////////////

+(void)showSheetInView:(UIView*)view
				 title:(NSString*)title
	 cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
	 otherButtonTitles:(NSArray *)otherButtonTitles
			completion:(void (^)(OHActionSheet* sheet,NSInteger buttonIndex))completionBlock;

- (id)initWithTitle:(NSString*)title
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
		 completion:(void (^)(OHActionSheet* sheet,NSInteger buttonIndex))completionBlock;

/////////////////////////////////////////////////////////////////////////////

@end

#else
#warning UIActionSheetEx uses blocks that are supported only since iOS 4.0
@interface UIActionSheetEx : UIActionSheet @end
#endif