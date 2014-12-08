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

    public function new() {
        super("maps/task3.tmx"); 
    }

    override public function onCurtainUp()
    {
        showMessage("Bomb the invaders.");
        var b = new Bomb(200, 200, this);
        b.acceleration.y = Reg.GRAVITY;        
    }

    override public function create()
    {
        super.create();
    }

    override public function update()
    {
        super.update();
    }
}
