//
//  YRStatus.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatus.h"

/**
 *  加入一个第三方库，计算出xml中的数据
 *
 */
#import "XMLDictionary.h"

@implementation YRStatus

// 发送时间的get方法
- (NSString *)created_at{

    return [NSString created_atStringWithStandardDateString:_created_at];
}

// 发送来源的set方法 这里是有写set方法和get方法都可以的，但是这两个方法只能写一个，
-(void)setSource:(NSString *)source{

    _source = source;//
    NSDictionary *xmlDict = [NSDictionary dictionaryWithXMLString:_source];
    
    _source = [NSString stringWithFormat:@"来自:%@",[xmlDict valueForKey:XMLDictionaryTextKey]];
}
// get方法，这个方法会时时刻刻的调用，没有必要
//- (NSString *)source{
//
//    
//    int loc = [_source rangeOfString:@">"].location + 1;
//    int length = [_source rangeOfString:@"</"].location - loc;
//    return [NSString stringWithFormat:@"来自:%@",[_source substringWithRange:NSMakeRange(loc, length)]];
//
//}

@end