## About these classes

These two classes make it easier to use `UIAlertView` and `UIActionSheet` classes by using blocks.

This allows you to provide directly the code to execute (as a block) in return to the tap on a button,
instead of declaring a delegate and implementing the corresponding methods.

This also has the huge advantage of **simplifying the code especially when using multiple `UIAlertViews` and `UIActionSheets`** in the same object (as in such case, it is not easy to have a clean code if you share the same delegate)

_Note: Blocks are a feature introducted in (and only compatible starting) iOS 4.x_

## Example

    [OHAlertView showAlertWithTitle:@"Alert Demo"
                            message:@"You like this sample?"
                       cancelButton:@"No"
                           okButton:@"Yes"
                     onButtonTapped:^(OHAlertView* alert, NSInteger buttonIndex)
     {
         NSLog(@"button tapped: %d",buttonIndex);
     
         if (buttonIndex == alert.cancelButtonIndex) {
             NSLog(@"No");
         } else {
             NSLog(@"Yes");
         }
     }];

## Note for iOS versions prior 4.0

This class is designed to be used with blocks, which are a new feature introduced in iOS 4.0. 
	
To assure the compatibility with pre-iOS4, `OHAlertView` also propose the possibility to associate a `userInfo` dictionary to the AlertView, and specify a `@selector` to call on a given `delegate`, so that you can at least specify a different delegate method in case you have multiple `OHAlertViews` using the same delegate.