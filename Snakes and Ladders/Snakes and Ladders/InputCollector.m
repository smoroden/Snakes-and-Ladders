//
//  InputCollector.m
//  Contact List
//
//  Created by Zach Smoroden on 2016-05-03.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "InputCollector.h"

@implementation InputCollector

-(instancetype)init {
    self.history = [@[] mutableCopy];
    return self;
}

// Gets a string from the user and nicely converts it to a NSString
-(NSString *)inputForPrompt:(NSString *)promptString {
    char inputChars[255];
    
    NSLog(@"%@ \n>  ", promptString);
    
    fgets(inputChars, 255, stdin);
    
    NSString *finalInput = [[NSString stringWithUTF8String:inputChars] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Only remove items if we are at the max that we want to store.
    if (self.history.count == 4) {
        [self.history removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
    [self.history addObject:finalInput];
    
    return finalInput;
}

// Prints the last 3 commands + the history command
-(void)printHistory {
    NSLog(@"The last three commands entered + history: ");
    for (NSString *command in self.history) {
        NSLog(@"%@", command);
    }
}

@end
