//
//  WifiListTableViewCell.m
//  wifiKey
//
//  Created by 寒山 on 2018/1/26.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import "WifiListTableViewCell.h"
#import "YMDateTool.h"
@interface WifiListTableViewCell()
@property(nonatomic,retain)UILabel *wifiTitleLabel;
@property(nonatomic,retain)UILabel *wifiPasswordLabel;
@property(nonatomic,retain)UILabel *addTimeLabel;
@end
@implementation WifiListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kClearColor;
        self.backgroundColor=kClearColor;
        
        UIView *contenBgView=[[UIView alloc]init];
        contenBgView.backgroundColor=kWhiteColor;
        [self.contentView addSubview:contenBgView];
        
        
        UIImageView *iconImageView=[[UIImageView alloc]init];
        iconImageView.image=[UIImage imageNamed:@"wifi"];
        [contenBgView addSubview:iconImageView];
        
        _wifiTitleLabel=[[UILabel alloc]init];
        _wifiTitleLabel.font=FONT_BOLD(15);
        _wifiTitleLabel.textColor=MAIN_TEXT_Color;
        [_wifiTitleLabel sizeToFit];
       _wifiTitleLabel.text=@"vanjiang";
        [contenBgView addSubview:_wifiTitleLabel];
        
        _wifiPasswordLabel=[[UILabel alloc]init];
        _wifiPasswordLabel.font=FONT_BOLD(15);
        _wifiPasswordLabel.textColor=MAIN_TEXT_Color;
        [_wifiPasswordLabel sizeToFit];
        _wifiPasswordLabel.text=@"123456789";
        [contenBgView addSubview:_wifiPasswordLabel];
        
        
        _addTimeLabel=[[UILabel alloc]init];
        _addTimeLabel.font=FONT_BOLD(10);
        _addTimeLabel.textColor=SMALL_TEXT_Color;
        [_addTimeLabel sizeToFit];
        _addTimeLabel.text=@"10分钟";
        [contenBgView addSubview:_addTimeLabel];
        
        UIButton *copyButton=[[UIButton alloc]init];
        [copyButton setImage:[UIImage imageNamed:@"copyPassword"] forState:UIControlStateNormal];
        [copyButton addTarget:self action:@selector(copyPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        [contenBgView addSubview:copyButton];
        
        [contenBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(@(-10));
        }];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contenBgView);
            make.left.equalTo(contenBgView).offset(10);
            make.height.equalTo(@(25));
            make.width.equalTo(@(30));
        }];
        [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contenBgView).offset(15);
            make.right.equalTo(contenBgView).offset(-5);
            make.height.equalTo(@(24));
            make.width.equalTo(@(50));
        }];
        [_wifiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contenBgView).offset(16);
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.right.equalTo(copyButton.mas_left).offset(-10);
            make.height.equalTo(@(15));
        }];
        [_wifiPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contenBgView).offset(-16);
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.right.equalTo(copyButton.mas_left).offset(-10);
            make.height.equalTo(@(15));
        }];
        
        [_addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contenBgView).offset(-10);
            make.right.equalTo(contenBgView).offset(-15);
            make.top.equalTo(copyButton.mas_bottom).offset(5);
        }];
    }
    return self;
}
-(void)setInfoModel:(WiFiInfoModel *)infoModel{
    _wifiTitleLabel.text=infoModel.wifiName;
    _wifiPasswordLabel.text=infoModel.wifiPassword;
    _addTimeLabel.text=[YMDateTool timeDescriptionWithTime:[infoModel.creatTime doubleValue]];
}
-(void)copyPasswordAction{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _wifiPasswordLabel.text;
    
    UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"复制成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alterView show];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
