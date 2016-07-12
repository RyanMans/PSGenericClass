//
//  PSMethodTools.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PSMethodTools.h"

#pragma mark -MAC OR iphone-

NSString *getVersion() {
    return [[UIDevice currentDevice] systemVersion];
}

NSString *getDeviceName() {
    return [[UIDevice currentDevice] model];
}


#pragma mark -Url 触发-
void openSMS(NSString *number)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",number]]];
}

void openUrl(NSString *url)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

void openCall(NSString *number)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
}

void openEmail(NSString *email)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",email]]];
}

void gotoAppStore(NSString *appid)
{
    NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8",appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark -时间 处理-
long long  getCurrentTimestamp ()
{
    NSDate * now = [NSDate date];
    NSTimeInterval terval = [now timeIntervalSince1970];
    return terval;
}

NSString * getCurrentDateString (NSString * format)
{
    if (format.length ==0 || format == nil) format = @"yyyy:MM:dd HH:mm:ss";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate * date = [NSDate date];
    NSString * dateString = [formatter stringFromDate:date];
    return dateString;
}

long long dateToTimestamp(NSDate *date)
{
    if (date == nil) return getCurrentTimestamp();
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval;
}

long long stringToTimestamp(NSString * time)
{
    if (time == nil || time.length == 0) return 0;

    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    NSDate  * date = [dateFormtter dateFromString:time];
    return dateToTimestamp(date);
}

NSDictionary* timestampToDictionary(long long timestamp)
{
    if (timestamp == 0) timestamp = NSTimeIntervalSince1970;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSArray * arr = [dateStr componentsSeparatedByString:@"-"];
    return @{@"year":arr[0],@"month":arr[1],@"day":arr[2],@"hour":arr[3],@"minute":arr[4],@"second":arr[5]};
}

NSString* timestampToString(long long timestamp)
{
    if ( timestamp == 0 )timestamp = NSTimeIntervalSince1970;
    
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateStr = [dateFormtter stringFromDate:date];
    return dateStr;
}

#pragma mark -Extend-
NSString *getPinyin(NSString * str,BOOL isShort)
{
    if (!str || str.length == 0) return @"";

    NSMutableString *source = [str mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    if (isShort)
    {
        NSArray *shorts = [source componentsSeparatedByString:@" "];
        NSMutableString *shortPy = [NSMutableString string];
        for (NSString *s in shorts)
        {
            if (s.length > 0)
            {
                [shortPy appendString:[s substringToIndex:1]];
            }
        }
        return shortPy;
    }else{
        return source;
    }
}

BOOL isEmailAddress(NSString * text)
{
    if (text.length == 0 || text == nil)return NO;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

BOOL isCharacter(NSString* text)
{
    if (text.length == 0 || text == nil)return NO;
    NSString * a = @"[a-zA-z]";
    NSPredicate *CharacterStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", a];
    return [CharacterStr evaluateWithObject:text];
}

BOOL isInterger(NSString *  text)
{
    if (text.length == 0 || text == nil)return NO;
    NSScanner  *scanner = [NSScanner scannerWithString:text];
    NSInteger uid = 0;
    return [scanner scanInteger:&uid] && [scanner isAtEnd];
}


BOOL isChineseTextInputMode()
{
    NSString * lang =  [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if (IsSameString(lang, @"zh-Hans")) return YES ;
    return NO;
}


