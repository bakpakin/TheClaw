package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class SolidSprite extends FlxSprite {

    public var state: TaskState;
    public var pickedUp: Bool;
    public var pickUpable: Bool;
    private var yOffset: Float;

    public function new(X: Float, Y: Float, Image: Dynamic, State: TaskState) {
        super(X, Y, Image);
        state = State;
        state.solids.add(this);
        pickUpable = true;
        drag.x = 200;
    }

    override public function update() 
    {
       super.update();
       if (pickedUp && pickUpable) {
            x = state.claw.x - 16;
            y = state.claw.y + yOffset;
            velocity.set(0, 0);
       } 
       FlxG.overlap(state.map, this, null, FlxObject.separate);
       state.solids.forEach(overlapWithMe);
       yOffset = y - state.claw.y;
       if (pickUpable && !state.claw.isOpen() && Math.abs(x - state.claw.x + 16) < 8 && Math.abs(y - state.claw.y - 32) < height / 2) {
           if (state.claw.justClosed) {
               pickedUp = true;
               yOffset = y - state.claw.y;
               FlxG.sound.play("pickup"); 
           }
       } else {
           if (pickedUp) {
               state.claw.open();
               FlxG.sound.play("drop"); 
           }
           pickedUp = false;
       }
    }

    private function overlapWithMe(Sprite: SolidSprite) {
       // if (Sprite != this)
            FlxG.overlap(this, Sprite, collisionCallback, FlxObject.separate);
    }

    public function collisionCallback(This: flixel.FlxBasic, B: flixel.FlxBasic)
    {
        
    }

}
