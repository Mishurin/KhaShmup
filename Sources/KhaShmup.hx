package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.input.KeyCode;
import kha.Scaler;
import kha.System;
import kha.input.Keyboard;

class KhaShmup {
	private static var bgColor = Color.fromValue(0x26004d);
	public static inline var screenWidth = 800;
	public static inline var screenHeight = 600;
	public static inline var gunSpeed = 0.25;

	private var backBuffer: Image;
	private var controls: Controls;
	private var initialized = false;
	private var ship: Ship;
	private var timer: Timer;

	public function new() {
		Assets.loadEverything(loadingFinished);
	}

	private function loadingFinished(): Void {
		initialized = true;
		backBuffer = Image.createRenderTarget(screenWidth, screenHeight);
		controls = new Controls();
		timer = new Timer();
		Keyboard.get().notify(keyDown, keyUp);
		setupShip();
	}

	public function render(framebuffer: Framebuffer): Void {
		if(!initialized) {
			return;
		}
		var g = backBuffer.g2;
		g.begin(bgColor);
		ship.render(g);
		g.end();
		framebuffer.g2.begin();
		Scaler.scale(backBuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
		update();
	}

	private function setupShip() {
		var shipImg = Assets.images.get('playerShip');
		ship = new Ship(Std.int(screenWidth / 2) - Std.int(shipImg.width / 2), 
			Std.int(screenHeight / 2) - Std.int(shipImg.height / 2),
			shipImg);
		ship.attachGun(new Gun(gunSpeed, Assets.images.get('bullet'), Assets.sounds.get('bulletShoot')));
	}

	private function update() {
		timer.update();
		updateShip();
	}

	private function updateShip(){
		ship.update(controls, timer.deltaTime);
		if(ship.x < 0) {
			ship.x = 0;
		} else if (ship.x + ship.width > screenWidth) {
			ship.x = screenWidth - ship.width;
		}
		if(ship.y < 0) {
			ship.y = 0;
		} else if (ship.y + ship.height > screenHeight) {
			ship.y = screenHeight - ship.height;
		}
	}

	private function keyDown(key: KeyCode): Void {
		controls.keyDown(key);
	}

	private function keyUp(key: KeyCode): Void {
		controls.keyUp(key);
	}
}