//
//  PreferencesWindowController.m
//  ShowKeys
//
//  Created by John Hobbs on 6/24/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "ConfigurationManager.h"

@interface PreferencesWindowController ()

@property (weak) IBOutlet NSSlider *opacitySlider;
@property (weak) IBOutlet NSColorWell *textColorChooser;
@property (weak) IBOutlet NSSlider *fadeOutSlider;
@property (weak) IBOutlet NSTextField *fadeOutDisplay;

@end

@implementation PreferencesWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [_opacitySlider setIntegerValue:(int)([ConfigurationManager instance].opacity * 100.0)];
    [_fadeOutSlider setFloatValue:[ConfigurationManager instance].fadeTimeout / 0.25];
    [_fadeOutDisplay setStringValue:[NSString stringWithFormat:@"%0.02fs", [ConfigurationManager instance].fadeTimeout]];
    [_textColorChooser setColor:[ConfigurationManager instance].textColor];
}

- (IBAction)sliderDidMove:(id)sender {
    [self.delegate opacityChanged:[sender floatValue]/100.0];
}

- (IBAction)textColorDidChange:(id)sender {
    [self.delegate textColorChanged:[sender color]];
}

- (IBAction)fadeOutSliderDidMove:(id)sender {
    float seconds = 0.25 * (float)[sender intValue];
    if(seconds == 0.0) {
        [_fadeOutDisplay setStringValue:@"Never"];
    }
    else {
        [_fadeOutDisplay setStringValue:[NSString stringWithFormat:@"%0.02fs", seconds]];
    }
    [self.delegate fadeTimeoutChanged:seconds];
}

@end