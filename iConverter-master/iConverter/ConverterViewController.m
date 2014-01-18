//
//  ConverterViewController.m
//  iConverter
//
//  Created by Vinu Charanya on 10/9/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import "ConverterViewController.h"

@interface ConverterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fahrenheitTextField;
@property (weak, nonatomic) IBOutlet UITextField *celsiusTextField;
- (IBAction)onTap:(id)sender;

- (float) celsiusFromFahrenheit: (float) fahrenheit;

- (void) updateCelsiusTextField;

- (void) updateFahrenheitTextField;

- (void)initializeTextFields;

- (float) fahrenheitFromCelsius: (float) celsius;

@end

@implementation ConverterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"iConverter";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeTextFields];
}

- (void) initializeTextFields{
    self.fahrenheitTextField.text = [NSString stringWithFormat:@"%.1f", 32.0];
    self.celsiusTextField.text = [NSString stringWithFormat:@"%.1f", [self celsiusFromFahrenheit:32.0]];
    self.celsiusTextField.delegate = (id<UITextFieldDelegate>)self;
    self.fahrenheitTextField.delegate = (id<UITextFieldDelegate>)self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.fahrenheitTextField) {
        self.celsiusTextField.text = @"";
    } else if (textField == self.celsiusTextField) {
        self.fahrenheitTextField.text = @"";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.fahrenheitTextField) {
        [self updateCelsiusTextField];
    } else if (textField == self.celsiusTextField) {
        [self updateFahrenheitTextField];
    }
    return;
}

- (float) fahrenheitFromCelsius: (float) celsius {
    return celsius * 9/5 + 32;
}

- (float) celsiusFromFahrenheit: (float) fahrenheit {
    return ((fahrenheit - 32) * 5)/9;
}


- (void) updateCelsiusTextField{
    float fahrenheit = [self.fahrenheitTextField.text floatValue];
    float celsius = [self celsiusFromFahrenheit:fahrenheit];
    self.celsiusTextField.text = [NSString stringWithFormat:@"%0.1f", celsius];

}

- (void) updateFahrenheitTextField{
    float celsius = [self.celsiusTextField.text floatValue];
    float fahrenheit = [self fahrenheitFromCelsius:celsius];
    self.fahrenheitTextField.text = [NSString stringWithFormat:@"%0.1f", fahrenheit];
}
@end
