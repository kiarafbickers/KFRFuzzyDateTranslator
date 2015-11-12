//
//  KFRFuzzyDateTranslator.m
//  KFRFuzzyDateTranslator
//
//  Created by Kiara Robles on 11/11/15.
//  Copyright © 2015 kiaraRobles. All rights reserved.
//

#import "KFRFuzzyDateTranslator.h"

typedef NS_ENUM(NSInteger, enumDay) {
    sunday = 1,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
};

@interface KFRFuzzyDateTranslator ( )

@property (nonatomic, readwrite) NSDate *date;
@property (nonatomic, readwrite, copy) NSCalendar *calendar;
@property (nonatomic, readwrite, copy) NSDateComponents *comps;
@property (nonatomic, readwrite, copy) NSDateComponents *comps2;
@property (nonatomic, readwrite, copy) NSDateComponents *travelDateTimeComponents;
@property (readwrite) NSUInteger weekday;
@property (readwrite) NSInteger month;
@property (readwrite) NSInteger year;
@property (nonatomic) NSSet *datesGeneral;
@property (nonatomic) NSSet *datesSpecificWeek;
@property (nonatomic, strong) NSMutableArray *wordsArray;
@property (nonatomic, readwrite, copy) NSDateComponents *deltaComps;
@property (nonatomic) enumDay nextDay;
@property (nonatomic) NSString *wordIndex1;
@property (nonatomic) NSString *wordIndex2;
@property (nonatomic) bool isDatesGeneral;
@property (nonatomic) bool isDatesSpecificWeek;
@property (nonatomic) bool isBoolBust;
@property bool isToday;
@property bool isTomorrow;
@property bool isYesterday;

@end

@implementation KFRFuzzyDateTranslator

