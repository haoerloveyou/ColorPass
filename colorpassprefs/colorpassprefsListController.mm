#import <Preferences/Preferences.h>
#import "colorpassprefsListController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <UIKit/UIKit.h>
#import <MobileGestalt/MobileGestalt.h>

@interface colorpassprefsListController: PSListController <MFMailComposeViewControllerDelegate> {
}
@end

@implementation colorpassprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"colorpassprefs" target:self] retain];
	
	UIBarButtonItem *shareButton ([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTweet:)]);
        shareButton.tag = 1;
        [[self navigationItem] setRightBarButtonItem:shareButton];
        [shareButton release];
        }
        return _specifiers;
}

-(void)composeTweet:(id)sender
{
        SLComposeViewController * composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [composeController setInitialText:@"I'm using ColorPass by @caetanomelone to change the color of my passcode keys!"];
        [self presentViewController:composeController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self clearCache];
	[self reload];
	[super viewWillAppear:animated];
}

- (void)emailCP {
    MFMailComposeViewController *emailCP = [[MFMailComposeViewController alloc] init];
    [emailCP setSubject:@"ColorPass Support"];
    [emailCP setToRecipients:[NSArray arrayWithObjects:@"caetan0 <caetanomelone@gmail.com>", nil]];

    NSString *product = nil, *version = nil, *build = nil;

    
        product = (NSString *)MGCopyAnswer(kMGProductType);
        version = (NSString *)MGCopyAnswer(kMGProductVersion);
        build = (NSString *)MGCopyAnswer(kMGBuildVersion);

    [emailCP setMessageBody:[NSString stringWithFormat:@"\n\nCurrent Device: %@, iOS %@ (%@)", product, version, build] isHTML:NO];

    [emailCP addAttachmentData:[NSData dataWithContentsOfFile:@"/var/mobile//Library/Preferences/com.caetan0.colorpassprefs.plist"] mimeType:@"application/xml" fileName:@"ColorPassPrefs.plist"];
    system("/usr/bin/dpkg -l >/tmp/dpkgl.log");
    [emailCP addAttachmentData:[NSData dataWithContentsOfFile:@"/tmp/dpkgl.log"] mimeType:@"text/plain" fileName:@"dpkgl.txt"];
    [self.navigationController presentViewController:emailCP animated:YES completion:nil];
    emailCP.mailComposeDelegate = self;
    [emailCP release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}
-(void)followCaetano {

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
-(void)followRob {

	NSString *user = @"rob311apps";
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
- (void)openSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/caetan0/ColorPass"]];
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

	CGFloat prefHeight = 46.0;
	return prefHeight;
}
@end

// vim:ft=objc
