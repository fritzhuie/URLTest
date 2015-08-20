//
//  ViewController.h
//  Ad Tracking URL Test
//
//  Created by Fritz Huie on 8/20/15.
//  Copyright (c) 2015 Unity. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Foundation;

@interface ViewController : UIViewController <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}


@end

