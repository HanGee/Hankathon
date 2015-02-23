import QtQuick 2.3
import QtGraphicalEffects 1.0

Glow {
	id: neonEffect
	fast: true;
	radius: 3;
	samples: 16;
	transparentBorder: true;
	spread: 0.3;
	cached: true;
	color: '#33ffff';

	property real hue: 0;
	property real saturation: 0;

	layer.enabled: true;
	layer.smooth: true;
	layer.effect: BrightnessContrast {
		id: brightnessContrast;
		source: neonEffect
		cached: true;
		brightness: 0
		contrast: 0.1

		layer.enabled: true;
		layer.smooth: true;
		layer.effect: HueSaturation {
			id: hueSaturation;
			source: brightnessContrast;
			hue: neonEffect.hue;
			saturation: neonEffect.saturation;
			lightness: 0;
		}
	}
}
