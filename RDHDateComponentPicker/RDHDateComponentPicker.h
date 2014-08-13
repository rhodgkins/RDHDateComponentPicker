//
//  RDHDateComponentPicker.h
//  RDHDateComponentPicker
//
//  Created by Richard Hodgkins on 13/08/2014.
//  Copyright (c) 2014 Rich Hodgkins. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, RDHDateComponent)
{
    RDHDateComponentYear = (1UL << 1),
    RDHDateComponentMonth = (1UL << 2),
    RDHDateComponentDay = (1UL << 3),
    
    RDHDateComponentHour = (1UL << 4),
    RDHDateComponentMinute = (1UL << 5),
    RDHDateComponentSecond = (1UL << 6),
    
    RDHDateComponent_yyyyMMdd = RDHDateComponentYear | RDHDateComponentMonth | RDHDateComponentDay,
    
    RDHDateComponent_HHmmss = RDHDateComponentHour | RDHDateComponentMinute | RDHDateComponentSecond,
    
    RDHDateComponent_HHmm = RDHDateComponentHour | RDHDateComponentMinute
};

@interface RDHDateComponentPicker : UIControl

+(instancetype)autolayoutDatePickerWithComponents:(RDHDateComponent)components;

+(instancetype)datePickerWithComponents:(RDHDateComponent)components;

+(instancetype)datePickerWithFrame:(CGRect)frame components:(RDHDateComponent)components;

/// Designated initializer
-(instancetype)initWithFrame:(CGRect)frame components:(RDHDateComponent)components;


/// Defaults to date and time components (yyyyMMdd HHmm)
@property (nonatomic) RDHDateComponent components;

/// Default is [NSLocale currentLocale]. setting nil returns to default
@property (nonatomic, strong) NSLocale *locale;

/// Default is [NSCalendar currentCalendar]. setting nil returns to default
@property (nonatomic, copy) NSCalendar *calendar;

/// Default is nil. use current time zone or time zone from calendar
@property (nonatomic, strong) NSTimeZone *timeZone;

/// Default is current date when picker created. Ignored in countdown timer mode. for that mode, picker starts at 0:00
@property (nonatomic, strong) NSDate *date;
/// Specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nonatomic, strong) NSDate *minimumDate;
/// Default is nil
@property (nonatomic, strong) NSDate *maximumDate;

/// Display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
@property (nonatomic) NSInteger minuteInterval;

/// Display seconds wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
@property (nonatomic) NSInteger secondInterval;

/// If animated is YES, animate the wheels of time to display the new date
-(void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

