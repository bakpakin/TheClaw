package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Bomb extends SolidSprite {

    var landed: Bool;

    public function new(X: Int, Y:Int, State: TaskState) {
        super(X, Y, "images/bomb.png", State);
        landed = false;
        acceleration.y = Reg.GRAVITY; 
    }

    override public function update() {
        super.update();
        if (y == 368 && !landed) {
            explode(); 
        }
    }

    public function explode() {
        landed = true;
        var p: SimpleParticle;
        for (i in 0...35) 
        {
            p = SimpleParticle.get(x + 16, y + 16, .08 + Math.random() * 0.2);
            p.makeGraphic(4, 4, FlxColor.WHITE);  
            p.velocity.x = (Math.random() - 0.5) * 1500.0;
            p.velocity.y = (Math.random() - 0.5) * 1500.0;
            state.particles.add(p);
        }
        FlxG.sound.play("hurt");
        state.remove(this);
        destroy();
    }

}

