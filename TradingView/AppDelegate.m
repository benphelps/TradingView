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
    
    [[tradingview layer] setCornerRadius:10];
    
    // Load the page in
    NSString *urlString = @"https://www.tradingview.com/e/";
    [[tradingview mainFrame]loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webViewDidFinishLoad:)
                                                 name:WebViewProgressFinishedNotification
                                               object:tradingview];
    
}

-(void) webViewDidFinishLoad:(WebView *)webView
{
    [tradingview stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('tweetimage')[0].style.display = 'none';"];
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)pageTitle forFrame:(WebFrame *)frame {
    // there is a blip of "AddThis utility frame" and I'm not sure why, so we block it
    if([pageTitle rangeOfString:@"AddThis"].location == NSNotFound){
        [self updateWindowTitle:pageTitle];
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
