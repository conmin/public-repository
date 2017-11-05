//
//  TransformerViewController.h
//  CastleTransformation
//
//  Created by Cong Tran on 2017-11-02.
//  Copyright © 2017 minhtran. All rights reserved.
//

#ifndef TransformerViewController_h
#define TransformerViewController_h
#import <UIKit/UIKit.h>

@interface TransformerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *txtInput;
@property (strong, nonatomic) IBOutlet UILabel *lblOutput;
@property (strong, nonatomic) IBOutlet UIButton *btnRun;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;

- (IBAction)Clear:(id)sender;
- (IBAction)Run:(id)sender;

@end

#endif /* TransformerViewController_h */
