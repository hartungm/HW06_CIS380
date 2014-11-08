//
//  DetailViewController.h
//  Grocery List
//
//  Created by Michael Hartung on 11/6/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController <UITextViewDelegate>
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)canelButtonPressed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *groceryTextField;
@end

