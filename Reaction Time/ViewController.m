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
@property BOOL inTrial;
@property int numTrial;
@property double totalTime;
@property NSTimer* timeout;
@end

@implementation ViewController
@synthesize start, time1, time2, time3, time4, time5, averageTime, labels,
light, inTrial, numTrial, totalTime, hitMeButton, clearButton, fallBackButton;

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
        [self changeHitMeButtonStatus:NO];
        clearButton.enabled = NO;
        
        [self showGreenSignalAfterRandomTime];
        
        inTrial = YES;
    }
    else if (inTrial && !hitMeButton.enabled) {
        UIAlertView *cheatAlert = [[UIAlertView alloc]
                                   initWithTitle:@"You jumped the gun!"
                                   message:@"Please wait for the green"
                                   delegate:NULL cancelButtonTitle: @"Restart"
                                   otherButtonTitles: nil ];
        [cheatAlert show];

        [self clear: clearButton];
    }
    else {
        NSTimeInterval interval = [start timeIntervalSinceNow];
        [self endTimingAnddisplayTime:interval];
        inTrial = NO;
        [self changeHitMeButtonStatus:YES];
        clearButton.enabled = YES;
    }

}

- (void) showGreenSignalAfterRandomTime {
    [self performSelector: @selector(changeSignalToGreen) withObject:self
               afterDelay: (2 + arc4random_uniform(10)/10)];
}

- (void) changeSignalToGreen {
    if (inTrial) {
        light.backgroundColor = [UIColor greenColor];
        [self startTiming];
    }
}

- (void) startTiming{
    start = [NSDate date];//start timing
    hitMeButton.enabled = YES;
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
    inTrial = NO;
    for (UILabel* label in labels)
        label.text = @"";
    [self changeHitMeButtonStatus:YES];
    clearButton.enabled = YES;
}

- (void) changeHitMeButtonStatus: (bool) enabled {
    if (enabled) {
        [hitMeButton setTitle:@"HIT ME" forState:UIControlStateNormal];
        [hitMeButton setTitle:@"HIT ME" forState:UIControlStateDisabled];
        [hitMeButton setTitle:@"HIT ME" forState:UIControlStateSelected];
        hitMeButton.enabled = YES;
    }
    else {
        hitMeButton.enabled = NO;
        [hitMeButton setTitle:@"WATCH FOR GREEN" forState:UIControlStateNormal];
        [hitMeButton setTitle:@"WATCH FOR GREEN" forState:UIControlStateDisabled];
        [hitMeButton setTitle:@"WATCH FOR GREEN" forState:UIControlStateSelected];
    }
}

@end
