//
//  ViewController.m
//  斗地主
//
//  Created by JYD on 2016/12/21.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic,copy)  NSArray <NSString *> * poker;
@property (nonatomic,copy)  NSArray<NSString *> * color;
@property (nonatomic,strong)  NSMutableArray * array;
@property (nonatomic,strong)  NSMutableDictionary * dict;

@property (nonatomic,strong)  UILabel * pageLable;
@property (nonatomic,strong)  UILabel * meLable;
@property (nonatomic,strong)  UILabel * moguLable;
@property (nonatomic,strong)  UILabel * diPaiLable;
@property (nonatomic,strong)  UILabel * promptLable;

@property (nonatomic,strong)   NSMutableArray * papa ;
@property (nonatomic,strong)   NSMutableArray * mogu ;
@property (nonatomic,strong)   NSMutableArray * wo ;
@property (nonatomic,strong)  NSMutableArray * diPai ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pageLable = [[UILabel alloc]init];
    self.pageLable.font = [UIFont boldSystemFontOfSize:16];
    self.pageLable.textColor = [UIColor darkGrayColor];
    self.pageLable.numberOfLines = 0;
    [self.view addSubview:self.pageLable];
    [self.pageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
    }];
    
    
    self.meLable = [[UILabel alloc]init];
    self.meLable.numberOfLines = 0;
    self.meLable.font = [UIFont boldSystemFontOfSize:16];
    self.meLable.textColor = [UIColor darkGrayColor];
    [self.view addSubview:self.meLable];
    [self.meLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.pageLable.mas_bottom).offset(25);
    }];

    self.moguLable = [[UILabel alloc]init];
    self.moguLable.numberOfLines = 0;
    self.moguLable.font = [UIFont boldSystemFontOfSize:16];
    self.moguLable.textColor = [UIColor darkGrayColor];
    [self.view addSubview:self.moguLable];
    [self.moguLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.meLable.mas_bottom).offset(25);
    }];

    self.diPaiLable = [[UILabel alloc]init];
    self.diPaiLable.font = [UIFont boldSystemFontOfSize:16];
    self.diPaiLable.numberOfLines = 0;
    self.diPaiLable.textColor = [UIColor darkGrayColor];
    [self.view addSubview:self.diPaiLable];
    [self.diPaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.moguLable.mas_bottom).offset(25);
    }];
    
    
    self.promptLable = [[UILabel alloc]init];
    self.promptLable.text = @"轻点屏幕完成自动发牌";
    self.promptLable.font = [UIFont italicSystemFontOfSize:15];
    self.promptLable.textColor = [UIColor orangeColor];
    [self.view addSubview:self.promptLable];
    self.promptLable.textAlignment = NSTextAlignmentCenter;
    [self.promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-120);
    }];
  

    self.array = [NSMutableArray arrayWithCapacity:53];
    self.dict = [NSMutableDictionary dictionaryWithCapacity:53];
    
     _papa = [NSMutableArray arrayWithCapacity:17];
     _mogu = [NSMutableArray arrayWithCapacity:17];
     _wo = [NSMutableArray arrayWithCapacity:17];
     _diPai = [NSMutableArray arrayWithCapacity:3];
    
    self.poker = @[@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A",@"2"];
    self.color = @[@"♣️",@"♠️",@"❤️",@"♦️"];
    
    //装牌
    NSInteger index = 0;
    for (NSString * poker in self.poker) {
        for (NSString *color in self.color) {
            NSString * pokerStr = [NSString stringWithFormat:@"%@%@",color,poker];
            [self.dict setObject:pokerStr forKey:@(index)];
            [self.array addObject:@(index)];
            index ++ ;
        }
    }
    [self.array addObject:@(index)];
    [self.dict setObject:@"小王" forKey:@(index)];
    index++;
    [self.array addObject:@(index)];
    [self.dict setObject:@"大王" forKey:@(index)];
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   
    
    //洗牌
    NSInteger i = [self.array count];
    while(--i > 0) {
        
        int j = rand() % (i+1);
        
        [self.array exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    //创建三位玩家
    //发牌
    [_diPai removeAllObjects];
    [_wo removeAllObjects];
    [_mogu removeAllObjects];
    [_papa removeAllObjects];
    for (int i =0; i<self.array.count; i++) {
        
        if (self.array.count - 3 <= i) {
            [_diPai addObject:_array[i]];
        }else if (i %3 ==0) {
            [_papa addObject:_array[i]];
            
        }else if (i%3 ==1) {
            [_mogu addObject:_array[i]];
        }else{
            [_wo addObject:_array[i]];
        }
    }
    
     [self sortArray:self.papa];
     [self sortArray:self.mogu];
     [self sortArray:self.diPai];
     [self sortArray:self.wo];
    
    //看牌
    
  NSString * pageStr =  [self lookPopker:self.dict :_papa];
    
    self.pageLable.text = [NSString stringWithFormat:@"啪哥的牌是 :%@",pageStr] ;
   NSString * moguStr =  [self lookPopker:self.dict :_mogu];
    self.moguLable.text = [NSString stringWithFormat:@"蘑菇的牌是 :%@",moguStr] ;
   NSString * meStr =  [self lookPopker:self.dict :_wo];
      self.meLable.text = [NSString stringWithFormat:@"我的牌是 :%@",meStr] ;
   NSString * doPaieStr =  [self lookPopker:self.dict :_diPai];
     self.diPaiLable.text = [NSString stringWithFormat:@"底牌牌是 :%@",doPaieStr] ;
}


/// MARK: ---- 看牌的方法
-(NSString * )lookPopker:(NSMutableDictionary *) dict :(NSMutableArray * )arr {
    NSMutableString * tempString = [NSMutableString string];
    for (int i =0; i<arr.count; i++) {
        NSString * poker = [dict objectForKey:arr[i]];
        [tempString appendString:poker];
       
    }
    
    return tempString;
    
}

  /// MARK: ---- 排序

-(void)sortArray:(NSMutableArray  *) array{

    NSString * temp = nil;
    for (int i =0; i<array.count -1; i++) {
        
        for (int k = i+1; k<array.count; k++) {
            
            if (array[i] > array[k]) {
                temp = array[i];
                array[i] = array[k];
                array[k] = temp;
            }
            
        }
    }
    
    
  }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
