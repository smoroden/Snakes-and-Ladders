//
//  InputCollector.h
//  Contact List
//
//  Created by Zach Smoroden on 2016-05-03.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputCollector : NSObject

@property (nonatomic, strong) NSMutableArray *history;

-(instancetype)init;
-(void)printHistory;
-(NSString *)inputForPrompt:(NSString *)promptString;

@end
