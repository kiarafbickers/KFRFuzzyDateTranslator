//
//  KFRFuzzyDateTranslatorSpec.m
//  KFRFuzzyDateTranslator
//
//  Created by Kiara Robles on 11/11/15.
//  Copyright 2015 kiaraRobles. All rights reserved.
//

#import <Expecta.h>
#import <Specta.h>
#import "KFRFuzzyDateTranslator.h"


SpecBegin(KFRFuzzyDateTranslator)

describe(@"KFRFuzzyDateTranslator", ^{
    
    __block KFRFuzzyDateTranslator *instance;
    __block NSString *string;
    __block id date;
    __block NSString *expetedDateString;
    __block NSDate *expetedDate;
    
    beforeEach(^{
        
        instance = [[KFRFuzzyDateTranslator alloc] initWithRelevantDate:@"29-FEB-16"];
        string = [[NSString alloc] init];
        date = nil;
        expetedDateString = [[NSString alloc] init];
        expetedDate = [[NSDate alloc] init];
        
    });
    
    describe(@"default initializer", ^{
        it(@"defalut calendar should be set to nil", ^{
            
            expect(instance.calendar).toNot.beNil();
        });
    });
    
    describe(@"testing -datesGeneral- properties translator for the February 29th, 2016 leap year", ^{
        it(@"should return torromorow", ^{
            string = @"I will do the thing tomorrow!";
            date = [instance dateFromString:string];
            expetedDateString = @"01-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return yesterday", ^{
            string = @"I did the thing yesterday...";
            date = [instance dateFromString:string];
            expetedDateString = @"28-FEB-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return today", ^{
            string = @"I'm doing that today?";
            date = [instance dateFromString:string];
            expetedDateString = @"29-FEB-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
    });
    
    describe(@"testing -next datesSpecificWeek- properties translator for the February 29th, 2016 leap year", ^{
        it(@"should return next week", ^{
            string = @"I should do the thing next week.";
            date = [instance dateFromString:string];
            expetedDateString = @"7-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Monday", ^{
            string = @"I should do the thing next Monday.";
            date = [instance dateFromString:string];
            expetedDateString = @"7-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Tuesday", ^{
            string = @"I should do the thing next Tuesday.";
            date = [instance dateFromString:string];
            expetedDateString = @"01-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Wednesday", ^{
            string = @"I should do the thing next Wednesday";
            date = [instance dateFromString:string];
            expetedDateString = @"02-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Thursday", ^{
            string = @"I should do the thing next Thursday.";
            date = [instance dateFromString:string];
            expetedDateString = @"03-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Friday", ^{
            string = @"I should do the thing next Friday.";
            date = [instance dateFromString:string];
            expetedDateString = @"04-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Saturday", ^{
            string = @"I should do the thing next Saturday.";
            date = [instance dateFromString:string];
            expetedDateString = @"05-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return next Sunday", ^{
            string = @"I should do the thing next Sunday.";
            date = [instance dateFromString:string];
            expetedDateString = @"06-MAR-16";
            expetedDate =[instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
    });
    
    describe(@"testing -last datesSpecificWeek- properties translator for the February 29th, 2016 leap year", ^{
        it(@"should return last week", ^{
            string = @"I did the thing last week.";
            date = [instance dateFromString:string];
            expetedDateString = @"28-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Monday", ^{
            string = @"I did the thing last Monday.";
            date = [instance dateFromString:string];
            expetedDateString = @"22-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Tuesday", ^{
            string = @"I did the thing last Tuesday.";
            date = [instance dateFromString:string];
            expetedDateString = @"23-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Wednesday", ^{
            string = @"I did the thing last Wednesday";
            date = [instance dateFromString:string];
            expetedDateString = @"24-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Thursday", ^{
            string = @"I did the thing last Thursday.";
            date = [instance dateFromString:string];
            expetedDateString = @"25-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Friday", ^{
            string = @"I did the thing last Friday.";
            date = [instance dateFromString:string];
            expetedDateString = @"26-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Saturday", ^{
            string = @"I did the thing last Saturday.";
            date = [instance dateFromString:string];
            expetedDateString = @"27-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return last Sunday", ^{
            string = @"I did the thing last Sunday.";
            date = [instance dateFromString:string];
            expetedDateString = @"28-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
    });
    
    describe(@"testing -this datesSpecificWeek- properties translator for the February 29th, 2016 leap year", ^{
        it(@"should return this week", ^{
            string = @"I should do the thing this week.";
            date = [instance dateFromString:string];
            expetedDateString = @"01-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Monday", ^{
            string = @"I did the thing this Monday.";
            date = [instance dateFromString:string];
            expetedDateString = @"29-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Tuesday", ^{
            string = @"I will do the thing this Tuesday.";
            date = [instance dateFromString:string];
            expetedDateString = @"01-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Wednesday", ^{
            string = @"I will do the thing this Wednesday";
            date = [instance dateFromString:string];
            expetedDateString = @"02-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Thursday", ^{
            string = @"I will do the thing this Thursday.";
            date = [instance dateFromString:string];
            expetedDateString = @"03-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Friday", ^{
            string = @"I will do the thing this Friday.";
            date = [instance dateFromString:string];
            expetedDateString = @"04-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Saturday", ^{
            string = @"I will do the thing this Saturday.";
            date = [instance dateFromString:string];
            expetedDateString = @"05-MAR-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
        
        it(@"should return this Sunday", ^{
            string = @"I will do the thing this Sunday.";
            date = [instance dateFromString:string];
            expetedDateString = @"28-FEB-16";
            expetedDate = [instance returnDateAtMidnight:expetedDateString];
            
            expect(date).to.beIdenticalTo(expetedDate);
        });
    });
});

SpecEnd
