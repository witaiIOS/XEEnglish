//
//  MyParser.h
//  XEEnglish
//
//  Created by MacAir2 on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    returnType,
    noneType
    
} NodeType;


@interface MyParser : NSObject<NSXMLParserDelegate>

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSXMLParser *parser;
@property NodeType currentType;

@property (strong, nonatomic) NSMutableString *results;

@property (strong, nonatomic) NSString *currentKey;

+ (MyParser *)sharedInstance;

- (void)parserWithContent:(NSString *)aContent andKey:(NSString *)key;



@end
