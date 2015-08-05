//
//  ViewController.h
//  CallSwift
//
//  Created by yeeku on 14/10/25.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
- (IBAction)tappedHandler:(id)sender;
@end

