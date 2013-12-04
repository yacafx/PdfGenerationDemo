//
//  PdfGenerationDemoViewController.h
//  PdfGenerationDemo
//
//  Created by Uppal'z on 16/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0

@interface PdfGenerationDemoViewController : UIViewController
{
    CGSize pageSize;
}

- (IBAction)generatePdfButtonPressed:(id)sender;

@end
