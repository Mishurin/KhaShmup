package;

import kha.Image;
import kha.Sound;
import kha.audio1.Audio;
import kha.graphics2.Graphics;

class Gun {
	private var bulletImage: Image;
	private var bulletSound: Sound;
	private var shotInterval: Float;
	private var coolDownLeft: Float;
	private var bullets: Array<Bullet>;

	public function new(shotInterval: Float, bulletImage: Image, bulletSound: Sound) {
		this.shotInterval = shotInterval;
		this.bulletImage = bulletImage;
		this.bulletSound = bulletSound;
		coolDownLeft = 0;
		bullets = new Array<Bullet>();
	}

	public function shoot(x: Int, y: Int): Void {
		if(coolDownLeft <= 0) {
			Audio.play(bulletSound, false);
			coolDownLeft = shotInterval;
			var adjX: Int = x - Std.int(bulletImage.width / 2);

			for(i in 0...bullets.length) {
				if(!bullets[i].isActive) {
					bullets[i].activate(adjX, y);
					return;
				}
			}
			bullets.push(new Bullet(adjX, y, bulletImage));
		}
	}

	public function update(deltaTime: Float) {
		coolDownLeft -= deltaTime;
		if(coolDownLeft < 0) {
			coolDownLeft = 0;
		}
		for (i in 0...bullets.length) {
			var bullet = bullets[i];
			bullet.update(deltaTime);
			if(bullet.isActive && bullet.y + bulletImage.height < 0) {
				bullets[i].isActive = false;
			}
		}
	}

	public function render(g: Graphics) {
		for (i in 0...bullets.length) {
			bullets[0].render(g);
		}
	}
}
