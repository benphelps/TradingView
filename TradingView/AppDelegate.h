//
//  AppDelegate.h
//  TradingView
//
//  Created by Ben Phelps on 11/10/2012.
//  Copyright (c) 2012 Ben Phelps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Webkit/Webkit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    @private WebView *tradingview;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet WebView *tradingview;

@end
