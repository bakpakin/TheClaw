package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{

    public static inline var GRAVITY = 400;

    public static var controlsActive: Bool = true;
    public static var redPressed: Bool;
    public static var redState: Bool;
    public static var upPressed: Bool;
    public static var downPressed: Bool;
    public static var leftPressed: Bool;
    public static var rightPressed: Bool;
    public static var musicPlaying: Bool;

    public static inline var MAX_X: Float = 736;
    public static inline var MIN_X: Float = 64;
    public static inline var MAX_Y: Float = 400;
    public static inline var MIN_Y: Float = 16;

	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}

