//
//  BoardSquareProperty.h
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BoardSquarePropertyType) {
    BoardSqurePropertyTypeEmpty,
    BoardSquarePropertyTypeSnake,
    BoardSquarePropertyTypeLadder
};

@interface BoardSquareProperty : NSObject

@property (nonatomic, readonly) BoardSquarePropertyType type;
@property (nonatomic, readonly) NSInteger otherNumber;


-(instancetype)initWithType:(BoardSquarePropertyType)type andOtherSquareNumber:(NSInteger)number;

@end
