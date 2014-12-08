package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.group.FlxTypedSpriteGroup;

class Task2 extends TaskState {

    var car: SolidSprite;
    var messageShown: Bool;

    public function new() {
        super("maps/task2.tmx"); 
    }

    override public function onCurtainUp()
    {
        showMessage("Build a bridge for the car to drive across.");
        car.velocity.x = -40;
    }

    override public function create()
    {
        super.create();

        for (i in 0...4) {
            var s = new SolidSprite(490, 160+32*i, "images/object.png", this);
            s.acceleration.y = Reg.GRAVITY;
        }

        car = new SolidSprite(692, 200, "images/car.png", this);
        car.acceleration.y = Reg.GRAVITY;
        car.pickUpable = false;
        var stopper = new SolidSprite(660, 200, "images/tallobject.png", this);
        stopper.acceleration.y = Reg.GRAVITY;
    }

    override public function update()
    {
        if (!opening)
            car.velocity.x = -40;
        super.update();
        if (car.y > 368) {
            if (!messageShown) {
                messageShown = true;
                showMessage("The car seems to be stuck. Press button to try again.");
                clawActive = false;
            }    
            if (next == null && Reg.redPressed) {
                nextScreen(new Task2());
            }
        }

        if (car.x < 128) {
            if (!messageShown) {
                messageShown = true;
                showMessage("The car got across. Press button for next task.");
                clawActive = false;
            }  
            if (next == null && Reg.redPressed) {
                nextScreen(new Task3());
            }
        }
    }

}
