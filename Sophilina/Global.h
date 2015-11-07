//
//  Global.h
//
//
//  Created by Kevin Zhang on 12/24/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#ifndef ishopping_Global_h
#define ishopping_Global_h

#define VariableName(arg) (@""#arg)

#define FieldVMargin 1

#define FullWidth ([UIView screenWidth])
#define PagePadding  (10*[UIView scale])
#define FullWidthExcludePadding   ([UIView screenWidth]-PagePadding*2)
#define HalfWidthExcludePadding2   (([UIView screenWidth]-PagePadding*2)/2)
#define HalfWidthExcludePadding3   (([UIView screenWidth]-PagePadding*3)/2)
#define FormFieldHeight ((int)(45*[UIView scale]))
#define LabelLineHeight 44
#define SectionSpacing  (25*[UIView scale])

#define ButtonHeightLarge (40*[UIView scale])
#define ButtonHeightSmall (30*[UIView scale])

#define NotificationRefreshControl      @"NotificationRefreshControl"
#define NotificationEndOfDisplay        @"NotificationEndOfDisplay"
#define NotificationPushController      @"NotificationPushController"
#define NotificationPresentController   @"NotificationPresentController"
#define NotificationNewReview           @"NotificationNewReview"
#define NotificationLogout              @"NotificationLogout"
#define NotificationNoGuest             @"NotificationNoGuest"
#define NotificationAlert               @"NotificationAlert"
#define NotificationMeChanged           @"NotificationMeChanged"
#define NotificationCartChanged         @"NotificationCartChanged"
#define NotificationMsgChanged          @"NotificationMsgChanged"
#define NotificationLangChanged         @"NotificationLangChanged"
#define NotificationTextFieldFocused    @"NotificationTextFieldFocused"
#define NotificationProductChanged      @"NotificationProductChanged"
#define NotificationBackgroundImage     @"NotificationBackgroundImage"
#define NotificationEditing             @"NotificationEditing"
#define NotificationLabelTabChanged     @"NotificationLabelTabChanged"
#define NotificationCouponChanged       @"NotificationCouponChanged"
#define NotificationRadioValueChanged   @"NotificationRadioValueChanged"
#define NotificationGalleryPageChanged  @"NotificationGalleryPageChanged"

#define EventCollectionViewLongPress    @"EventCollectionViewLongPress"

#define FontMedium  @"GothamRounded-Book"
#define FontBook    @"GothamRounded-Light"

#define PageSize 20

#define CornerRadius 5*[UIView scale]
#define FormBorderColor [UIColor colorFromRGB:0xc8c7cc]
#define FormBorderWidth 0.5
#define FormTopMargin   (68*[UIView scale])
#define FormFieldMargin 0.5
#define ViewMargin 25

#define TextViewPlaceHolder @"Your review"

#endif
