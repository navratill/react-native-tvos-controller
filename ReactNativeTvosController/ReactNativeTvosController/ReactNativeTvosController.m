//
//  ReactNativeTvosController.m
//  ReactNativeTvosController
//
//  Created by yangchen on 2017/1/29.
//  Copyright © 2017年 yangchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactNativeTvosController.h"


@interface ReactNativeTvosController()

- (NSString *)recognizerStateToString:(UIGestureRecognizerState)state;

@end

@implementation ReactNativeTvosController

UIPanGestureRecognizer *panGestureRecognizer;

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(connect) {
    UIView *rootView = [self getRootViewController].view;
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypePlayPause selector:@selector(respondToPlayPauseButton)];
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypeMenu selector:@selector(respondToMenuButton)];
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypeSelect selector:@selector(respondToSelectButton)];
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypeUpArrow selector:@selector(respondToUpArrowButton)];
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypeDownArrow selector:@selector(respondToDownArrowButton)];
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypeLeftArrow selector:@selector(respondToLeftArrowButton)];
    [self addTapGestureRecognizerWithType:rootView pressType:UIPressTypeRightArrow selector:@selector(respondToRightArrowButton)];
    
    [self addSwipeGestureRecognizerWithDirection:rootView direction:UISwipeGestureRecognizerDirectionRight];
    [self addSwipeGestureRecognizerWithDirection:rootView direction:UISwipeGestureRecognizerDirectionLeft];
    [self addSwipeGestureRecognizerWithDirection:rootView direction:UISwipeGestureRecognizerDirectionUp];
    [self addSwipeGestureRecognizerWithDirection:rootView direction:UISwipeGestureRecognizerDirectionDown];
    
    [self addLongPressGestureRecognizer:rootView];
}

RCT_EXPORT_METHOD(enablePanGesture) {
    UIView *rootView = [self getRootViewController].view;
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPanGesture:)];
    [rootView addGestureRecognizer:panGestureRecognizer];
}

RCT_EXPORT_METHOD(disablePanGesture) {
    if(panGestureRecognizer != nil){
        UIView *rootView = [self getRootViewController].view;
        [rootView removeGestureRecognizer:panGestureRecognizer];
    }
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"TAP", @"SWIPE", @"LONGPRESS", @"PAN"];
}

- (UIViewController *)getRootViewController
{
    UIViewController *rootVC=[[UIApplication sharedApplication].delegate window].rootViewController;
    return rootVC;
}

- (void)addTapGestureRecognizerWithType:(UIView *)view pressType:(UIPressType)pressType selector:(SEL)selector {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapGestureRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:pressType]];
    [view addGestureRecognizer:tapGestureRecognizer];
}

- (void)addSwipeGestureRecognizerWithDirection:(UIView *)view direction:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(respondToSwipeGesture:)];
    swipeGestureRecognizer.direction = direction;
    [view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)addLongPressGestureRecognizer:(UIView *)view {
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(respondToLongPressGesture:)];
    [view addGestureRecognizer:longPressGestureRecognizer];
}

- (void)respondToPlayPauseButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"PlayPause",
                                          @"code": @0
                                          }];
}

- (void)respondToMenuButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"Menu",
                                          @"code": @1
                                          }];
}

- (void)respondToSelectButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"Select",
                                          @"code": @2
                                          }];
}

- (void)respondToUpArrowButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"UpArrow",
                                          @"code": @3
                                          }];
}

- (void)respondToDownArrowButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"DownArrow",
                                          @"code": @4
                                          }];
}

- (void)respondToLeftArrowButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"LeftArrow",
                                          @"code": @5
                                          }];
}

- (void)respondToRightArrowButton {
    [self sendEventWithName:@"TAP" body:@{@"type": @"RightArrow",
                                          @"code": @6
                                          }];
}

- (void)respondToSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    switch(gesture.direction) {
        case UISwipeGestureRecognizerDirectionRight :
            [self sendEventWithName:@"SWIPE" body:@{@"direction": @"Right",
                                                  @"code": @0
                                                  }];
            break;
        case UISwipeGestureRecognizerDirectionDown :
            [self sendEventWithName:@"SWIPE" body:@{@"direction": @"Down",
                                                  @"code": @1
                                                  }];
            break;
        case UISwipeGestureRecognizerDirectionLeft :
            [self sendEventWithName:@"SWIPE" body:@{@"direction": @"Left",
                                                  @"code": @2
                                                  }];
            break;
        case UISwipeGestureRecognizerDirectionUp :
            [self sendEventWithName:@"SWIPE" body:@{@"direction": @"Up",
                                                  @"code": @3
                                                  }];
            break;
        default:
            break;
            
    }
}

- (void)respondToLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    switch(gesture.state) {
        case UIGestureRecognizerStateBegan :
            [self sendEventWithName:@"LONGPRESS" body:@{@"state": @"Began",
                                                        @"code": @0
                                                        }];
            break;
        case UIGestureRecognizerStateEnded :
            [self sendEventWithName:@"LONGPRESS" body:@{@"state": @"Ended",
                                                        @"code": @1
                                                        }];
            break;
        default:
            break;
    }
}

- (void)respondToPanGesture:(UIPanGestureRecognizer *)gesture {
    UIView *rootView = [self getRootViewController].view;
    NSString *gestureState = [self recognizerStateToString:gesture.state];
    CGPoint translation = [gesture translationInView:rootView];
    CGPoint velocity = [gesture velocityInView:rootView];
  
    if (gestureState) {
      [self sendEventWithName:@"PAN" body:@{@"state": gestureState,
                                          @"x": [NSNumber numberWithInt:translation.x],
                                          @"y": [NSNumber numberWithInt:translation.y],
                                          @"velocityX": [NSNumber numberWithFloat:velocity.x],
                                          @"velocityY": [NSNumber numberWithFloat:velocity.y],
                                          }];
    }
}

- (NSString *)recognizerStateToString:(UIGestureRecognizerState)state {
  switch (state) {
    case UIGestureRecognizerStateBegan:
      return @"Began";
    case UIGestureRecognizerStateChanged:
      return @"Changed";
    case UIGestureRecognizerStateEnded:
      return @"Ended";
    default:
      return nil;
  }
}

@end

