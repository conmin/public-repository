//
//  CastleViewController.h
//  CastleTransformer
//
//  Created by Cong Tran on 2017-11-02.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CastleViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *txtInput;
@property (strong, nonatomic) IBOutlet UILabel *lblOutput;
@property (strong, nonatomic) IBOutlet UIButton *btnRun;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;
@property (strong, nonatomic) NSMutableArray *teamArr;

@property (strong, nonatomic) id dataObject;

- (IBAction)MoveToTranformer:(id)sender;
- (IBAction)Clear:(id)sender;
- (IBAction)Run:(id)sender;

@end

