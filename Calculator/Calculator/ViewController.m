//
//  ViewController.m
//  Calculator
//
//  Created by Annie Lee on 2019/1/18.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearLabels];
}

- (IBAction)numberExpression:(UIButton *)sender {
    
    NSString *input = [[sender titleLabel] text];
    NSString *currentText = self.currentLabel.text;
    
    if([input isEqualToString:@"."]
       && [currentText rangeOfString:input].location != NSNotFound){
        
        return;
    }
    
    if([currentText isEqualToString:@"0"]){
        
        if(![input isEqualToString:@"0"]){
            
            self.currentLabel.text = input;
        }
        
        return;
    }
    
    self.currentLabel.text = [currentText stringByAppendingString:input];
}

- (IBAction)operatorExpression:(UIButton *)sender {
    
    NSString *input = [[sender titleLabel] text];
    NSString *operator = self.operatorLabel.text;
    NSString *resultText = self.resultLabel.text;
    NSString *currentText = self.currentLabel.text;
    
    if([resultText isEqualToString:@""]){
        
        if(![currentText isEqualToString:@"0"]){
            
            [self updateLabels:input result:currentText current:@""];
        }
    } else {
        
        if([currentText isEqualToString:@""]){
            
            self.operatorLabel.text = input;
        } else {
            
            NSString *resut = [[self calculateWithOperator:operator] stringValue];
            
            [self updateLabels:input result:resut current:@""];
        }
    }
}

- (IBAction)calculateExpression:(UIButton *)sender {
    
    NSString *operator = self.operatorLabel.text;
    
    NSString *resut = [[self calculateWithOperator:operator] stringValue];
    
    [self updateLabels:@"" result:resut current:@""];
}

- (IBAction)clearInputExpression:(UIButton *)sender {
    
    [self clearLabels];
}

- (IBAction)plusOrMinusExpression:(UIButton *)sender {
    
}

- (void)updateLabels:(NSString *)operator
              result:(NSString *)result
             current:(NSString *)current{
    
    self.operatorLabel.text = operator;
    self.resultLabel.text = result;
    self.currentLabel.text = current;
}

- (void)clearLabels {
    
    [self updateLabels:@"" result:@"" current:@"0"];
}

- (NSDecimalNumber *)calculateWithOperator:(NSString *)operator{
    
    NSDecimalNumber *result;
    
    NSDecimalNumber *leftOperand = [NSDecimalNumber decimalNumberWithString:self.resultLabel.text];
    NSDecimalNumber *rightOperand = [NSDecimalNumber decimalNumberWithString:self.currentLabel.text];
    
    if([operator isEqualToString:@"+"]){
        
        result = [leftOperand decimalNumberByAdding:rightOperand];
    } else if([operator isEqualToString:@"-"]){
        
        result = [leftOperand decimalNumberBySubtracting:rightOperand];
    } else if([operator isEqualToString:@"*"]){
        
        result = [leftOperand decimalNumberByMultiplyingBy:rightOperand];
    } else if([operator isEqualToString:@"/"]){
        
        if(rightOperand == 0){ return result; }
        
        result = [leftOperand decimalNumberByDividingBy:rightOperand];
    }
    
    return result;
}

@end
