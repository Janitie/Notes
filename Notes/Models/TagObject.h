//
//  TagObject.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/9.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "BaseDataModel.h"

static NSString * TagClass = @"Tag";

//typedef enum : NSUInteger {
//    Red = 0,
//    Yellow,
//    Blue,
//    Green
//} colorType;

@interface TagObject : BaseDataModel

@property (nonatomic) NSString * tagName;
//@property (nonatomic) colorType tagColor;


@end
