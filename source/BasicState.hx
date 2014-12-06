package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxSpriteGroup;

import flixel.effects.FlxSpriteFilter;
import flash.filters.DropShadowFilter;

/**
 * A FlxState which can be used for the game's menu.
 */
class BasicState extends FlxState
{

    public static inline var HAND_SPEED = 1670;

    var screen: FlxSprite;
    var buttons: FlxSpriteGroup;
    var redButton: FlxSprite;
    var leftButton: FlxSprite;
    var rightButton: FlxSprite;
    var upButton: FlxSprite;
    var downButton: FlxSprite;
    
    var hand: FlxSprite;
    var buttonIndex: Int = 0;

    private var wasPressed: Bool = false;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;
		FlxG.camera.bgColor = 0xFF000000;

        //add stage screen
		screen = new FlxSprite(0, 0, "images/screenborder.png");
		screen.scrollFactor.set(0, 0);
		add(screen);

        // the five buttons at the bottom of screen
        buttons = new FlxSpriteGroup();
        buttons.scrollFactor.set(0, 0);

        redButton = new FlxSprite(176, 512, "images/screenbutton.png");
        new FlxSpriteFilter(redButton, 50, 50).addFilter(new DropShadowFilter(5, 45, 0, .75, 10, 10, 1, 1));
        buttons.add(redButton);

        leftButton = new FlxSprite(272, 512, "images/screenarrow.png");
        leftButton.flipX = true;
        new FlxSpriteFilter(leftButton, 50, 50).addFilter(new DropShadowFilter(5, 135, 0, .75, 10, 10, 1, 1));        
        buttons.add(leftButton);

        rightButton = new FlxSprite(368, 512, "images/screenarrow.png");
        new FlxSpriteFilter(rightButton, 50, 50).addFilter(new DropShadowFilter(5, 45, 0, .75, 10, 10, 1, 1));        
        buttons.add(rightButton); 

        upButton = new FlxSprite(464, 512, "images/screenarrow.png");
        upButton.angle = -90;
        new FlxSpriteFilter(upButton, 50, 50).addFilter(new DropShadowFilter(5, 135, 0, .75, 10, 10, 1, 1));        
        buttons.add(upButton);

        downButton = new FlxSprite(560, 512, "images/screenarrow.png");
        downButton.angle = 90;
        new FlxSpriteFilter(downButton, 50, 50).addFilter(new DropShadowFilter(5, 315, 0, .75, 10, 10, 1, 1));        
        buttons.add(downButton);

        add(buttons);

        hand = new FlxSprite(176, 512, "images/hand.png");
        add(hand);
    }
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
        var left = FlxG.keys.anyJustPressed(["A", "LEFT"]);
        var right = FlxG.keys.anyJustPressed(["D", "RIGHT"]);
        var press = FlxG.keys.anyPressed(["S", "SPACE", "DOWN"]);
        var target: Float = buttonIndex * 96 + 176;

        Reg.redPressed = false;
        Reg.downPressed = false;
        Reg.upPressed = false;
        Reg.leftPressed = false;
        Reg.rightPressed = false;

        if (hand.x == target) {
            if (press) {
                if (!wasPressed) {
                    FlxG.sound.play("buttonpress");    
                }
                wasPressed = true;
            } else {
                if (wasPressed) {
                    wasPressed = false;
                    FlxG.sound.play("buttonrelease"); 
                }
                if (left && !right && buttonIndex > 0) {
                    buttonIndex--;
                    FlxG.sound.play("handslide");  
                }
                if (right && !left && buttonIndex < 4) {
                    buttonIndex++;
                    FlxG.sound.play("handslide");  
                }
            }
        } else {
            if (wasPressed) {
                wasPressed = false;
                FlxG.sound.play("buttonrelease"); 
            }
            if (hand.x < target) {
                hand.x = Math.min(target, hand.x + FlxG.elapsed * HAND_SPEED);
            }
            if (hand.x > target) {
                hand.x = Math.max(target, hand.x - FlxG.elapsed * HAND_SPEED);
            }
        }

        var targety: Float = wasPressed ? 518 : 512;

        if (hand.y < targety) {
            hand.y = Math.min(targety, hand.y + FlxG.elapsed * HAND_SPEED);
        }
        if (hand.y > targety) {
            hand.y = Math.max(targety, hand.y - FlxG.elapsed * HAND_SPEED);
        }


        if (wasPressed) {
            switch (buttonIndex) {
                case 0:
                    Reg.redPressed = true;
                case 1:
                    Reg.leftPressed = true;
                case 2:
                    Reg.rightPressed = true;
                case 3:
                    Reg.upPressed = true;
                default:
                    Reg.downPressed = true;
            }
        }

        super.update();
    }	
}

