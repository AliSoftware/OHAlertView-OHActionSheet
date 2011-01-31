//
//  UIAlertViewEx.m
//  FoodReporter
//
//  Created by Olivier on 30/12/10.
//  Copyright 2010 FoodReporter. All rights reserved.
//

#import "UIAlertViewEx.h"

@implementation UIAlertViewEx
@synthesize userInfo = _userInfo;

#if NS_BLOCKS_AVAILABLE

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
			 otherButtons:(NSArray *)otherButtonTitles
		   onButtonTapped:(void(^)(UIAlertViewEx* alert, NSInteger buttonIndex))completion
{
	UIAlertViewEx* alert = [[self alloc] initWithTitle:title message:message
										  cancelButton:cancelButtonTitle
										  otherButtons:otherButtonTitles
										onButtonTapped:completion];
	[alert show];
	[alert autorelease];
}

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
			 cancelButton:(NSString *)cancelButtonTitle
				 okButton:(NSString *)okButton // same as using a 1-item array for otherButtons
		   onButtonTapped:(void(^)(UIAlertViewEx* alert, NSInteger buttonIndex))completion
{
	[self showAlertWithTitle:title message:message
				cancelButton:cancelButtonTitle
				otherButtons:[NSArray arrayWithObject:okButton]
			  onButtonTapped:completion];
}

-(id)initWithTitle:(NSString *)title message:(NSString *)message
	  cancelButton:(NSString *)cancelButtonTitle
	  otherButtons:(NSArray *)otherButtonTitles
	onButtonTapped:(void(^)(UIAlertViewEx* alert, NSInteger buttonIndex))completion
{
	// Note: need to send at least the first button because if the otherButtonTitles parameter is nil, self.firstOtherButtonIndex will be -1
	NSString* firstOther = (otherButtonTitles && ([otherButtonTitles count]>0)) ? [otherButtonTitles objectAtIndex:0] : nil;
	self = [super initWithTitle:title message:message
					   delegate:self
			  cancelButtonTitle:cancelButtonTitle
			  otherButtonTitles:firstOther,nil];
	if (self) {
		for(NSInteger idx = 1; idx<[otherButtonTitles count];++idx) {
			[self addButtonWithTitle: [otherButtonTitles objectAtIndex:idx] ];
		}
		_completionBlock = [completion copy];
	}
	return self;
}

#endif

-(void)setDelegate:(id)aDelegate didDismissSelector:(SEL)aSelector {
	_finalDelegate = aDelegate;
	_finalSelector = aSelector;
	self.delegate = self;
}


-(void)dealloc {
	[_completionBlock release];
	[_userInfo release];
	[super dealloc];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
#if NS_BLOCKS_AVAILABLE
	if (_completionBlock) {
		_completionBlock(self,buttonIndex);
		return;
	}
#endif
	
	// If you dont use blocks but delegate+customSelector
	if (!_finalDelegate || !_finalSelector) return;
	
	NSMethodSignature* ms = [[_finalDelegate class] instanceMethodSignatureForSelector:_finalSelector];
	NSAssert(ms,@"Invalid selector for UIAlertViewEx!");
	
	NSInvocation* inv = [NSInvocation invocationWithMethodSignature:ms];
	[inv setTarget:_finalDelegate];
	[inv setSelector:_finalSelector];
	[inv setArgument:&alertView atIndex:2];
	[inv setArgument:&buttonIndex atIndex:3];
	[inv invoke];
}
@end
