//
//  TransformerViewController.m
//  CastleTransformation
//
//  Created by Cong Tran on 2017-11-02.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransformerViewController.h"
#import "Transformer.h"

@interface TransformerViewController ()
{
    int sampleNum;
}
@end

@implementation TransformerViewController
@synthesize txtInput,lblOutput,btnRun,btnClear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Transformer";
    sampleNum = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (IBAction)Clear:(id)sender {
    lblOutput.text = @"";
    txtInput.text = @"";
    [txtInput resignFirstResponder];
}

- (IBAction)Run:(id)sender {
    [txtInput resignFirstResponder];
    NSMutableArray *Autobots = [[NSMutableArray alloc] init];
    NSMutableArray *Deceptions = [[NSMutableArray alloc] init];
    NSString *inputStr = txtInput.text;
    NSString *outputStr = @"";
    @try {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        arr = (NSMutableArray *)[inputStr componentsSeparatedByString:@"\n"];
        for (int i=0;i<[arr count];i++){
            NSString *oneStr = arr[i];
            NSMutableArray *oneArr = [[NSMutableArray alloc] init];
            oneArr = (NSMutableArray *)[oneStr componentsSeparatedByString:@","];
            if ([oneArr count] < 10)
                continue;
            NSString *team = oneArr[1];
            Transformer *oneTransformer = [[Transformer alloc] init];
            oneTransformer.Name = oneArr[0];
            oneTransformer.Strength = [oneArr[2] intValue];
            oneTransformer.Intelligence = [oneArr[3] intValue];
            oneTransformer.Speed = [oneArr[4] intValue];
            oneTransformer.Endurance = [oneArr[5] intValue];
            oneTransformer.Rank = [oneArr[6] intValue];
            oneTransformer.Courage = [oneArr[7] intValue];
            oneTransformer.Firepower = [oneArr[8] intValue];
            oneTransformer.Skill = [oneArr[9] intValue];
            oneTransformer.Rating = oneTransformer.Strength+oneTransformer.Intelligence+oneTransformer.Speed+oneTransformer.Endurance+oneTransformer.Firepower;
            if ([team compare:@"D"] == 0){
                bool found = NO;
                for (int j=0;j<[Deceptions count];j++){
                    Transformer *decp = (Transformer *)Deceptions[j];
                    if (oneTransformer.Rank > decp.Rank){
                        [Deceptions insertObject:oneTransformer atIndex:j];
                        found = YES;
                        break;
                    }
                }
                if (!found)
                    [Deceptions addObject:oneTransformer];
            } else {
                bool found = NO;
                for (int j=0;j<[Autobots count];j++){
                    Transformer *autob = (Transformer *)Deceptions[j];
                    if (oneTransformer.Rank > autob.Rank){
                        [Autobots insertObject:oneTransformer atIndex:j];
                        found = YES;
                        break;
                    }
                }
                if (!found)
                    [Autobots addObject:oneTransformer];
            }
        }
        bool isAutobotsMore = NO;
        long battleNum = [Autobots count];
        if (battleNum > [Deceptions count]){
            battleNum = [Deceptions count];
            isAutobotsMore = YES;
        }
        int numAutobotWin = 0;
        int numDeceptionWin = 0;
        NSString *winningTransformer = [[NSString alloc] init];
        NSString *losingTransformer = [[NSString alloc] init];
        for (int i=0;i<battleNum;i++){
            Transformer *oneAutobot = Autobots[i];
            Transformer *oneDecp = Deceptions[i];
            if (([oneAutobot.Name compare:@"Optimus Prime"] == 0 ||
                 [oneAutobot.Name compare:@"Predaking"] == 0) &&
                ([oneDecp.Name compare:@"Optimus Prime"] == 0 ||
                 [oneDecp.Name compare:@"Predaking"] == 0 )) {
                    NSString *outputStr = [NSString stringWithFormat:@"%d Battles\nNo Winning team because either Optimus Prime or Predaking faced off each other", i];
                    lblOutput.text = outputStr;
                    return;
                }
            if ([oneDecp.Name compare:@"Optimus Prime"] == 0 ||
                [oneDecp.Name compare:@"Predaking"] == 0 ||
                oneDecp.Courage - oneAutobot.Courage > 3 ||
                oneDecp.Strength - oneAutobot.Strength > 2 ||
                oneDecp.Skill - oneAutobot.Skill > 2 ||
                oneDecp.Rating < oneAutobot.Rating){
                    numDeceptionWin++;
                    oneAutobot.isAlive = NO;
            } else if ([oneAutobot.Name compare:@"Optimus Prime"] == 0 ||
                   [oneAutobot.Name compare:@"Predaking"] == 0 ||
                   oneAutobot.Courage - oneDecp.Courage > 3 ||
                   oneAutobot.Strength - oneDecp.Strength > 2 ||
                   oneAutobot.Skill - oneDecp.Skill > 2 ||
                   oneAutobot.Rating < oneDecp.Rating){
                numAutobotWin++;
                oneDecp.isAlive = NO;
            } else {
                oneAutobot.isAlive = NO;;
                oneDecp.isAlive = NO;
            }
        }
    
        if (numAutobotWin > numDeceptionWin){
            for (int k=0;k<[Autobots count];k++){
                Transformer *autoBot = (Transformer *)Autobots[k];
                if (autoBot.isAlive){
                    if ([winningTransformer length] == 0)
                        winningTransformer = autoBot.Name;
                    else
                        winningTransformer = [NSString stringWithFormat:@"%@,%@", winningTransformer, autoBot.Name];
                }
            }
            for (int l=0;l<[Deceptions count];l++){
                Transformer *decp = (Transformer *)Deceptions[l];
                if (decp.isAlive){
                    if ([losingTransformer length] == 0)
                        losingTransformer = decp.Name;
                    else
                        losingTransformer = [NSString stringWithFormat:@"%@,%@", losingTransformer, decp.Name];
                }
            }
            outputStr = [NSString stringWithFormat:@"%ld Battles\nWinning team (Autobots): %@\nSurvivals from the losing team (Deceptions): %@", battleNum, winningTransformer, losingTransformer];
        } else if (numAutobotWin < numDeceptionWin){
            for (int k=0;k<[Autobots count];k++){
                Transformer *autoBot = (Transformer *)Autobots[k];
                if (autoBot.isAlive){
                    if ([losingTransformer length] == 0)
                        losingTransformer = autoBot.Name;
                    else
                        losingTransformer = [NSString stringWithFormat:@"%@,%@", losingTransformer, autoBot.Name];
                }
            }
            for (int l=0;l<[Deceptions count];l++){
                Transformer *decp = (Transformer *)Deceptions[l];
                if (decp.isAlive){
                    if ([winningTransformer length] == 0)
                        winningTransformer = decp.Name;
                    else
                        winningTransformer = [NSString stringWithFormat:@"%@,%@", winningTransformer, decp.Name];
                }
            }
            outputStr = [NSString stringWithFormat:@"%ld Battles\nWinning team (Deceptions): %@\nSurvivals from the losing team (Autobots): %@", battleNum, winningTransformer, losingTransformer];
        } else {
            outputStr = [NSString stringWithFormat:@"%ld Battles\nNo Winning team because of tie", battleNum];
        }
    }@catch (NSException *e){
        outputStr = @"Invalid input!";
    }
    lblOutput.text = outputStr;
}

