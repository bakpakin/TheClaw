package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxDestroyUtil;

class Claw extends FlxSprite {

    var clawSpeed: Float = 150;
    var clawVerticalSpeed: Float = 50;
    var clawCloseSpeed: Float = 120;

    var leftClaw: FlxSprite;
    var rightClaw: FlxSprite;
    var clawHinge: FlxSprite;
    var rope: FlxSprite;

    private var targetAngle: Float;
    public var justClosed: Bool;

    private var buttonClawState: Bool;

    public function new(X: Float, Y: Float) {
        super(X, Y);
        rightClaw = new FlxSprite(0, 0, "images/clawfinger.png");
        leftClaw = new FlxSprite(0, 0, "images/clawfinger.png");
        leftClaw.flipX = true;
        rope = new FlxSprite(0, 0, "images/rope.png");
        clawHinge = new FlxSprite(0, 0, "images/clawhinge.png");
        targetAngle = angle = 0;
    }

    override public function draw()
    {
        leftClaw.x = this.x - 64;
        leftClaw.y = this.y - 64;
        leftClaw.angle = this.angle;
        rightClaw.x = this.x - 64;
        rightClaw.y = this.y - 64;
        rightClaw.angle = -this.angle;
        clawHinge.x = this.x - 16;
        clawHinge.y = this.y - 16;
        rope.x = this.x - 16;
        rope.y = this.y - 600;
        leftClaw.draw();
        rightClaw.draw();
        rope.draw();
        clawHinge.draw();
    }

    public function updateClaw()
    {
       if (Reg.leftPressed && !Reg.rightPressed) {
            x -= clawSpeed * FlxG.elapsed;
        }
        if (Reg.rightPressed && !Reg.leftPressed) {
            x += clawSpeed * FlxG.elapsed;
        }
        if (Reg.upPressed && !Reg.downPressed) {
            y -= clawVerticalSpeed * FlxG.elapsed;
        }
        if (Reg.downPressed && !Reg.upPressed) {
            y += clawVerticalSpeed * FlxG.elapsed;
        }

        x = Math.min(Reg.MAX_X, Math.max(Reg.MIN_X, x));
        y = Math.min(Reg.MAX_Y, Math.max(Reg.MIN_Y, y));

        if (Reg.redState != buttonClawState) {
            targetAngle = 30;            
        } else {
            targetAngle = 0;
        }

        justClosed = false;
        if (angle < targetAngle) {
            angle = Math.min(targetAngle, angle + clawCloseSpeed * FlxG.elapsed);
        }
        if (angle > targetAngle) {
            angle = Math.max(targetAngle, angle - clawCloseSpeed * FlxG.elapsed);
            if (angle == 0) {
                justClosed = true;
            }
        } 
    }

    public function isOpen(): Bool
    {
        return angle != 0;
    }

    public function open() {
        if (!isOpen()) {
            buttonClawState = !buttonClawState;
        }
        targetAngle = 30;
    }

    override public function destroy()
    {
        FlxDestroyUtil.destroy(leftClaw);
        FlxDestroyUtil.destroy(rightClaw);
        FlxDestroyUtil.destroy(rope);
        FlxDestroyUtil.destroy(clawHinge);
        super.destroy();
    }

}
