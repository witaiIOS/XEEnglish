//
//  UserStudent.h
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStudent : NSObject
+ (UserStudent *)sharedUser;

- (void)firstInitUserStudentArray;

- (void)initUserStudentArray;

- (NSArray *)getUserStudentArray;

- (void)setUserStudentArray:(NSArray *)userStudentArray;

- (void)setUserStudentArrayWithWebServiceResult:(NSArray *)resultArray;

@end
