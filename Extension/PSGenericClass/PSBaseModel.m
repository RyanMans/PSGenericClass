//
//  PSBaseModel.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSBaseModel.h"
#import "YYClassInfo.h"

#define IsUserMJ   0 //1 使用mj 转模型框架  ，0 使用yy转模型框架

@implementation PSBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
#if IsUserMJ
        
#else
        [self checkModelProperty];
#endif
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary*)dict
{
    //后期想更换转模型框架， 只需修改这里
    LogFunctionName();
    
    if (dict.count == 0 || !dict)  return [PSBaseModel new];;
    
#if IsUserMJ
    
    return [self mj_objectWithKeyValues:dict];
#else
    
    return [self yy_modelWithDictionary:dict];
#endif
    
    return NewClass(PSBaseModel);
}
+ (NSArray*)modelWithKeyValuesArrays:(NSArray*)arrays
{
     //后期想更换转模型框架， 只需修改这里
    
    if (arrays.count == 0 || !arrays)  return @[];
    
    LogFunctionName();
#if IsUserMJ
    
    return [self mj_objectArrayWithKeyValuesArray:arrays];
#else
    
    return [NSArray yy_modelArrayWithClass:self json:arrays];
#endif
    return @[];
}

- (NSDictionary*)dictionary
{
     // 获取原属性 key value
    //后期想更换转模型框架， 只需修改这里
    LogFunctionName();

#if IsUserMJ
    
    return self.mj_keyValues;
#else
    
    return (NSDictionary*)[self yy_modelToJSONObject];
    
#endif
    return @{};
}

+ (NSArray*)keyValuesArrayWithObjectArray:(NSArray *)models
{
    if (models.count == 0 || !models)  return @[];
    
#if IsUserMJ
    
    return [NSArray mj_keyValuesArrayWithObjectArray:models];;
#else
    
    NSMutableArray * temp = NewMutableArray();
    for (PSBaseModel * model in models)
    {
        NSDictionary * dict = [model dictionary];
        if (dict.count) {
            [temp addObject:dict];
        }
    }
    return temp.count ? temp : @[];
    
#endif
    return @[];
}

#pragma mark -不同框架校验对象属性-
// 旧值换新值，用于过滤字典中的值 保证模型属性不会出现nil
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property;
{
    LogFunctionName();
    if (IsKindOfClass(property.type.typeClass, NSString))
    {
        if (oldValue == nil || IsKindOfClass(oldValue, NSNull) || oldValue == NULL) return @"";
    }
    else if (IsKindOfClass(property.type.typeClass, NSArray))
    {
        if (oldValue == nil) return @[];
    }
    else if (IsKindOfClass(property.type.typeClass, NSDictionary))
    {
        if (oldValue == nil) return @{};
    }
    else if (IsKindOfClass(property.type.typeClass, NSNumber))
    {
        if (oldValue == nil) return @(0);
    }
    else if (IsKindOfClass(property.type.typeClass, NSObject))
    {
        if (oldValue == nil)return [property.type.typeClass new];
    }
    return oldValue;
}

//通用版，使用运行时校验模型属性
- (void)checkModelProperty
{
    //使用运行时 校验 模型属性
    
    unsigned int number;
    
    Ivar * vars = class_copyIvarList(NSClassFromString([[self class] description]), &number);
    
    NSString * varName = nil;
    NSString * varType = nil;
    
    for (int i = 0 ; i < number; i ++)
    {
        Ivar  temp = vars[i];
        
        varName = [NSString stringWithUTF8String:ivar_getName(temp)];
        
        varType = [NSString stringWithUTF8String:ivar_getTypeEncoding(temp)];
        
        id value = [self valueForKey:varName];
        
        if (!value)
        {
            if (IsSameString(varType, @"@\"NSNumber\""))
            {
                [self setValue:@0 forKey:varName];
            }
            else if (IsSameString(varType, @"@\"NSString\"") || IsSameString(varType, @"@\"NSMutableString\""))
            {
                [self setValue:@"" forKey:varName];
            }
            else if (IsSameString(varType, @"@\"NSArray\"") || IsSameString(varType, @"@\"NSMutableArray\""))
            {
                [self setValue:@[] forKey:varName];
            }
            else if (IsSameString(varType, @"@\"NSDictionary\"")  || IsSameString(varType, @"@\"NSMutableDictionary\""))
            {
                [self setValue:@{} forKey:varName];
            }
            else
            {
                NSLog(@"%@",varType);
                NSMutableString * type = [[NSMutableString alloc] initWithString:varType];
                
                NSRange  range = [type rangeOfString:@"@\""];
                if (range.location != NSNotFound)
                {
                    [type deleteCharactersInRange:range];
                }
                range = [type rangeOfString:@"\""];
                if (range.location !=NSNotFound)
                {
                    [type deleteCharactersInRange:range];
                }
                varType = type;
                id object =  [[NSClassFromString(varType) alloc] init];
                if (object && !IsKindOfClass(object, NSNull))
                {
                    if (IsKindOfClass(object, NSObject))
                    {
                        [self setValue:object forKey:varName];
                    }
                }
            }
        }
    }
    
    free(vars);
}

//使用 yy 字典转模型时 会自动调用，用于过滤字典中的值 保证模型属性不会出现nil
//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
//{
//    LogFunctionName();
//
//    NSMutableDictionary * temp = dic.mutableCopy;
//
//    for (NSString * key in dic.allKeys)
//    {
//        id oldValue = dic[key];
//        if (IsKindOfClass(oldValue, NSString))
//        {
//            if (oldValue == nil || IsKindOfClass(oldValue, NSNull) || oldValue == NULL)temp[key] = @"";
//        }
//        else if (IsKindOfClass(oldValue, NSArray))
//        {
//            if (oldValue == nil) temp[key] = @[];
//        }
//        else if (IsKindOfClass(oldValue, NSDictionary))
//        {
//            if (oldValue == nil) temp[key] = @{};
//        }
//        else if (IsKindOfClass(oldValue, NSNumber))
//        {
//            if (oldValue == nil) temp[key] = @0;
//        }
//        else if (IsKindOfClass(oldValue, NSObject))
//        {
//            if (oldValue == nil) temp[key] = [NSObject new];
//        }
//    }
//    dic = temp;
//    return YES;
//}

@end
