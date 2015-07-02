@interface TPPathView
-(UIColor *)colorFromHex:(NSString *)hexString;
@end

#define kColorPassSettings @"/var/mobile/Library/Preferences/com.caetan0.colorpassprefs.plist"

static NSMutableDictionary *settings;
void refreshPrefs()
{
		if(kCFCoreFoundationVersionNumber > 900.00){ // iOS 8.0

			[settings release];
			CFStringRef appID2 = CFSTR("com.caetan0.colorpassprefs");	
			CFArrayRef keyList = CFPreferencesCopyKeyList(appID2, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
			if(keyList)
			{
				settings = (NSMutableDictionary *)CFPreferencesCopyMultiple(keyList, appID2, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
				CFRelease(keyList);
			} else
			{
				settings = nil;
			}
		}
		else
		{
			[settings release];
			settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[kColorPassSettings stringByExpandingTildeInPath]]; //Load settings the old way.
	}	
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
refreshPrefs();	
}

%group main

%hook TPPathView
- (void)setFillColor:(UIColor *)color
{
	if(settings != nil && ([settings count] != 0) && [[settings objectForKey:@"enabled"] boolValue])
	{
		if([settings objectForKey:@"aColor"])
		{
			%orig([self colorFromHex:[settings objectForKey:@"aColor"]]);
		}
		else
		{
			%orig([UIColor colorWithRed:232/255.0f  green:74/255.0f blue:76/255.0f alpha:1.0f]); //color_fallback
		}
	}
	else
	%orig;
}

%new
-(UIColor *)colorFromHex:(NSString *)hexString
{
    unsigned rgbValue = 0;
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if (hexString) {
    NSArray *getAlpha = [hexString componentsSeparatedByString:@":"];

    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

   return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:[[getAlpha objectAtIndex:1] floatValue]];

    }
	else return [UIColor whiteColor];
}

%end

%end

    %ctor {
	@autoreleasepool {	
				settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[kColorPassSettings stringByExpandingTildeInPath]];
				CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.caetan0.colorpassprefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
				refreshPrefs();
		%init(main);
	}
}