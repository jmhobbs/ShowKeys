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
@property (weak) IBOutlet NSSlider *fontSizeSlider;
@property (weak) IBOutlet NSSlider *fadeOutSlider;
@property (weak) IBOutlet NSTextField *fadeOutDisplay;
@property (weak) IBOutlet NSTextField *maxCharsDisplay;
@property (weak) IBOutlet NSStepper *maxCharsStepper;

@end

@implementation PreferencesWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self updateFromConfig];
}

- (void)updateFromConfig {
    [_opacitySlider setIntegerValue:(int)([ConfigurationManager instance].opacity * 100.0)];
    [_fadeOutSlider setFloatValue:[ConfigurationManager instance].fadeTimeout / 0.25];
    [_fadeOutDisplay setStringValue:[NSString stringWithFormat:@"%0.02fs", [ConfigurationManager instance].fadeTimeout]];
    [_fontSizeSlider setIntegerValue:[ConfigurationManager instance].fontSize];
    [_textColorChooser setColor:[ConfigurationManager instance].textColor];
    [_maxCharsDisplay setIntegerValue:[ConfigurationManager instance].maxChars];
    [_maxCharsStepper setIntegerValue:[ConfigurationManager instance].maxChars];
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

- (IBAction)fontSizeSliderDidMove:(id)sender {
    [self.delegate fontSizeChanged:[sender integerValue]];
}

- (IBAction)stepperDidChange:(id)sender {
    [_maxCharsDisplay setIntegerValue:[sender integerValue]];
    [self.delegate maxCharsChanged:[sender integerValue]];
}

- (IBAction)resetButtonPressed:(id)sender {
    [[ConfigurationManager instance] reset];
    [self updateFromConfig];
    [self.delegate opacityChanged:[_opacitySlider floatValue]/100.0];
    [self.delegate fadeTimeoutChanged:0.25 * (float)[_fadeOutSlider intValue]];
    [_fadeOutDisplay setStringValue:[NSString stringWithFormat:@"%0.02fs", 0.25 * (float)[_fadeOutSlider intValue]]];
    [self.delegate textColorChanged:[_textColorChooser color]];
    [self.delegate fontSizeChanged:[_fontSizeSlider integerValue]];
    [self.delegate maxCharsChanged:[_maxCharsStepper integerValue]];
}

@end