//
//  ViewController.h
//  Reaction Time
//
//  Created by Domingo on 2015-01-27.
//  Copyright (c) 2015 Domingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)clear:(id)sender;
- (IBAction)start:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *hitMeButton;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) IBOutlet UIButton *fallBackButton;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *time3;
@property (weak, nonatomic) IBOutlet UILabel *time4;
@property (weak, nonatomic) IBOutlet UILabel *time5;
@property (nonatomic) IBOutlet UIView *light;
@property (weak, nonatomic) IBOutlet UILabel *averageTime;
- (void) startTiming;
- (void) endTimingAnddisplayTime : (NSTimeInterval)interval;

@end

