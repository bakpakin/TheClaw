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
import flash.display.BitmapData;
import flash.geom.Matrix;

/**
 * A FlxState which can be used for the game's menu.
 */
class BasicState extends FlxState
{

    private static inline var BUTTON_SPACING: Float =  96;
    private static inline var BUTTON_0: Float = 300;
    private static inline var BUTTON_Y: Float = 512;

    public static inline var HAND_SPEED = 1670;

    var screen: FlxSprite;
    var buttons: FlxSpriteGroup;
    var redButton: FlxSprite;
    var leftButton: FlxSprite;
    var rightButton: FlxSprite;
    var upButton: FlxSprite;
    var downButton: FlxSprite;
    var curtain: FlxSprite;
    var next: BasicState;

    var text: FlxText;
    var textBack: FlxSprite;
    var clawActive: Bool = true;
    var redButtonPressed: Bool;    

    var effect: FlxSprite;
    var time: Float;

    public var particles: FlxSpriteGroup;

    private var opening: Bool;
    
    public var hand: FlxSprite;
    public var buttonIndex: Int = 0;

    private var wasPressed: Bool = false;

    public var claw: Claw;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;
		FlxG.camera.bgColor = 0xFF000000;

		add(claw = new Claw(200, 200));

		particles = new FlxSpriteGroup();
		add(particles);

		curtain = new FlxSprite(0, 0);
        curtain.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        opening = true;
        add(curtain);

		textBack = new FlxSprite(0, 500);
		textBack.makeGraphic(800, 100, 0xFF000000);
        add(textBack);

        // add effect
       /* effect = new FlxSprite(0, 0);
		var bitmapdata:BitmapData = new BitmapData(FlxG.width, FlxG.height, true, 0x33114411);
		var scanline:BitmapData = new BitmapData(FlxG.width, 8, true, 0x33001100);
		
		for (i in 0...bitmapdata.height)
		{
			if (i % 16 == 0)
			{
				bitmapdata.draw(scanline, new Matrix(1, 0, 0, 1, 0, i));
			}
		}

		effect.loadGraphic(bitmapdata);        
		add(effect);*/

        text = new FlxText(32, 512, 224, "", 16);
        text.setFormat("fonts/4b03.ttf", 16, 0xFFFFFFFF, "left");
        add(text);

        //add stage screen
		screen = new FlxSprite(0, 0, "images/screenborder.png");
		screen.scrollFactor.set(0, 0);
		add(screen);

        // the five buttons at the bottom of screen
        buttons = new FlxSpriteGroup();
        buttons.scrollFactor.set(0, 0);

        redButton = new FlxSprite(BUTTON_0, BUTTON_Y, "images/screenbutton.png");
        new FlxSpriteFilter(redButton, 50, 50).addFilter(new DropShadowFilter(5, 45, 0, .75, 10, 10, 1, 1));
        buttons.add(redButton);

        leftButton = new FlxSprite(BUTTON_0 + BUTTON_SPACING, BUTTON_Y, "images/screenarrow.png");
        leftButton.flipX = true;
        new FlxSpriteFilter(leftButton, 50, 50).addFilter(new DropShadowFilter(5, 135, 0, .75, 10, 10, 1, 1));        
        buttons.add(leftButton);

        rightButton = new FlxSprite(BUTTON_0 + 2*BUTTON_SPACING, BUTTON_Y, "images/screenarrow.png");
        new FlxSpriteFilter(rightButton, 50, 50).addFilter(new DropShadowFilter(5, 45, 0, .75, 10, 10, 1, 1));        
        buttons.add(rightButton); 

        upButton = new FlxSprite(BUTTON_0 + 3*BUTTON_SPACING, BUTTON_Y, "images/screenarrow.png");
        upButton.angle = -90;
        new FlxSpriteFilter(upButton, 50, 50).addFilter(new DropShadowFilter(5, 135, 0, .75, 10, 10, 1, 1));        
        buttons.add(upButton);

        downButton = new FlxSprite(BUTTON_0 + 4*BUTTON_SPACING, BUTTON_Y, "images/screenarrow.png");
        downButton.angle = 90;
        new FlxSpriteFilter(downButton, 50, 50).addFilter(new DropShadowFilter(5, 315, 0, .75, 10, 10, 1, 1));        
        buttons.add(downButton);

        add(buttons);

        hand = new FlxSprite(redButton.x, redButton.y, "images/hand.png");
        add(hand);

        //music
        if (!Reg.musicPlaying) {
            FlxG.sound.playMusic("arcade", 1, true);
            Reg.musicPlaying = true;
        }

        time = 0;
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
        redButtonPressed = Reg.redPressed;        

        time += FlxG.elapsed;

        //effect.y = cast(time * 45, Int) % 16;

        if (opening) {
            curtain.alpha = Math.max(0, curtain.alpha - 1*FlxG.elapsed);            
            if (curtain.alpha == 0) {
                opening = false;
                onCurtainUp();
            }
        } 

        if (next != null) {
            curtain.alpha = Math.min(1, curtain.alpha + 1*FlxG.elapsed);            
            if (curtain.alpha == 1) {
                FlxG.switchState(next);
            }
        }

        var left = Reg.controlsActive && FlxG.keys.anyJustPressed(["A", "LEFT"]);
        var right = Reg.controlsActive && FlxG.keys.anyJustPressed(["D", "RIGHT"]);
        var press = Reg.controlsActive && FlxG.keys.anyPressed(["S", "SPACE", "DOWN"]);
        var target: Float = BUTTON_0 + buttonIndex * BUTTON_SPACING;

        Reg.redPressed = false;
        Reg.downPressed = false;
        Reg.upPressed = false;
        Reg.leftPressed = false;
        Reg.rightPressed = false;

        if (hand.x == target) {
            if (press) {
                if (!wasPressed) {
                    FlxG.sound.play("buttonpress");    
                    if (buttonIndex == 0) {
                        Reg.redState = !Reg.redState;
                    } 
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

        var targety: Float = BUTTON_Y + (wasPressed ? 6 : 0);

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

        if (clawActive)
            claw.updateClaw();
        super.update();
    }	

    public function nextScreen(Next: BasicState) {
        next = Next;
    }
    
    public function showMessage(Message: String) {
        text.text = Message;
        FlxG.sound.play("message");
    }

    public function onCurtainUp() {
        
    }
}

