//
//  PDFRenderer.h
//  PDFRenderer
//
//  Created by Gal Cohen on 4/14/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreText;

@interface PDFRenderer : NSObject

+(void)drawText;
+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;
+(void)drawPDF:(NSString*)fileName;

@end
