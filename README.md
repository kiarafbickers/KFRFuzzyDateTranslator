# KFRFuzzyDateTranslator
---

[![CI Status](http://img.shields.io/travis/kiaraRobles/KFRFuzzyDateTranslator.svg?style=flat)](https://travis-ci.org/kiaraRobles/KFRFuzzyDateTranslator)
[![Version](https://img.shields.io/cocoapods/v/KFRFuzzyDateTranslator.svg?style=flat)](http://cocoapods.org/pods/KFRFuzzyDateTranslator)
[![License](https://img.shields.io/cocoapods/l/KFRFuzzyDateTranslator.svg?style=flat)](http://cocoapods.org/pods/KFRFuzzyDateTranslator)
[![Platform](https://img.shields.io/cocoapods/p/KFRFuzzyDateTranslator.svg?style=flat)](http://cocoapods.org/pods/KFRFuzzyDateTranslator)

## What is this?

Are you tired of the date spinner thingy? Well, I am! 

<center>![Screenshot](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uidatepicker_intro_2x.png)</center>

This pod was developed to convert a NSString into a NSDate object so you dont have to use that date spinner anymore!
Yay.

Developed and tested in Xcode 7.

Currently only Objective-C is supported.

## How do I use it?
The string "next Monday" returns the NSDate object of the next Monday, relative to today. The class interprets fuzzy human readable words to an exact date at midnight. Currently, the days of the week are supported with the prefix "next", "this", or "last", as well as the words "yesterday", "tomorrow", and "today".

### Days this week:
![Screenshot](http://imgur.com/2bl8bRK.png)

### Days next week:
![Screenshot](http://imgur.com/4S8B91p.png)

### Days last week:
![Screenshot](http://imgur.com/TgSAweE.png)

## Several ways to use the class:
1. Initialize an instance of the KFRFuzzyDateTranslator class and a NSString object. Call the "dateFromString:" method on the string, then catch the return in a type id object. (This typically returns a NSDate object. Unless the strings input is invalid, in which case it returns a string error message). The default initializer translates from the current date and time zone. 

        KFRFuzzyDateTranslator instance = [[KFRFuzzyDateTranslator alloc] init];
        NSString *string = @"I'll do the thing tomorrow!";
        id date = [instance dateFromString:string];

2. Initialize an instance of the KFRFuzzyDateTranslator class with a string property. Call the "dateFromString:" method on the instance string property. Then catch the return in a type id object.

        KFRFuzzyDateTranslator *instance = [[KFRFuzzyDateTranslator alloc] initWithString:@"I did it last week!"];
        id date = [instance dateFromString:instance.string];

3. Initialize an instance of the KFRFuzzyDateTranslator class with a relative start date. Call the "dateFromString:" method on the input string, then catch the return in a type id object. This init method is intended primarily for testing purposes.

        KFRFuzzyDateTranslator *instance = [[KFRFuzzyDateTranslator alloc] initWithRelevantDate:@"01-JAN-70"];
        id date = [instance dateFromString:instance.string];

## Possible future improvements

Ideas for people who might want to hack on this:

1. Add time, month, years, and other cultural interpretations of relative time indicators.
2. Add an example project


## Installation

KFRFuzzyDateTranslator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KFRFuzzyDateTranslator"
```

## Author

kiaraRobles, kiara.robles@gmail.com

## License

KFRFuzzyDateTranslator is available under the MIT license. See the LICENSE file for more info.

MIT License

Copyright (c) 2015 Kiara Robles

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
