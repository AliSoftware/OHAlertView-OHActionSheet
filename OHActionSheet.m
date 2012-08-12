//
//  UIActionSheetEx.m
//  FoodReporter
//
//  Created by Olivier on 23/01/11.
//  Copyright 2011 FoodReporter. All rights reserved.
//

#import "OHActionSheet.h"

#if NS_BLOCKS_AVAILABLE

@implementation OHActionSheet

+(void)showSheetInView:(UIView*)view
				 title:(NSString*)title
	 cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
	 otherButtonTitles:(NSArray *)otherButtonTitles
			completion:(void (^)(OHActionSheet* sheet,NSInteger buttonIndex))completionBlock
{
	OHActionSheet* sheet = [[self alloc] initWithTitle:title
                                     cancelButtonTitle:cancelButtonTitle
                                destructiveButtonTitle:destructiveButtonTitle
                                     otherButtonTitles:otherButtonTitles
                                            completion:completionBlock];
	if ([view isKindOfClass:[UITabBar class]]) {
		[sheet showFromTabBar:(UITabBar*)view];
	} else if ([view isKindOfClass:[UIToolbar class]]) {
		[sheet showFromToolbar:(UIToolbar*)view];
	} else {
		[sheet showInView:view];
	}
#if ! __has_feature(objc_arc)
	[sheet autorelease];
#endif
}

- (id)initWithTitle:(NSString*)title
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
		 completion:(void (^)(OHActionSheet* sheet,NSInteger buttonIndex))completionBlock;
{
	// Note: need to send at least the first button because if the otherButtonTitles parameter is nil, self.firstOtherButtonIndex will be -1
	NSString* firstOther = (otherButtonTitles && ([otherButtonTitles count]>0)) ? [otherButtonTitles objectAtIndex:0] : nil;
	self = [super initWithTitle:title delegate:self
			  cancelButtonTitle:nil
		 destructiveButtonTitle:destructiveButtonTitle
			  otherButtonTitles:firstOther,nil];
	if (self != nil) {
		for(NSInteger idx = 1; idx<[otherButtonTitles count];++idx) {
			[self addButtonWithTitle: [otherButtonTitles objectAtIndex:idx] ];
		}
		[self addButtonWithTitle:cancelButtonTitle];
		self.cancelButtonIndex = self.numberOfButtons - 1;
		
		_completionBlock = [completionBlock copy];
	}
	return self;
}


-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (_completionBlock) {
		_completionBlock(self,buttonIndex);
	}
}

#if ! __has_feature(objc_arc)
- (void)dealloc {
	[_completionBlock release];
    [super dealloc];
}
#endif

@end

#endif