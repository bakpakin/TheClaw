package;

class SimpleParticle extends flixel.FlxSprite {

    var lifespan: Float;

    static var pool: Array<SimpleParticle> = [];

    public static function get(X: Float, Y: Float, Lifespan: Float) {
        if (pool.length == 0) {
            return new SimpleParticle(X, Y, Lifespan);
        }
        var ret = pool.pop();
        ret.x = X;
        ret.y = Y;
        ret.lifespan = Lifespan;
        return ret;
    }

    public function new(X: Float, Y: Float, Lifespan: Float) {
        super(X, Y);
        lifespan = Lifespan;
    }

    override public function update()
    {
        lifespan -= flixel.FlxG.elapsed;
        if (lifespan <= 0) {
            kill();
            pool.push(this);
        }
        super.update();
    }

}
