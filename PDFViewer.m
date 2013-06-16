//
//  PDFViewer.m
//  PineappleTarts
//
//  Created by Benjamin Goh on 16/6/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "PDFViewer.h"

@implementation PDFViewer

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
    return 0;
}

// Invoked when the Quick Look preview controller needs the preview item for a specified index position. (required)
// Return Value:
// The preview item to display. The item must be an NSURL object, or a custom object that conforms to the QLPreviewItem protocol.
- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index {
    return nil;
}

@end