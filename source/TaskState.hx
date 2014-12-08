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

class TaskState extends BasicState {

    var tileMapPath: String;
    public var solids: FlxTypedSpriteGroup<SolidSprite>;    
    public var map: FlxTilemap;

    public function new(TileMap: String = "maps/task1.tmx") {
        super();
        this.tileMapPath = TileMap;
    }

    override public function create() {
        var back = new FlxBackdrop("images/redchecker.png");
		add(back);

        
        var tiledMap = new TiledMap(tileMapPath);
        
        map = new FlxTilemap();
        map.widthInTiles = tiledMap.width;
	    map.heightInTiles = tiledMap.height;
	    map.x = 48;
        map.y = 48;
	    map.loadMap(tiledMap.layers[0].tileArray, "maps/tiles.png", 32, 32, 0, 1, 1, 1);
        add(map);

        solids = new FlxTypedSpriteGroup<SolidSprite>();
        add(solids);

        addSolidSprites();

        super.create();
    }

    public function addSolidSprites() {

    }

    override public function destroy() {
        super.destroy();
    } 

}
