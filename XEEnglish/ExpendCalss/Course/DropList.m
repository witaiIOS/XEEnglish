//
//  DropList.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DropList.h"

@implementation DropList
#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.tableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
       
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:kFont];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
     cell.textLabel.text = self.tableList[indexPath.row];
    
    return cell;
}

@end