- (IBAction) runSample:(id)sender {
    if (sampleNum == 0){
        txtInput.text = @"Soundwave,D,8,9,2,6,7,5,6,10\nBluestreak,A,6,6,7,9,5,2,9,7\nHubcap,A,4,4,4,4,4,4,4,4";
    } else if (sampleNum == 1){
        txtInput.text = @"Optimus Prime,A,8,9,2,6,7,5,6,10\nThe Fallen,D,6,6,7,9,5,2,9,7\nMegatron,D,6,6,7,9,5,2,9,7\nHubcap,A,4,4,4,4,4,4,4,4\nBumblebee,A,6,6,7,9,5,2,9,7";
    } else if (sampleNum == 2){
        txtInput.text = @"Hound,A,8,9,2,6,7,5,6,10\nFlatline,D,6,6,7,9,5,2,9,7\nMegatron,D,6,6,7,9,5,2,9,7\nJazz,A,9,4,1,5,6,4,2,7\nBumblebee,A,6,6,7,9,5,2,9,7";
    } else if (sampleNum == 3){
        txtInput.text = @"Grimlock,A,8,9,2,6,7,5,6,10\nStarcream,D,6,6,7,9,5,2,9,7\nAstrotrain,D,6,6,7,9,5,2,9,7\nIronhide,A,4,4,4,4,4,4,4,4\nJetfire,A,6,6,7,9,5,2,9,7";
    } else if (sampleNum == 4){
        txtInput.text = @"Grimlock,A,8,1,2,3,7,4,6,10\nFlatline,D,6,6,7,9,5,2,9,7\nBrawl,D,6,6,7,9,5,2,9,7\nHubcap,A,4,4,4,4,4,4,4,4\nBumblebee,A,6,6,7,9,5,2,9,7\nShockwave,D,4,8,7,2,5,5,8,5";
    } else if (sampleNum == 5){
        txtInput.text = @"Jazz,D,8,9,2,6,7,5,6,10\nSoundwave,D,4,6,3,9,8,2,2,5\nAstrotrain,D,6,6,7,9,5,2,9,7\nHubcap,A,4,4,4,4,4,4,4,4\nRatchet,A,6,3,7,4,5,2,2,7";
    }
    sampleNum++;
    if (sampleNum > 5)
        sampleNum = 0;
    [self Run:nil];
}

@end