- (instancetype) init {
    self = [super init];
    if (self) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _relevantDate = [self currentDateInSystemTimezone:[NSDate date]];
        _comps = [self.calendar components:NSCalendarUnitWeekday fromDate:self.relevantDate];
        _weekday = [self.comps weekday];
        [self setupSetsForComparison];
    }
    return self;
}
-(void) setupSetsForComparison {
    _datesGeneral = [NSSet setWithObjects: @"today", @"tomorrow", @"yesterday", nil];
    _datesSpecificWeek = [NSSet setWithObjects: @"monday", @"tuesday", @"wednesday", @"thursday", @"friday", @"saturday", @"sunday", @"week", nil];
}
- (instancetype) initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        _string = string;
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _relevantDate = [self currentDateInSystemTimezone:[NSDate date]];
        _comps = [self.calendar components:NSCalendarUnitWeekday fromDate:self.relevantDate];
        _weekday = [self.comps weekday];
        [self setupSetsForComparison];
    }
    return self;
}
- (instancetype) initWithRelevantDate:(NSString *)dateString {
    self = [super init];
    if (self) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _dateString = dateString;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MMM-yy";
        
        // Convert to date at midnight
        NSDate *const date = [dateFormatter dateFromString:dateString];
        NSCalendar *const calendar = NSCalendar.currentCalendar;
        NSCalendarUnit const preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
        NSDateComponents *const components = [calendar components:preservedComponents fromDate:date];
        _relevantDate = [calendar dateFromComponents:components];
        
        
        //_relevantDate = [dateFormatter dateFromString:dateString];
        _comps = [self.calendar components:NSCalendarUnitWeekday fromDate:self.relevantDate];
        _comps2 = [self.calendar components:NSCalendarUnitMonth fromDate:self.relevantDate];
        _weekday = [self.comps weekday];
        _month = [self.comps2 month];
        
        [self setupSetsForComparison];
    }
    return self;
}
- (NSDate *) currentDateInSystemTimezone: (NSDate *)relevantDate {
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    return destinationDate;
}
- (NSDate *) returnDateAtMidnight: (NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MMM-yy";
    
    // Convert to date at midnight
    NSDate *const date = [dateFormatter dateFromString:dateString];
    NSCalendar *const calendar = NSCalendar.currentCalendar;
    NSCalendarUnit const preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *const components = [calendar components:preservedComponents fromDate:date];
    NSDate *dateAtMidnight = [calendar dateFromComponents:components];
    
    return dateAtMidnight;
}
- (NSMutableArray *) stringToWordArray:(NSString *)string {
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *strippedReplacement = [[string componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@" "];
    strippedReplacement = [strippedReplacement lowercaseString];
    NSArray *wordsArray = [strippedReplacement componentsSeparatedByString:@" "];
    
    return [wordsArray mutableCopy];
}
- (enumDay) createDayFromDateValue:(NSString *)dateValue {
    enumDay nextDay;
    
    if ([dateValue isEqualToString:@"monday"]) {
        nextDay = monday;
    } else if ([dateValue isEqualToString:@"tuesday"]) {
        nextDay = tuesday;
    } else if ([dateValue isEqualToString:@"wednesday"]) {
        nextDay = wednesday;
    } else if ([dateValue isEqualToString:@"thursday"]) {
        nextDay = thursday;
    } else if ([dateValue isEqualToString:@"friday"]) {
        nextDay = friday;
    } else if ([dateValue isEqualToString:@"saturday"]) {
        nextDay = saturday;
    } else if ([dateValue isEqualToString:@"sunday"]) {
        nextDay = sunday;
    }
    return nextDay;
}
// Helper methods
- (enumDay) assignEnumday:(NSString *)word2 {
    NSString *dateValue = [self.datesSpecificWeek member:word2];
    enumDay day = [self createDayFromDateValue:dateValue];
    
    return day;
}

//**//**||============================================================||**\\**\\
//                       TRANSLATE DATE FROM STRING
//**//**||============================================================||**\\**\\

- (id) dateFromString:(NSString *)string {
    NSMutableArray *wordsArray = [self stringToWordArray:string];
    
    // Match the words in the input array to the values in NSSet
    NSInteger boolTotal = -1;
    for (NSUInteger i = 0; i < wordsArray.count - 1; i++) {
        NSString *wordIndex1 = [wordsArray objectAtIndex:i];
        NSString *wordIndex2 = [wordsArray objectAtIndex:i+1];
        
        bool isDatesGeneral = [self.datesGeneral containsObject:wordIndex2];
        bool isDatesSpecificWeek = [self.datesSpecificWeek containsObject:wordIndex2];
        
        int intDatesGeneral = (isDatesGeneral ? 1 : 0);
        int intDatesSpecificWeek = (isDatesSpecificWeek ? 1 : 0);
        
        if (boolTotal ==  -1) {
            boolTotal = 0;
        }
        boolTotal = intDatesGeneral + intDatesSpecificWeek + boolTotal;
        if (boolTotal == 1 && !(wordIndex1 == self.wordIndex2)) {
            self.isDatesGeneral = [self.datesGeneral containsObject:wordIndex2];
            if (self.isDatesGeneral == YES) {
                self.isToday = [wordIndex2 isEqualToString:@"today"];
                self.isYesterday = [wordIndex2 isEqualToString:@"yesterday"];
                self.isTomorrow = [wordIndex2 isEqualToString:@"tomorrow"];
            }
            self.isDatesSpecificWeek = [self.datesSpecificWeek containsObject:wordIndex2];
            self.wordIndex1 = wordIndex1;
            self.wordIndex2 = wordIndex2;
        }
    }
    if (boolTotal == 1) {
        return [self returnDate];
    }
    else {
        return @"Not a valid entry.";
    }
    
    return nil;
}
- (NSDate *) returnDate {
    //**//**||============================================================||**\\**\\
    //                              General Day
    //**//**||============================================================||**\\**\\
    
    if (self.isToday || self.isTomorrow || self.isYesterday) {
        
        NSInteger delta = 0;
        if (self.isYesterday) {
            delta = -1;
        }
        else if (self.isTomorrow) {
            delta = 1;
        }
        
        NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
        [deltaComps setDay:delta];
        self.date = [self.calendar dateByAddingComponents:deltaComps toDate:self.relevantDate options:0];
    }
    
    //**//**||============================================================||**\\**\\
    //                               DAY OF WEEK
    //**//**||============================================================||**\\**\\
    
    else if ([self.wordIndex1 isEqualToString:@"next"] && self.isDatesSpecificWeek == YES) {
        
        // Define the matching word and assign it to a NSUInteger enum
        enumDay day = [self assignEnumday:self.wordIndex2];
        
        // Define next week as == "next monday"
        if ([self.wordIndex2 isEqualToString:@"week"]) {
            day = 2;
        }
        
        // Calulate the value of the next week day based on the current day
        NSInteger delta = [self nextWeekDeltaFromCurrentDay:day];
        
        // Add delta to the current day
        NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
        [deltaComps setDay:delta];
        self.date = [self.calendar dateByAddingComponents:deltaComps toDate:self.relevantDate options:0];
    }
    else if ([self.wordIndex1 isEqualToString:@"last"] && self.isDatesSpecificWeek == YES) {
        
        enumDay day = [self assignEnumday:self.wordIndex2];
        
        // Define next week as == "last sunday"
        if ([self.wordIndex2 isEqualToString:@"week"]) {
            day = 1;
        }
        
        NSInteger delta = [self lastWeekDeltaFromCurrentDay:day];
        delta = -delta;
        
        NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
        [deltaComps setDay:delta];
        self.date = [self.calendar dateByAddingComponents:deltaComps toDate:self.relevantDate options:0];
    }
    else if ([self.wordIndex1 isEqualToString:@"this"] && self.isDatesSpecificWeek == YES) {
        
        NSInteger delta = 0;
        enumDay day = [self assignEnumday:self.wordIndex2];
        NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
        
        // Define this week as == "Tomorrow"
        if ([self.wordIndex2 isEqualToString:@"week"]) {
            delta = 1;
            [deltaComps setDay:delta];
        }
        else {
            delta = [self thisWeekDeltaFromCurrentDay:day];
            [deltaComps setDay:delta];
        }
        
        self.date = [self.calendar dateByAddingComponents:deltaComps toDate:self.relevantDate options:0];
    }
    
    [self.calendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents * comp = [self.calendar components:( NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self.date];
    [comp setHour:0];
    [comp setMinute:0];
    [comp setHour:0];
    NSDate *startOfToday = [self.calendar dateFromComponents:comp];
    self.date = startOfToday;
    
    return self.date;
}

//**//**||============================================================||**\\**\\
//                             CORE METHODS
//**//**||============================================================||**\\**\\

- (NSUInteger) nextWeekDeltaFromCurrentDay:(enumDay)day {
    NSInteger delta = 0;
    NSUInteger week = 7;
    
    delta = (week + day - self.weekday) % week;
    
    if (delta == 0) {
        delta = 7;
    }
    
    return delta;
}
- (NSUInteger) lastWeekDeltaFromCurrentDay:(enumDay)day {
    NSInteger delta = 0;
    NSUInteger week = 7;
    
    delta = (week + self.weekday - day) % week;
    
    if (delta == 0) {
        delta = 7;
    }
    
    return delta;
}

- (NSUInteger) thisWeekDeltaFromCurrentDay:(enumDay)day {
    NSInteger delta = 0;
    
    if (day == self.weekday) {
        delta = 0;
    }
    else if (day < self.weekday) {
        delta = self.weekday - day;
        delta = -delta;
    }
    else if (day > self.weekday) {
        delta = day - self.weekday;
    }
    
    return delta;
}

@end