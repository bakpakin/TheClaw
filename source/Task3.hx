package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.group.FlxTypedSpriteGroup;

class Task3 extends TaskState {

    var messageShown: Bool;
    var timeBuffer: Float;
    var won: Bool;
    public var soldiersBombed: Int;
    public var failed: Bool;

    public function new() {
        super("maps/task3.tmx"); 
    }

    override public function onCurtainUp()
    {
        showMessage("Bomb the invaders. Get ten before one gets through.");
        soldiersBombed = 0;
        timeBuffer = 0;
    }

    override public function create()
    {
        super.create();
    }

    override public function update()
    {
        timeBuffer += FlxG.elapsed;
        if (timeBuffer >= 5) {
            timeBuffer -= 5;
            var s = new Solider(790, 368, this);
            s.velocity.x = -32;
            var b;
            switch (Std.int(Math.random() * 3)) {
                case 0:
                    b = new Bomb(175, 0, this);
                case 1:
                    b = new Bomb(375, 0, this);
                case 2:
                    b = new Bomb(575, 0, this);
            }
        }
        if (soldiersBombed >= 10 && !messageShown) {
            won = true; 
            messageShown = true;
            showMessage("Blow the suckers up! Nice job! Once again, please press the button. :)");           
        }
        if (!won && failed && !messageShown) {
            messageShown = true;
            clawActive = false;
            showMessage("You let one get by! Hit the button to try again.");
        }
        if (!won && failed && Reg.redPressed) {
            nextScreen(new Task3());
        }
        if (won && Reg.redPressed) {
            nextScreen(new WinState());
        }
        super.update();
    }
}
