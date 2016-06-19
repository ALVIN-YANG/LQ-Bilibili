//
//  DanceViewController.m
//  bilibili视频模块
//
//  Created by 杨卢青 on 16/6/7.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "DanceViewController.h"
#import "PlayerViewController.h"
#import "PlayerResultModel.h"
#import <MJExtension.h>

@interface DanceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *avTextField;

@end

@implementation DanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.avTextField endEditing:YES];
}

- (IBAction)playerButtonClick:(id)sender {
    
    NSLog(@"self.avTextField.text:%@", self.avTextField.text);
    NSString *request = [NSString stringWithFormat:@"http://www.bilibilijj.com/Api/AvToCid/%@", self.avTextField.text];
    
    NSDictionary *elements = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:request]] options:NSJSONReadingMutableContainers error:nil];
    
    [PlayerResultModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"PlayerURLItem"
                 };
    }];
    PlayerResultModel *model = [PlayerResultModel mj_objectWithKeyValues:elements];

    PlayerViewController *playerVC = [[UIStoryboard storyboardWithName:NSStringFromClass([PlayerViewController class]) bundle:nil] instantiateInitialViewController];
    NSLog(@"url%@", model.list[0].Mp4Url);
    playerVC.videoURL = [NSURL URLWithString:model.list[0].Mp4Url];
    
    [self.navigationController pushViewController:playerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
