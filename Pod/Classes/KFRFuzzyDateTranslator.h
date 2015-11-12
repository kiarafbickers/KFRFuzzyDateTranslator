//
//  KFRFuzzyDateTranslator.h
//  KFRFuzzyDateTranslator
//
//  Created by Kiara Robles on 11/11/15.
//  Copyright © 2015 kiaraRobles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFRFuzzyDateTranslator : NSObject

@property (nonatomic, strong) NSString *string;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, readonly, copy) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *relevantDate;
@property (readonly) NSInteger month;
@property (readonly) NSUInteger weekday;

- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithRelevantDate:(NSString *)dateString;
- (id) dateFromString:(NSString *)string;
- (NSDate *) returnDateAtMidnight: (NSString *)dateString;

@end