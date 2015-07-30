//
//  UserStudent.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserStudent.h"
#import "AppConfig.h"

@implementation UserStudent

+ (UserStudent *)sharedUser{
    
    static UserStudent *sharedUserStudentArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserStudentArray = [[self alloc] init];
    });
    
    return sharedUserStudentArray;
}

- (void)firstInitUserStudentArray{
    
    NSArray *userStudentArray = [self getUserStudentArray];
    if (!userStudentArray) {
        [self initUserStudentArray];
        NSLog(@"userStudentArray ready");
    }

}

- (void)initUserStudentArray{
    
    NSArray *userStudentArray =[NSArray array];
    [self setUserStudentArray:userStudentArray];

}

- (NSArray *)getUserStudentArray{
    
    return [[NSUserDefaults standardUserDefaults] arrayForKey:UserStudentGlobalKey];
}

- (void)setUserStudentArray:(NSArray *)userStudentArray{
    
    [[NSUserDefaults standardUserDefaults] setValue:userStudentArray forKey:UserStudentGlobalKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUserStudentArrayWithWebServiceResult:(NSArray *)resultArray{
    
    [self setUserStudentArray:resultArray];
}

@end
