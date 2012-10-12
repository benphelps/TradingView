//
//  AppDelegate.m
//  TradingView
//
//  Created by Ben Phelps on 11/10/2012.
//  Copyright (c) 2012 Ben Phelps. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize tradingview;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [tradingview setFrameLoadDelegate: self];
    [tradingview setPolicyDelegate: self];
    
    // Load the page in
    NSString *urlString = @"https://www.tradingview.com/e/";
    [[tradingview mainFrame]loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)pageTitle forFrame:(WebFrame *)frame {
    // there is a blip of "AddThis utility frame" and I'm not sure why, so we block it
    if([pageTitle rangeOfString:@"AddThis"].location == NSNotFound){
        [self updateWindowTitle:pageTitle];
    }  
}

- (void)webView:(WebView *)webView
decidePolicyForNavigationAction:(NSDictionary *)actionInformation
                        request:(NSURLRequest *)request frame:(WebFrame *)frame
               decisionListener:(id < WebPolicyDecisionListener >)listener
{
    NSString *host = [[request URL] host];
    if ([host rangeOfString:@"www.tradingview.com"].location == NSNotFound) {
        // stop loading external shit
    } else {
        [listener use];
    }
}

- (void)webView:(WebView *)webView
decidePolicyForNewWindowAction:(NSDictionary *)actionInformation
                       request:(NSURLRequest *)request
                  newFrameName:(NSString *)frameName
              decisionListener:(id < WebPolicyDecisionListener >)listener
{
    NSString *host = [[request URL] host];
    if (host) {
        // load in users default browser
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    } else {
        [listener use];
    }
}

- (void) updateWindowTitle: (NSString*) title {
	[[tradingview window]setTitle:title];
}

@end
