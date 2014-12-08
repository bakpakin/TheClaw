package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("images/blockperson.png", __ASSET__images_blockperson_png);
		type.set ("images/blockperson.png", AssetType.IMAGE);
		className.set ("images/bomb.png", __ASSET__images_bomb_png);
		type.set ("images/bomb.png", AssetType.IMAGE);
		className.set ("images/car.png", __ASSET__images_car_png);
		type.set ("images/car.png", AssetType.IMAGE);
		className.set ("images/clawfinger.png", __ASSET__images_clawfinger_png);
		type.set ("images/clawfinger.png", AssetType.IMAGE);
		className.set ("images/clawhinge.png", __ASSET__images_clawhinge_png);
		type.set ("images/clawhinge.png", AssetType.IMAGE);
		className.set ("images/hand.png", __ASSET__images_hand_png);
		type.set ("images/hand.png", AssetType.IMAGE);
		className.set ("images/object.png", __ASSET__images_object_png);
		type.set ("images/object.png", AssetType.IMAGE);
		className.set ("images/redchecker.png", __ASSET__images_redchecker_png);
		type.set ("images/redchecker.png", AssetType.IMAGE);
		className.set ("images/rope.png", __ASSET__images_rope_png);
		type.set ("images/rope.png", AssetType.IMAGE);
		className.set ("images/rope.pxm", __ASSET__images_rope_pxm);
		type.set ("images/rope.pxm", AssetType.TEXT);
		className.set ("images/screen.pxm", __ASSET__images_screen_pxm);
		type.set ("images/screen.pxm", AssetType.TEXT);
		className.set ("images/screenarrow.png", __ASSET__images_screenarrow_png);
		type.set ("images/screenarrow.png", AssetType.IMAGE);
		className.set ("images/screenborder.png", __ASSET__images_screenborder_png);
		type.set ("images/screenborder.png", AssetType.IMAGE);
		className.set ("images/screenborder.pxm", __ASSET__images_screenborder_pxm);
		type.set ("images/screenborder.pxm", AssetType.TEXT);
		className.set ("images/screenbutton.png", __ASSET__images_screenbutton_png);
		type.set ("images/screenbutton.png", AssetType.IMAGE);
		className.set ("images/tallobject.png", __ASSET__images_tallobject_png);
		type.set ("images/tallobject.png", AssetType.IMAGE);
		className.set ("fonts/4b03.ttf", __ASSET__fonts_4b03_ttf);
		type.set ("fonts/4b03.ttf", AssetType.FONT);
		className.set ("fonts/about.gif", __ASSET__fonts_about_gif);
		type.set ("fonts/about.gif", AssetType.IMAGE);
		className.set ("maps/task1.tmx", __ASSET__maps_task1_tmx);
		type.set ("maps/task1.tmx", AssetType.TEXT);
		className.set ("maps/task2.tmx", __ASSET__maps_task2_tmx);
		type.set ("maps/task2.tmx", AssetType.TEXT);
		className.set ("maps/task3.tmx", __ASSET__maps_task3_tmx);
		type.set ("maps/task3.tmx", AssetType.TEXT);
		className.set ("maps/tiles.png", __ASSET__maps_tiles_png);
		type.set ("maps/tiles.png", AssetType.IMAGE);
		className.set ("maps/tiles.pxm", __ASSET__maps_tiles_pxm);
		type.set ("maps/tiles.pxm", AssetType.TEXT);
		className.set ("buttonpress", __ASSET__assets_sounds_buttonpress_mp3);
		type.set ("buttonpress", AssetType.MUSIC);
		className.set ("buttonrelease", __ASSET__assets_sounds_buttonrelease_mp3);
		type.set ("buttonrelease", AssetType.MUSIC);
		className.set ("handslide", __ASSET__assets_sounds_handslide_mp3);
		type.set ("handslide", AssetType.MUSIC);
		className.set ("pickup", __ASSET__assets_sounds_pickup_mp3);
		type.set ("pickup", AssetType.MUSIC);
		className.set ("drop", __ASSET__assets_sounds_drop_mp3);
		type.set ("drop", AssetType.MUSIC);
		className.set ("arcade", __ASSET__assets_sounds_arcade_mp3);
		type.set ("arcade", AssetType.MUSIC);
		className.set ("message", __ASSET__assets_sounds_message_mp3);
		type.set ("message", AssetType.MUSIC);
		className.set ("hurt", __ASSET__assets_sounds_hurt_mp3);
		type.set ("hurt", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "images/blockperson.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/bomb.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/car.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/clawfinger.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/clawhinge.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/hand.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/object.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/redchecker.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/rope.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/rope.pxm";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "images/screen.pxm";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "images/screenarrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/screenborder.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/screenborder.pxm";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "images/screenbutton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "images/tallobject.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "fonts/4b03.ttf";
		className.set (id, __ASSET__fonts_4b03_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/about.gif";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "maps/task1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/task2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/task3.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/tiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "maps/tiles.pxm";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "buttonpress";
		path.set (id, "assets/sounds/buttonpress.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "buttonrelease";
		path.set (id, "assets/sounds/buttonrelease.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "handslide";
		path.set (id, "assets/sounds/handslide.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "pickup";
		path.set (id, "assets/sounds/pickup.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "drop";
		path.set (id, "assets/sounds/drop.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "arcade";
		path.set (id, "assets/sounds/arcade.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "message";
		path.set (id, "assets/sounds/message.mp3");
		
		type.set (id, AssetType.MUSIC);
		id = "hurt";
		path.set (id, "assets/sounds/hurt.mp3");
		
		type.set (id, AssetType.MUSIC);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__fonts_4b03_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("images/blockperson.png", __ASSET__images_blockperson_png);
		type.set ("images/blockperson.png", AssetType.IMAGE);
		
		className.set ("images/bomb.png", __ASSET__images_bomb_png);
		type.set ("images/bomb.png", AssetType.IMAGE);
		
		className.set ("images/car.png", __ASSET__images_car_png);
		type.set ("images/car.png", AssetType.IMAGE);
		
		className.set ("images/clawfinger.png", __ASSET__images_clawfinger_png);
		type.set ("images/clawfinger.png", AssetType.IMAGE);
		
		className.set ("images/clawhinge.png", __ASSET__images_clawhinge_png);
		type.set ("images/clawhinge.png", AssetType.IMAGE);
		
		className.set ("images/hand.png", __ASSET__images_hand_png);
		type.set ("images/hand.png", AssetType.IMAGE);
		
		className.set ("images/object.png", __ASSET__images_object_png);
		type.set ("images/object.png", AssetType.IMAGE);
		
		className.set ("images/redchecker.png", __ASSET__images_redchecker_png);
		type.set ("images/redchecker.png", AssetType.IMAGE);
		
		className.set ("images/rope.png", __ASSET__images_rope_png);
		type.set ("images/rope.png", AssetType.IMAGE);
		
		className.set ("images/rope.pxm", __ASSET__images_rope_pxm);
		type.set ("images/rope.pxm", AssetType.TEXT);
		
		className.set ("images/screen.pxm", __ASSET__images_screen_pxm);
		type.set ("images/screen.pxm", AssetType.TEXT);
		
		className.set ("images/screenarrow.png", __ASSET__images_screenarrow_png);
		type.set ("images/screenarrow.png", AssetType.IMAGE);
		
		className.set ("images/screenborder.png", __ASSET__images_screenborder_png);
		type.set ("images/screenborder.png", AssetType.IMAGE);
		
		className.set ("images/screenborder.pxm", __ASSET__images_screenborder_pxm);
		type.set ("images/screenborder.pxm", AssetType.TEXT);
		
		className.set ("images/screenbutton.png", __ASSET__images_screenbutton_png);
		type.set ("images/screenbutton.png", AssetType.IMAGE);
		
		className.set ("images/tallobject.png", __ASSET__images_tallobject_png);
		type.set ("images/tallobject.png", AssetType.IMAGE);
		
		className.set ("fonts/4b03.ttf", __ASSET__fonts_4b03_ttf);
		type.set ("fonts/4b03.ttf", AssetType.FONT);
		
		className.set ("fonts/about.gif", __ASSET__fonts_about_gif);
		type.set ("fonts/about.gif", AssetType.IMAGE);
		
		className.set ("maps/task1.tmx", __ASSET__maps_task1_tmx);
		type.set ("maps/task1.tmx", AssetType.TEXT);
		
		className.set ("maps/task2.tmx", __ASSET__maps_task2_tmx);
		type.set ("maps/task2.tmx", AssetType.TEXT);
		
		className.set ("maps/task3.tmx", __ASSET__maps_task3_tmx);
		type.set ("maps/task3.tmx", AssetType.TEXT);
		
		className.set ("maps/tiles.png", __ASSET__maps_tiles_png);
		type.set ("maps/tiles.png", AssetType.IMAGE);
		
		className.set ("maps/tiles.pxm", __ASSET__maps_tiles_pxm);
		type.set ("maps/tiles.pxm", AssetType.TEXT);
		
		className.set ("buttonpress", __ASSET__assets_sounds_buttonpress_mp3);
		type.set ("buttonpress", AssetType.MUSIC);
		
		className.set ("buttonrelease", __ASSET__assets_sounds_buttonrelease_mp3);
		type.set ("buttonrelease", AssetType.MUSIC);
		
		className.set ("handslide", __ASSET__assets_sounds_handslide_mp3);
		type.set ("handslide", AssetType.MUSIC);
		
		className.set ("pickup", __ASSET__assets_sounds_pickup_mp3);
		type.set ("pickup", AssetType.MUSIC);
		
		className.set ("drop", __ASSET__assets_sounds_drop_mp3);
		type.set ("drop", AssetType.MUSIC);
		
		className.set ("arcade", __ASSET__assets_sounds_arcade_mp3);
		type.set ("arcade", AssetType.MUSIC);
		
		className.set ("message", __ASSET__assets_sounds_message_mp3);
		type.set ("message", AssetType.MUSIC);
		
		className.set ("hurt", __ASSET__assets_sounds_hurt_mp3);
		type.set ("hurt", AssetType.MUSIC);
		*/
		var useManifest = true;
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		//return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		//else 
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__images_blockperson_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_bomb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_car_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_clawfinger_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_clawhinge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_hand_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_object_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_redchecker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_rope_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_rope_pxm extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__images_screen_pxm extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__images_screenarrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_screenborder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_screenborder_pxm extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__images_screenbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__images_tallobject_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__fonts_4b03_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_about_gif extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__maps_task1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_task2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_task3_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__maps_tiles_pxm extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_buttonpress_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_buttonrelease_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_handslide_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_pickup_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_drop_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_arcade_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_message_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hurt_mp3 extends flash.media.Sound { }


#elseif html5

#if openfl


















@:keep #if display private #end class __ASSET__fonts_4b03_ttf extends openfl.text.Font { public function new () { super (); fontName = "fonts/4b03.ttf"; } } 















#end

#else

#if openfl
class __ASSET__fonts_4b03_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "fonts/4b03.ttf"; fontName = "04b03"; }}

#end

#if (windows || mac || linux)

//
//@:sound("/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends openfl.media.Sound {}
//@:sound("/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends openfl.media.Sound {}
//@:bitmap("assets/images/blockperson.png") class __ASSET__images_blockperson_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/bomb.png") class __ASSET__images_bomb_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/car.png") class __ASSET__images_car_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/clawfinger.png") class __ASSET__images_clawfinger_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/clawhinge.png") class __ASSET__images_clawhinge_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/hand.png") class __ASSET__images_hand_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/object.png") class __ASSET__images_object_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/redchecker.png") class __ASSET__images_redchecker_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/rope.png") class __ASSET__images_rope_png extends openfl.display.BitmapData {}
//@:file("assets/images/rope.pxm") class __ASSET__images_rope_pxm extends lime.utils.ByteArray {}
//@:file("assets/images/screen.pxm") class __ASSET__images_screen_pxm extends lime.utils.ByteArray {}
//@:bitmap("assets/images/screenarrow.png") class __ASSET__images_screenarrow_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/screenborder.png") class __ASSET__images_screenborder_png extends openfl.display.BitmapData {}
//@:file("assets/images/screenborder.pxm") class __ASSET__images_screenborder_pxm extends lime.utils.ByteArray {}
//@:bitmap("assets/images/screenbutton.png") class __ASSET__images_screenbutton_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tallobject.png") class __ASSET__images_tallobject_png extends openfl.display.BitmapData {}
//@:font("assets/fonts/4b03.ttf") class __ASSET__fonts_4b03_ttf extends openfl.text.Font {}
//@:bitmap("assets/fonts/about.gif") class __ASSET__fonts_about_gif extends openfl.display.BitmapData {}
//@:file("assets/maps/task1.tmx") class __ASSET__maps_task1_tmx extends lime.utils.ByteArray {}
//@:file("assets/maps/task2.tmx") class __ASSET__maps_task2_tmx extends lime.utils.ByteArray {}
//@:file("assets/maps/task3.tmx") class __ASSET__maps_task3_tmx extends lime.utils.ByteArray {}
//@:bitmap("assets/maps/tiles.png") class __ASSET__maps_tiles_png extends openfl.display.BitmapData {}
//@:file("assets/maps/tiles.pxm") class __ASSET__maps_tiles_pxm extends lime.utils.ByteArray {}
//@:sound("assets/sounds/buttonpress.mp3") class __ASSET__assets_sounds_buttonpress_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/buttonrelease.mp3") class __ASSET__assets_sounds_buttonrelease_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/handslide.mp3") class __ASSET__assets_sounds_handslide_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/pickup.mp3") class __ASSET__assets_sounds_pickup_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/drop.mp3") class __ASSET__assets_sounds_drop_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/arcade.mp3") class __ASSET__assets_sounds_arcade_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/message.mp3") class __ASSET__assets_sounds_message_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/hurt.mp3") class __ASSET__assets_sounds_hurt_mp3 extends openfl.media.Sound {}
//
//

#end

#end
#end

