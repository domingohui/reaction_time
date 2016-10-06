//
//  ViewController.m
//  Reaction Time
//
//  Created by Domingo on 2015-01-27.
//  Copyright (c) 2015 Domingo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSArray *labels;
@property NSDate *start;
@property NSTimeInterval *waitTime;
@property BOOL inTrial;
@property int numTrial;
@property double totalTime;
@end

@implementation ViewController
@synthesize start, time1, time2, time3, time4, time5, averageTime, labels, waitTime, light, inTrial, numTrial, totalTime, hitMeButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    labels = [NSArray arrayWithObjects:time1, time2, time3, time4, time5, averageTime, nil];
    
    light = [[UIView alloc]initWithFrame:CGRectMake(435, 35, light.bounds.size.width, light.bounds.size.height)];
    light.backgroundColor = [UIColor redColor];
    [self.view addSubview:light];
    
    inTrial = NO;
    numTrial = 0;
    
    totalTime = 0.000;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    if (!inTrial) {
        hitMeButton.enabled = NO;
        [hitMeButton setTitle:@"Watch for GREEN" forState:UIControlEventAllEvents];
        double time = arc4random_uniform(3)+1;
        waitTime = &time;
        [self startTiming];
        inTrial = YES;
    }
    else {
        NSTimeInterval interval = [start timeIntervalSinceNow];
        [self endTimingAnddisplayTime:interval];
        inTrial = NO;
        [hitMeButton setTitle:@"HIT ME" forState:UIControlEventAllEvents];
    }

}

- (void) startTiming{
    [NSThread sleepForTimeInterval:*(waitTime)];
    light.backgroundColor = [UIColor greenColor];
    hitMeButton.enabled = YES;
    start = [NSDate date];//start timing
}

- (void) endTimingAnddisplayTime : (NSTimeInterval)interval {
    UILabel *currentLabel = [labels objectAtIndex:numTrial];
    double timeElapsed = -interval;
    totalTime += timeElapsed;
    numTrial++;
    currentLabel.text = [NSString stringWithFormat:@"%f", timeElapsed];
    light.backgroundColor = [UIColor redColor];
    if (numTrial > 4) {
        averageTime.text = [NSString stringWithFormat:@"Average time: %f", totalTime/5];
        hitMeButton.enabled = NO;
    }
}

- (IBAction)clear:(id)sender {
    totalTime = 0.00;
    numTrial = 0;
    for (UILabel* label in labels)
        label.text = @"";
    hitMeButton.enabled = YES;
}

@end
