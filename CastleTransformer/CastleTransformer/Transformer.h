//
//  ModelController.h
//  CastleTransformation
//
//  Created by Cong Tran on 2017-11-02.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Transformer : NSObject
@property(atomic, strong) NSString *Name;
@property(atomic, strong) NSString *Team;
@property(assign) int Strength;
@property(assign) int Intelligence;
@property(assign) int Speed;
@property(assign) int Endurance;
@property(assign) int Rank;
@property(assign) int Courage;
@property(assign) int Firepower;
@property(assign) int Skill;
@property(assign) int Rating;
@property(assign) BOOL isAlive;
@end

