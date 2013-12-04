//
//  PdfGenerationDemoAppDelegate.h
//  PdfGenerationDemo
//
//  Created by Uppal'z on 16/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PdfGenerationDemoViewController;

@interface PdfGenerationDemoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PdfGenerationDemoViewController *viewController;

@end
