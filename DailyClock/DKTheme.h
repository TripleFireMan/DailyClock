//
//  DKTheme.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#ifndef DKTheme_h
#define DKTheme_h

#define kThemeGray              [UIColor darkGrayColor]
#define kThemeBackgrounColor    [UIColor colorWithHexString:@"#e0e0e0"]
#define kThemeLineColor         [UIColor colorWithHexString:@"#b2b2b2"]

#define kLineColor              [UIColor colorWithHexString:@"#b2b2b2"]
#define kDetailColor            [UIColor colorWithHexString:@"#222222"]
#define kTitleColor             [UIColor colorWithHexString:@"#333333"]
#define kSubTitleColor          [UIColor colorWithHexString:@"#666666"]
#define kSummaryColor           [UIColor colorWithHexString:@"#b2b2b2"]
#define kBackGroungColor        [UIColor colorWithHexString:@"#F5F5F5"]
#define KpageDotImage           [UIColor colorWithHexString:@"#ccffff"]
#define kPlaceholderColor       [UIColor colorWithHexString:@"#999999"]
#define kBorderColor            [UIColor colorWithHexString:@"#e0e0e0"]

#define kShareBtnColor          [UIColor colorWithHexString:@"#FFC500"]

/// 边框容器颜色
#define kContainerColor         RGBColor(246, 247, 241)

/// 主题色
#define kMainColor              [UIColor colorWithHexString:@"#FFC500"]//RGBColor(232, 62, 45)FFC500

/// 未选中的颜色
#define kDefaultContainerColor      [UIColor lightTextColor]
/// 未选中border颜色
#define kDefaultContainerBorderColor  kMainColor
/// 未选中标题颜色
#define kDefaultContainerTitleColor  [UIColor blackColor]

/// 选中的颜色
#define kSelectedContainerColor       kMainColor
/// 选中border颜色
#define kSelectedContainerBorderColor  [UIColor blackColor]
/// 选中标题颜色
#define kSelectedContainerTitleColor  [UIColor blackColor]

/// 将来的颜色
#define kFutureContainerColor       [UIColor clearColor]
/// 将来border颜色
#define kFutureContainerBorderColor  [UIColor clearColor]
/// 将来标题颜色
#define kFutureContainerTitleColor  [UIColor darkGrayColor]

/// 吸色
#define kbgColor1               
#define CYBebas(x)              [UIFont fontWithName:@"Bebas" size:x]
#define CYZcool(x)              [UIFont fontWithName:@"HappyZcool-2016" size:x]
#define DKFont(x)               [UIFont fontWithName:[DKApplication cy_shareInstance].fontName size:(x)]
#define DKBoldFont(x)               [UIFont fontWithName:[DKApplication cy_shareInstance].boldFontName size:(x)]
#endif /* DKTheme_h */
