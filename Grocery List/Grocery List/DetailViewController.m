//
//  DetailViewController.m
//  Grocery List
//
//  Created by Michael Hartung on 11/6/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.groceryTextField resignFirstResponder];
	return YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
	PFObject *newItem = [PFObject objectWithClassName:@"ShoppingList"];
	newItem[@"item"] = self.groceryTextField.text;
	newItem[@"status"] = @NO;
	[newItem saveInBackground];
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)canelButtonPressed:(UIBarButtonItem *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelButtonPressed:(id)sender {
}
@end
