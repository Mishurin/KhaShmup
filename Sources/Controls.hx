package;

import kha.input.KeyCode;

class Controls {
	public var left: Bool;
	public var right: Bool;
	public var up: Bool;
	public var down: Bool;
	public var shoot: Bool;
	public function new() {}
	public function keyDown(key: KeyCode): Void {
		switch(key) {
			case Left:
				left = true;
			case Right:
				right = true;
			case Down:
				down = true;
			case Up:
				up = true;
			case z:
				shoot = true;
		}
	}

	public function keyUp(key: KeyCode): Void {
		switch(key) {
			case Left:
				left = false;
			case Right:
				right = false;
			case Down:
				down = false;
			case Up:
				up = false;
			case z:
				shoot = false;
		}
	}


}

