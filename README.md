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

## Compatibility Notes

This classes uses blocks, which are a feature introduced in iOS 4.0.

This classes are compatible with both ARC and non-ARC projects.
