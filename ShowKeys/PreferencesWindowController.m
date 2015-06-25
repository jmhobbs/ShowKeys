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

@end

@implementation PreferencesWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [_opacitySlider setIntegerValue:(int)([ConfigurationManager instance].opacity * 100.0)];
    [_textColorChooser setColor:[ConfigurationManager instance].textColor];
}

- (IBAction)sliderDidMove:(id)sender {
    [self.delegate opacityChanged:[sender floatValue]/100.0];
}

- (IBAction)textColorDidChange:(id)sender {
    [self.delegate textColorChanged:[sender color]];
}

@end