//
//  TagObject.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/9.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "BaseDataModel.h"

static NSString * TagClass = @"Tag";


@interface TagObject : BaseDataModel

/// 拥有者
@property (nonatomic, strong) NSString * userId;
/// tag的名字
@property (nonatomic, strong) NSString * tagName;
//@property (nonatomic) colorType tagColor;


@end
