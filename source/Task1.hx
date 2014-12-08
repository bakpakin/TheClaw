package;

import flixel.FlxG;

class Task1 extends TaskState {

    var bob: SolidSprite;
    var block: SolidSprite;
    var failed: Bool;
    var won: Bool;
    var oldBobX: Float;
    var oldBobY: Float;
    var showedMessage: Bool;
 
    public function new() {
        super("maps/task1.tmx"); 
    }

    override public  function create() {
        super.create();
        block = new SolidSprite(600, 300, "images/tallobject.png", this);
        block.acceleration.y = Reg.GRAVITY;
        bob = new SolidSprite(550, 350, "images/blockperson.png", this);
        bob.acceleration.y = Reg.GRAVITY;        
        bob.pickUpable = false;
        oldBobX = bob.x;
        oldBobY = bob.y;
    }

    override public function onCurtainUp()
    {
        bob.velocity.set(-20, 0);        
        showMessage("Keep Bob from falling off the edge. Place a block in front of him.");        
    }

    override public function addSolidSprites()
    {
        super.addSolidSprites();
    }

    override public function update()
    {
        if (!opening)
            bob.velocity.x = -20;
        super.update();
        if (!won && !bob.isOnScreen(FlxG.camera)) {
            failed = true;
            clawActive = false;
            claw.open();
        }
        if (!failed && !opening && oldBobX == bob.x && oldBobY == bob.y) {
            won = true;
            clawActive = false;
            claw.open();
        }
        oldBobX = bob.x;
        oldBobY = bob.y;
        if (!showedMessage && won) {
            showMessage("You saved Bob's life! Press the button for the next task.");
            showedMessage = true;
        }
        if (!showedMessage && failed) {
            showMessage("You killed bob! Shame on you. Press button to try again.");
            showedMessage = true;
        }
        if (redButtonPressed) {
            if (won) {
                nextScreen(new Task2());
            } else if (failed) {
                nextScreen(new Task1());
            }
        } 
    }

}
