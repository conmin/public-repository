//
//  DataViewController.m
//  CastleTransformation
//
//  Created by Cong Tran on 2017-11-02.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import "CastleViewController.h"
#import "TransformerViewController.h"

@interface CastleViewController ()
{
    int sampleNum;
}

@end

@implementation CastleViewController
@synthesize txtInput,lblOutput,btnRun,btnClear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"Castle"];
    sampleNum = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (IBAction)MoveToTranformer:(id)sender {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *storyboardName = [bundle objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    TransformerViewController *transformerViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"TransformerViewController"];
    [self.navigationController pushViewController:transformerViewController animated:YES];
}

- (IBAction)Clear:(id)sender {
    lblOutput.text = @"";
    txtInput.text = @"";
    [txtInput resignFirstResponder];
}

- (IBAction)Run:(id)sender {
    [txtInput resignFirstResponder];
    NSString *inputStr = txtInput.text;
    int numOfCastle = 1;
    if (inputStr == nil || [inputStr length] == 0){
        return;
    }
    @try {
        NSMutableArray *splitStrArr = [[NSMutableArray alloc] init];
        splitStrArr = (NSMutableArray *)[inputStr componentsSeparatedByString:@","];
        long maxCount = [splitStrArr count];
        for (int i=1;i<maxCount;i++){
            NSString *prev = splitStrArr[i-1];
            int prevNum = [prev intValue];
            NSString *val = splitStrArr[i];
            int valNum = [val intValue];
            if (valNum == prevNum) {
                [splitStrArr removeObjectAtIndex:i];
                i--;
                maxCount = [splitStrArr count];
            }
            if (i > 0) {
                prev = splitStrArr[i-1];
                prevNum = [prev intValue];
                val = splitStrArr[i];
                valNum = [val intValue];
                if (i < maxCount-1){
                    NSString *next = splitStrArr[i+1];
                    int nextNum = [next intValue];
                    if (valNum > prevNum && valNum > nextNum)
                        numOfCastle++;
                    else if (valNum < prevNum && valNum < nextNum)
                        numOfCastle++;
                }
            }
        }
    }@catch (NSException *e) {
        NSString *outputStr = @"Invalid input!";
        lblOutput.text = outputStr;
        return;
    }
    NSString *outputStr = [NSString stringWithFormat:@"%d", numOfCastle];
    lblOutput.text = outputStr;
}

- (IBAction) runSample:(id)sender {
    if (sampleNum == 0){
        txtInput.text = @"2,6,6,6,3";
    } else if (sampleNum == 1){
        txtInput.text = @"3,4,3,6,4,9,3,3,5,1,4,6,4,77,8";
    } else if (sampleNum == 2){
        txtInput.text = @"8,9,2,6,7,5,6,10,11,22,55,22,1,5,4,7,7,7,8,12";
    } else if (sampleNum == 3){
        txtInput.text = @"4,2,4,6,7,3,4,4,5,5,2,3,4,5,1,77,23,4,12,11,24,222,1,4";
    } else if (sampleNum == 4){
        txtInput.text = @"8,3,5,1,0,2,33,51,12,2,5,7,3,44,5,6,2,21,33,555,2,1,6";
    } else if (sampleNum == 5){
        txtInput.text = @"3,3,4,1,2,2,5,5,6,6,6,,8,9,11,22,22,1,3,5,3,2,6,24,12";
    }
    sampleNum++;
    if (sampleNum > 5)
        sampleNum = 0;
    [self Run:nil];
}
@end
