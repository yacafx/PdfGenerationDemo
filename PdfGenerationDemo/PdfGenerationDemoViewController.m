//
//  PdfGenerationDemoViewController.m
//  PdfGenerationDemo
//
//  Created by Uppal'z on 16/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfGenerationDemoViewController.h"

@interface PdfGenerationDemoViewController (Private)
- (void) generatePdfWithFilePath: (NSString *)thefilePath;
- (void) drawText;
- (void) drawImage;
@end

@implementation PdfGenerationDemoViewController

#pragma mark - Private Methods

NSString* text1 = @"<nombre> a continuación te presentamos información importante para construir el patrimonio que te permitirá vivir tu retiro en plenitud, estos datos están acorde con tu situación de vida actual y los datos que nos has proporcionado.  \r\r Con tu ahorro programado del <% ahorro> % de tu ingreso mensual, al llegar a los <edad> años tendrás un monto de $<cantidad ahorrada> que te permitirá vivir el retiro que siempre imaginaste.";

NSString* text2 = @"Con este ahorro para tu retiro podrás mantener tu nivel de vida y el de tu familia al llegar a tu retiro, por lo que es importante que conozcas cómo están conformados los ingresos que recibirás al momento de retirarte.";

NSString* text3 = @"También es importante saber en qué estarás gastando por lo que a continuación te mostramos una gráfica sobre el detalle de tus gastos en tu etapa de retiro.";

NSString* text4 = @"Para nosotros es importante acompañarte en la planeación de cada etapa de tu vida y contamos con soluciones acordes a tus necesidades, por lo que te invitamos a acercarte con alguno de nuestros asesores, quien podrá hacerte un traje a la medida de tus necesidades.";


- (void) drawText:(NSString *)textToShow posY:(float)posY
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = textToShow;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:16.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font
                               constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, posY, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect
                  withFont:font
             lineBreakMode:UILineBreakModeWordWrap
                 alignment:UITextAlignmentLeft];
}

- (void) drawImage:(NSString *)imageName posX:(float)posX posY:(float)posY
{
    NSString *img = [NSString stringWithFormat:@"%@", imageName];
    UIImage * myImage = [UIImage imageNamed:img];
    [myImage drawInRect:CGRectMake(posX,posY, myImage.size.width, myImage.size.height)];
}

- (void) generatePdfWithFilePath: (NSString *)thefilePath
{
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    NSInteger currentPage = 0;
    BOOL done = NO;
    do
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
        currentPage++;
        
        //Draw header image
        [self drawImage:@"headerPdf.png" posX:0 posY:0];
        
        //Draw footer image
        [self drawImage:@"footerPdf.png" posX:0 posY:1436];
        
        //Draw graphic 1
        [self drawImage:@"graph1.png" posX:211.5 posY:390];
        
        //Draw graphic 2
        [self drawImage:@"graph2.png" posX:211.5 posY:730];
        
        //Draw graphic 3
        [self drawImage:@"graph3.png" posX:211.5 posY:1070];
        
        //Draw paragraph 1
        [self drawText:text1 posY:280];
        
        //Draw paragraph 2
        [self drawText:text2 posY:670];
        
        //Draw paragraph 3
        [self drawText:text3 posY:1015];
        
        //Draw paragraph 4.
        [self drawText:text4 posY:1350];
        
        
        done = YES;
    }
    while (!done);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)generatePdfButtonPressed:(id)sender
{
    pageSize = CGSizeMake(1024, 1450);
    NSString *fileName = @"ViveTuRetiro.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePdfWithFilePath:pdfFileName];
}
@end
