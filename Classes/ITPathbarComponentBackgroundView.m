//
//  ITPathbarComponentBackgroundView.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 13/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ITPathbarComponentBackgroundView.h"
#import "ITPathbarComponent.h"


@interface NSBezierPath (ITPathbar)
@property (readonly) CGPathRef CGPath;
@end

@implementation NSBezierPath (ITPathbar)

// This method works only in OS X v10.2 and later.
- (CGPathRef)CGPath
{
    // Need to begin a path here.
    CGPathRef           immutablePath = NULL;
    
    // Then draw the path elements.
    NSUInteger numElements = [self elementCount];
    if (numElements > 0)
    {
        CGMutablePathRef    path = CGPathCreateMutable();
        NSPoint             points[3];
        BOOL                didClosePath = YES;
        
        for (int i = 0; i < numElements; i++)
        {
            switch ([self elementAtIndex:i associatedPoints:points])
            {
                case NSMoveToBezierPathElement:
                    CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
                    break;
                    
                case NSLineToBezierPathElement:
                    CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
                    didClosePath = NO;
                    break;
                    
                case NSCurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y,
                                          points[1].x, points[1].y,
                                          points[2].x, points[2].y);
                    didClosePath = NO;
                    break;
                    
                case NSClosePathBezierPathElement:
                    CGPathCloseSubpath(path);
                    didClosePath = YES;
                    break;
            }
        }
        
        // Be sure the path is closed or Quartz may not do valid hit detection.
        if (!didClosePath)
            CGPathCloseSubpath(path);
        
        immutablePath = CGPathCreateCopy(path);
        CGPathRelease(path);
    }
    
    return immutablePath;
}

@end


@interface ITPathbarComponentBackgroundView ()
/// A reference to the pathbar component
@property (weak) ITPathbarComponent *pathbarComponent;
///
@property (strong) CAShapeLayer *backgroundShapeLayer;
@end

@implementation ITPathbarComponentBackgroundView

/// Designated initializer
- (instancetype)initWithPathbarComponent:(ITPathbarComponent *)pathbarComponent {
    if (self = [self initWithFrame:NSZeroRect]) {
        self.pathbarComponent = pathbarComponent;
        self.backgroundShapeLayer = [CAShapeLayer layer];
        self.wantsLayer = YES;
        [self.layer addSublayer:self.backgroundShapeLayer];
    }
    return self;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    
    float leftXOffset = !self.pathbarComponent.isFirstComponent ? 4.0 : 0;
    float rightXOffset = !self.pathbarComponent.isLastComponent ? 4.0 : 0;
    float height = NSHeight(self.bounds);
    float width = NSWidth(self.bounds);
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:(NSPoint){ 0, 0 }];
    [path lineToPoint:(NSPoint){ leftXOffset, height/2.0 }];
    [path lineToPoint:(NSPoint){ 0, height }];
    [path lineToPoint:(NSPoint){ width - rightXOffset, height }];
    [path lineToPoint:(NSPoint){ width, height/2.0 }];
    [path lineToPoint:(NSPoint){ width - rightXOffset, 0 }];
    [path lineToPoint:(NSPoint){ 0, 0 }];
    
    [self.backgroundShapeLayer setFrame:self.bounds];
    self.backgroundShapeLayer.path = path.CGPath;
}

- (void)setDrawsBackground:(BOOL)drawsBackground {
    _drawsBackground = drawsBackground;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    {
        self.backgroundShapeLayer.fillColor = (drawsBackground ? [NSColor blueColor].CGColor : nil);
    }
    [CATransaction commit];
}

- (BOOL)allowsVibrancy {
    return NO;
}


///// Draw the highlight of the component
//- (void)drawRect:(NSRect)dirtyRect {
//    [NSGraphicsContext saveGraphicsState];
//    {
//        
//        
//        // Only draw if the component is highlighted
//        if (self.pathbarComponent.isHighlighted) {
//        }
//        
//        else if (!self.pathbarComponent.isLastComponent) {
//            float rightMargin = 1.0;
//            float separatorSize = 0.35;
//            
//            NSBezierPath *path = [NSBezierPath bezierPath];
//            [path moveToPoint:(NSPoint){ width - rightXOffset*separatorSize - rightMargin, height/2.0 + height*separatorSize*0.5 }];
//            [path lineToPoint:(NSPoint){ width - rightMargin, height/2.0 }];
//            [path lineToPoint:(NSPoint){ width - rightXOffset*separatorSize - rightMargin, height/2.0 - height*separatorSize*0.5 }];
//            
//            [[NSColor colorWithDeviceWhite:0.0 alpha:0.4] setStroke];
//            [path stroke];
//        }
//    }
//    [NSGraphicsContext restoreGraphicsState];
//}

@end
