package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.group.FlxTypedSpriteGroup;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;

class IntroState extends BasicState {

    private static var messages = [
        "This is The Claw. (Press the Red Button)", 
        "Control your hand with the arrow keys.",
        "Control the claw with the four green buttons.",
        "Complete the tasks using the claw.",
        "Press the button to start the first task."
            ];

    var messageIndex: Int;
    
    override public function create()
    {
        var back = new FlxBackdrop("images/redchecker.png");
		add(back);
        super.create();
        clawActive = false;
        messageIndex = 0;
        text.text = messages[messageIndex];
    }

    override public function update()
    {
        if (!redButtonPressed && Reg.redPressed) {
            if (messageIndex < messages.length - 1) {
                messageIndex++;
                showMessage(messages[messageIndex]);
            } else {
               nextScreen(new Task1()); 
            }
        }
        super.update();        
    }
}
