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
	return cell;
}

@end
