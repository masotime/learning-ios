//
//  PDFViewer.m
//  PineappleTarts
//
//  Created by Benjamin Goh on 16/6/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "PDFViewer.h"

@interface PDFViewer()
    @property (nonatomic, strong) NSMutableArray* pdfArray;
@end

@implementation PDFViewer

    @synthesize pdfArray = _pdfArray;

    - (NSArray*) pdfArray {
        if (!_pdfArray) {
            _pdfArray = [[NSMutableArray alloc] init];
        }
        
        return _pdfArray;
    }

    -(id) initWithMagazine:(NSURL*)pdfURL {
        self = [super init];
        if (self) {
            [self.pdfArray addObject:pdfURL];
        }
        return self;
    }

    - (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
        return [self.pdfArray count];
    }

    // Invoked when the Quick Look preview controller needs the preview item for a specified index position. (required)
    // Return Value:
    // The preview item to display. The item must be an NSURL object, or a custom object that conforms to the QLPreviewItem protocol.
    - (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index {
        NSURL* pdfURL = [self.pdfArray objectAtIndex:index];
        NSLog(@"PDFViewer loading [%@]", pdfURL);
        return pdfURL;
    }

@end