//
//  RDHDateComponentPicker.m
//  RDHDateComponentPicker
//
//  Created by Richard Hodgkins on 13/08/2014.
//  Copyright (c) 2014 Rich Hodgkins. All rights reserved.
//

#import "RDHDateComponentPicker.h"

static RDHDateComponent const RDHDateComponentsDate = RDHDateComponentYear | RDHDateComponentMonth | RDHDateComponentDay;
static RDHDateComponent const RDHDateComponentsTime = RDHDateComponentHour | RDHDateComponentMinute;
static RDHDateComponent const RDHDateComponentsDateAndTime = RDHDateComponentsDate | RDHDateComponentsTime;

static BOOL RDHDateComponentsIsStandardPickerComponents(RDHDateComponent components)
{
    return components == RDHDateComponentsDate || components == RDHDateComponentsTime || components == RDHDateComponentsDateAndTime;
}

@interface RDHDateComponentPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) UIView *picker;

@property (nonatomic, weak, readonly) UIDatePicker *standardPicker;
@property (nonatomic, weak, readonly) UIPickerView *customPicker;

@end

@implementation RDHDateComponentPicker

+(instancetype)autolayoutDatePickerWithComponents:(RDHDateComponent)components
{
    RDHDateComponentPicker *picker = [self datePickerWithComponents:components];
    picker.translatesAutoresizingMaskIntoConstraints = NO;
    return picker;
}

+(instancetype)datePickerWithComponents:(RDHDateComponent)components
{
    return [self datePickerWithFrame:CGRectZero components:components];
}

+(instancetype)datePickerWithFrame:(CGRect)frame components:(RDHDateComponent)components
{
    return [[self alloc] initWithFrame:frame components:components];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame components:RDHDateComponentsDateAndTime];
}

-(instancetype)initWithFrame:(CGRect)frame components:(RDHDateComponent)components
{
    self = [super initWithFrame:frame];
    if (self) {
        _components = components;
        
    }
    return self;
}

-(UIDatePicker *)standardPicker
{
    if ([self.picker isKindOfClass:[UIDatePicker class]]) {
        return (UIDatePicker *)self.picker;
    } else {
        return nil;
    }
}

-(UIPickerView *)customPicker
{
    if ([self.picker isKindOfClass:[UIPickerView class]]) {
        return (UIPickerView *)self.picker;
    } else {
        return nil;
    }
}

-(void)setComponents:(RDHDateComponent)components
{
    if (_components != components) {
        RDHDateComponent previousComponents = _components;
        _components = components;
        
        [self updatePickerFromPreviousComponents:previousComponents];
    }
}

-(void)updatePickerFromPreviousComponents:(RDHDateComponent)previousComponents
{
    UIView *picker = nil;
    
    BOOL needsNewPicker = RDHDateComponentsIsStandardPickerComponents(self.components) == RDHDateComponentsIsStandardPickerComponents(previousComponents);
    
    if (RDHDateComponentsIsStandardPickerComponents(self.components)) {
        
        UIDatePicker *standardPicker;
        if (needsNewPicker) {
            standardPicker = [[UIDatePicker alloc] initWithFrame:self.bounds];
            picker = standardPicker;
        } else {
            standardPicker = self.standardPicker;
        }
        switch (self.components) {
            case RDHDateComponentsDate:
                standardPicker.datePickerMode = UIDatePickerModeDate;
                break;
                
            case RDHDateComponentsTime:
                standardPicker.datePickerMode = UIDatePickerModeTime;
                break;
                
            case RDHDateComponentsDateAndTime:
                standardPicker.datePickerMode = UIDatePickerModeDateAndTime;
                break;
                
            default:
                // Can't happen
                break;
        }
        
    } else {
        // Custom
        UIPickerView *customPicker;
        if (needsNewPicker) {
            customPicker = [[UIPickerView alloc] initWithFrame:self.bounds];
            picker = customPicker;
        } else {
            customPicker = self.customPicker;
        }
        customPicker.dataSource = self;
        customPicker.delegate = self;
    }
    
    if (picker == self.picker) {
        // Just refresh
        [self.customPicker reloadAllComponents];

    } else {
        picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.picker removeFromSuperview];
        [self addSubview:picker];
        self.picker = picker;
    }
}

#pragma mark - Properties

-(void)setLocale:(NSLocale *)locale
{
    self.standardPicker.locale = locale;
    if (![_locale isEqual:locale]) {
        _locale = locale;
        
        [self.customPicker reloadAllComponents];
    }
}

-(void)setCalendar:(NSCalendar *)calendar
{
    self.standardPicker.calendar = calendar;
    if (![_calendar isEqual:calendar]) {
        _calendar = [calendar copy];
        
        [self.customPicker reloadAllComponents];
    }
}

-(void)setTimeZone:(NSTimeZone *)timeZone
{
    self.standardPicker.timeZone = timeZone;
    if (![_timeZone isEqual:timeZone]) {
        _timeZone = timeZone;
        
        [self.customPicker reloadAllComponents];
    }
}

-(void)setMinimumDate:(NSDate *)minimumDate
{
    self.standardPicker.minimumDate = minimumDate;
    if (![_minimumDate isEqual:minimumDate]) {
        _minimumDate = minimumDate;
        
        [self.customPicker reloadAllComponents];
    }
}

-(void)setMaximumDate:(NSDate *)maximumDate
{
    self.standardPicker.maximumDate = maximumDate;
    if (![_maximumDate isEqual:maximumDate]) {
        maximumDate = maximumDate;
        
        [self.customPicker reloadAllComponents];
    }
}

-(void)setMinuteInterval:(NSInteger)minuteInterval
{
    self.standardPicker.minuteInterval = minuteInterval;
    if (_minuteInterval != minuteInterval) {
        _minuteInterval = minuteInterval;
        
        // TODO: only reload minute component
        [self.customPicker reloadAllComponents];
    }
}

-(void)setSecondInterval:(NSInteger)secondInterval
{
    if (_secondInterval != secondInterval) {
        _secondInterval = secondInterval;
        
        // TODO: only reload second component
        [self.customPicker reloadAllComponents];
    }
}

-(void)setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}

-(void)setDate:(NSDate *)date animated:(BOOL)animated
{
    [self.standardPicker setDate:date animated:animated];
    if (![_date isEqual:date]) {
        _date = date;
        
        // TODO: set selected items on custom picker
        [self.customPicker selectRow:0 inComponent:0 animated:animated];
    }
}

#pragma mark - Picker view data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    // TODO: return number of components
    // TODO: don't forget AM/PM
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // TODO: depending on component return the correct number of components, e.g. hour 24
    // TODO: don't forget AM/PM
    return 0;
}

#pragma mark - Picker view delegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // TODO: date components use NSDateFormatStyleMedium
    // TODO: time components seperate
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // TODO: set date from components and rows
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - 

-(NSInteger)pickerComponentForDateComponent:(RDHDateComponent)component inComponents:(RDHDateComponent)components
{
    // TODO:
    return 0;
}

@end
