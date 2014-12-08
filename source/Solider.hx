package;

class Solider extends SolidSprite {
    
    public function new(X: Float, Y: Float, State: TaskState) {
        super(X, Y, "images/blockperson.png", State);   
    }

    override public function update() {
        super.update();
        if (!isOnScreen()) {
            if (x < 0 && Std.is(state, Task3)) {
                cast(state, Task3).failed = true;
            }
            destroy();
        }
    }

    override public function collisionCallback(This: flixel.FlxBasic, B: flixel.FlxBasic)
    {
        if (Std.is(B, Bomb)) {
            cast(B, Bomb).explode();
            This.destroy();
            if (Std.is(state, Task3))
                cast(state, Task3).soldiersBombed++;
        } 
    }

}
