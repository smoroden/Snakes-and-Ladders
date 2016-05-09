//
//  BoardSquareProperty.m
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "BoardSquareProperty.h"

@implementation BoardSquareProperty

-(instancetype)initWithType:(BoardSquarePropertyType)type andOtherSquareNumber:(NSInteger)number {
    _type = type;
    _otherNumber = number;
    
    return self;
}


-(BOOL)isNotEmpty {
    return self.type == BoardSqurePropertyTypeEmpty ? YES : NO;
}
@end
