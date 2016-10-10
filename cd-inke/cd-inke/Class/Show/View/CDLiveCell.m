//
//  CDLiveCell.m
//  cd-inke
//
//  Created by ChenDong on 16/9/27.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDLiveCell.h"

@interface CDLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@end

@implementation CDLiveCell

- (void)setLive:(CDLive *)live {
    _live = live;
    
    [self.headView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    
    self.nameLabel.text = live.creator.nick;
    
    self.locationLabel.text = live.city;
    
    self.onLineLabel.text = @(live.onlineUsers).stringValue;
    
    [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    //切圆角
//    self.headView.layer.masksToBounds = YES;
//    self.headView.layer.cornerRadius = 25;
    
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
