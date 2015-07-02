//
//  colorpassprefsListController.m
//  colorpassprefs
//
//  Created by rob311 on 29.06.2015.
//  Copyright (c) 2015 rob311. All rights reserved.
//

#import "colorpassprefsListController.h"

@implementation colorpassprefsListController

- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"colorpassprefs" target:self] retain];
	}
    
	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated
{
	[self clearCache];
	[self reload];
	[super viewWillAppear:animated];
}


-(void)followcaetano {

	NSString *user = @"caetanomelone";
	if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];
	
	else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];
	
	else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];
	
	else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];
	
	else
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
}

- (void)FollowRob {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=Rob311Apps"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=Rob311Apps"]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/Rob311Apps"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/Rob311Apps"]];
    }  else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Rob311Apps"]];
    }
}
-(void) sendEmail {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:caetanomelone@gmail.com?subject=ColorPass"]];
}

-(void) installSleekCode {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.newjoy.sleekcode"]];
}
@end

@protocol PreferencesTableCustomView
-(id)initWithSpecifier:(id)arg1;
@optional
-(CGFloat)preferredHeightForWidth:(CGFloat)arg1;
@end

@interface PSTableCell : UITableView
-(id)initWithStyle:(int)style reuseIdentifier:(id)arg2;
@end

@interface ColorPassCustomCell : PSTableCell <PreferencesTableCustomView> {

	UILabel *label;
	UILabel *underLabel;
	UILabel *otherLabel;
}
@end

@implementation ColorPassCustomCell
-(id)initWithSpecifier:(id)specifier {

	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	if (self) {

		CGRect frame = CGRectMake(0, -15, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect underFrame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect otherFrame = CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, 60);
 
		label = [[UILabel alloc] initWithFrame:frame];
		[label setNumberOfLines:1];
		label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48];
		[label setText:@"ColorPass"];
		[label setBackgroundColor:[UIColor clearColor]];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;

		underLabel = [[UILabel alloc] initWithFrame:underFrame];
		[underLabel setNumberOfLines:1];
		underLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
		[underLabel setText:@"Change the color of your passcode keys!"];
		[underLabel setBackgroundColor:[UIColor clearColor]];
		underLabel.textColor = [UIColor grayColor];
		underLabel.textAlignment = NSTextAlignmentCenter;

		otherLabel = [[UILabel alloc] initWithFrame:otherFrame];
		[otherLabel setNumberOfLines:1];
		otherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
		[otherLabel setText:@"by caetan0"];
		[otherLabel setBackgroundColor:[UIColor clearColor]];
		otherLabel.textColor = [UIColor grayColor];
		otherLabel.textAlignment = NSTextAlignmentCenter;

		[self addSubview:label];
		[self addSubview:underLabel];
		[self addSubview:otherLabel];
	}
	return self;
}
 
-(CGFloat)preferredHeightForWidth:(CGFloat)arg1 {

	CGFloat prefHeight = 90.0;
	return prefHeight;
}
@end

