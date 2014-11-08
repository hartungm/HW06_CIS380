//
//  MasterTableViewController.m
//  Grocery List
//
//  Created by Michael Hartung on 11/6/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "MasterTableViewController.h"
#import "DetailViewController.h"

@implementation MasterTableViewController

-(void) viewDidLoad
{
	NSLog(@"View Loaded");
	[super viewDidLoad];
	self.parseClassName = @"ShoppingList";
}

-(id)initWithStyle:(UITableViewStyle)style
{
	NSLog(@"StyleInit");
	self = [super initWithStyle:style];
	if(self)
	{
		self.pullToRefreshEnabled = YES;
		self.paginationEnabled = YES;
		self.objectsPerPage = 50;
	}
	return self;
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self loadObjects];
}

-(PFQuery *)queryForTable
{
	PFQuery *query = [PFQuery queryWithClassName:@"ShoppingList"];
	if(self.objects.count == 0)
	{
		query.cachePolicy = kPFCachePolicyCacheThenNetwork;
	}
	return query;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
	static NSString *cellIdentifier = @"Cell";
	PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(!cell)
	{
		cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	}
	cell.textLabel.text = object[@"item"];
	if([object[@"status"]  isEqual: @YES])
	{
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	else
	{
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	PFObject *object = [self objectAtIndexPath:indexPath];
	if([object[@"status"] isEqual: @NO])
	{
		object[@"status"] = @YES;
	}
	else
	{
		object[@"status"] = @NO;
	}
	[object saveInBackground];
	[self loadObjects];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		PFObject *object = [self objectAtIndexPath:indexPath];
		[object deleteInBackground];
		[self loadObjects];
	}
}

@end
