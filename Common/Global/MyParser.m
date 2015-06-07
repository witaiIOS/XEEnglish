//
//  MyParser.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyParser.h"

@implementation MyParser

+ (MyParser *)sharedInstance{
    static MyParser *sharedMyParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyParser = [[self alloc] init];
    });
    return sharedMyParser;
}

- (void)parserWithContent:(NSString *)aContent andKey:(NSString *)key{
    self.content = aContent;
    self.parser = [[NSXMLParser alloc] initWithData:[self.content dataUsingEncoding:NSUTF8StringEncoding]];
    _parser.delegate = self;
    _currentType = noneType;
    _currentKey = key;
    _results = [[NSMutableString alloc] init];
    
    [_parser parse];
}

#pragma mark -
#pragma mark XML delegate methods

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"start element:%@",elementName);
    
    if ([elementName isEqualToString:_currentKey]) {
        _currentType = returnType;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"character:%@",string);
    if (_currentType == returnType) {
        // NSLog(@"character:%@",string);
        [_results appendString:string];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (_currentType == returnType) {
        //NSLog(@"string:%@",_result);
    }
}



@end
