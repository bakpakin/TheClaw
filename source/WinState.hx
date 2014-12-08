package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;

class WinState extends BasicState {

    override public function create() {
        var back = new FlxBackdrop("images/redchecker.png");
		add(back);
        super.create();
    }

    override public function onCurtainUp() {
        showMessage("That's all for now. Press the red button to go back to the Intro.");
    }

    override public function update() {
        super.update();
        if (Reg.redPressed) {
            nextScreen(new IntroState());
        }
    }
    
}
