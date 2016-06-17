//
//  NSString+PS.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//


#import "NSString+PS.h"
#import "PinYin4Objc.h"
@implementation NSString (PS)

- (NSString *)removeWSSpace
{
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"^\\s+|\\s+$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:NULL];
    NSString *str = [regular stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    return str;
}

- (BOOL)isInterger
{
    NSScanner  *scanner = [NSScanner scannerWithString:self];
    NSInteger uid = 0;
    return [scanner scanInteger:&uid] && [scanner isAtEnd];
}

- (NSData *)toData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
- (id)jsonToObject
{
    NSError *error = nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!jsonData) {
        return nil;
    }
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        return nil;
    }
    return obj;
}

- (NSString*)isEffectiveMobileNumber
{
    // 是否是有效手机号码
    if (self.length == 11 && self.isMobileNumber)
    {
        return self;
    }
    return @"";
}


//正则判断手机号码格式
- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /*
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        
        if([regextestcm evaluateWithObject:self] == YES) {
        } else if([regextestct evaluateWithObject:self] == YES) {
        } else if ([regextestcu evaluateWithObject:self] == YES) {
        } else {
        }
        return YES;
    }
    else
    {
        return NO;
    }
}
- (NSString *)onlyNumbers
{
    if (nil == self) return nil;
    if (0 == self.length) return @"";
    
    unichar c = 0;
    NSMutableString *temp = [NSMutableString stringWithCapacity:self.length];
    for (NSUInteger a = 0; a < self.length; ++a)
    {
        c = [self characterAtIndex:a];
        if (c < '0') continue;
        if (c > '9') continue;
        [temp appendFormat:@"%C", c];
    }
    return temp;
}

- (NSString *)toPinyinEx:(BOOL)isShort
{
    if (0 == self.length) return @"";
    
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    outputFormat.toneType = ToneTypeWithoutTone;
    outputFormat.vCharType = VCharTypeWithV;
    outputFormat.caseType = (isShort ? CaseTypeUppercase : CaseTypeLowercase);
    
    if (isShort)
    {
        NSString *temp = [PinyinHelper toHanyuPinyinStringWithNSString:[self substringToIndex:1] withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
        if (temp.length) return [temp substringToIndex:1].uppercaseString;
        return temp;
    }
    
    NSString *temp = [PinyinHelper toHanyuPinyinStringWithNSString:self withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return temp;
}

@end
