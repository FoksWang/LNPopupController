//
//  _LNPopupBarBackgroundView.m
//  LNPopupController
//
//  Created by Leo Natan on 6/26/21.
//  Copyright © 2021 Leo Natan. All rights reserved.
//

#import "_LNPopupBarBackgroundView.h"

@interface _LNPopupBarBackgroundColorView : UIView @end
@implementation _LNPopupBarBackgroundColorView @end

@interface _LNPopupBarBackgroundImageView : UIImageView @end
@implementation _LNPopupBarBackgroundImageView @end

@interface _LNPopupBarBackgroundEffectView : UIVisualEffectView @end
@implementation _LNPopupBarBackgroundEffectView @end

@implementation _LNPopupBarBackgroundView
{
	UIView* _colorView;
	UIImageView* _imageView;
}

- (instancetype)initWithEffect:(UIVisualEffect *)effect
{
	self = [super init];
	
	if(self)
	{
		_effectView = [[_LNPopupBarBackgroundEffectView alloc] initWithEffect:effect];
		_effectView.clipsToBounds = YES;
		
		_colorView = [_LNPopupBarBackgroundColorView new];
		_imageView = [_LNPopupBarBackgroundImageView new];
		
		self.cornerRadius = 0;
		self.castsShadow = NO;
		self.layer.masksToBounds = NO;
		
		[_effectView.contentView addSubview:_colorView];
		[_effectView.contentView addSubview:_imageView];
		
		[self addSubview:_effectView];
	}
	
	return self;
}

- (void)setAlpha:(CGFloat)alpha
{
	[super setAlpha:alpha];
}

- (UIVisualEffect *)effect
{
	return _effectView.effect;
}

- (void)setEffect:(UIVisualEffect *)effect
{
	_effectView.effect = effect;
}

- (UIView *)contentView
{
	return _effectView.contentView;
}

- (UIView *)colorView
{
	return _colorView;
}

- (UIImageView *)imageView
{
	return _imageView;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	[self sendSubviewToBack:_effectView];
	_effectView.frame = self.bounds;
	
	_imageView.frame = _effectView.contentView.bounds;
	_colorView.frame = _effectView.contentView.bounds;
	
	[_effectView.contentView sendSubviewToBack:_imageView];
	[_effectView.contentView sendSubviewToBack:_colorView];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
	_cornerRadius = cornerRadius;
	
	_effectView.layer.cornerRadius = cornerRadius;
	_effectView.layer.cornerCurve = kCACornerCurveContinuous;
}

- (void)setCastsShadow:(BOOL)castsShadow
{
	_castsShadow = castsShadow;
	
	if(castsShadow)
	{
		self.layer.shadowColor = UIColor.blackColor.CGColor;
		self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
		self.layer.shadowOpacity = 0.15;
		self.layer.shadowRadius = 3.0;
	}
	else
	{
		self.layer.shadowColor = nil;
		self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
		self.layer.shadowOpacity = 0.0;
		self.layer.shadowRadius = 0.0;
	}
}

@end
