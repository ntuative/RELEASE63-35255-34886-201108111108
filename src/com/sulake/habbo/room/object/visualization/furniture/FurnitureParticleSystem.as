package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.geom.Point;
    import flash.display.BlendMode;
    import flash.geom.Vector3D;

    public class FurnitureParticleSystem 
    {

        private var var_4635:Dictionary;
        private var _visualization:AnimatedFurnitureVisualization;
        private var var_4636:int;
        private var var_4637:int;
        private var var_2703:int;
        private var var_4638:FurnitureParticleSystemEmitter;
        private var var_2895:BitmapData;
        private var var_4639:IRoomObjectSprite;
        private var var_4640:Boolean = false;
        private var var_4513:int = 0;
        private var var_4514:int = 0;
        private var var_4641:Number = 1;
        private var var_4642:BitmapData;
        private var var_4634:ColorTransform;
        private var var_4643:ColorTransform;
        private var var_4644:Matrix;
        private var _translationMatrix:Matrix;
        private var var_1213:Number = 1;

        public function FurnitureParticleSystem(param1:AnimatedFurnitureVisualization)
        {
            this.var_4635 = new Dictionary();
            this._visualization = param1;
            this.var_4634 = new ColorTransform();
            this.var_4634.alphaMultiplier = 1;
            this.var_4643 = new ColorTransform();
            this.var_4644 = new Matrix();
            this._translationMatrix = new Matrix();
        }

        public function dispose():void
        {
            var _loc1_:FurnitureParticleSystemEmitter;
            for each (_loc1_ in this.var_4635)
            {
                _loc1_.dispose();
            };
            this.var_4635 = null;
            if (this.var_2895)
            {
                this.var_2895.dispose();
                this.var_2895 = null;
            };
            if (this.var_4642)
            {
                this.var_4642.dispose();
                this.var_4642 = null;
            };
            this.var_4634 = null;
            this.var_4643 = null;
            this.var_4644 = null;
            this._translationMatrix = null;
        }

        public function reset():void
        {
            if (this.var_4638)
            {
                this.var_4638.reset();
            };
            this.var_4638 = null;
            this.var_4640 = false;
            this.updateCanvas();
        }

        public function setAnimation(param1:int):void
        {
            if (this.var_4638)
            {
                this.var_4638.reset();
            };
            this.var_4638 = this.var_4635[param1];
            this.var_4640 = false;
            this.updateCanvas();
        }

        private function updateCanvas():void
        {
            if (!this.var_4638)
            {
                return;
            };
            if (this.var_4637 >= 0)
            {
                this.var_4639 = this._visualization.getSprite(this.var_4637);
                if (((this.var_4639) && (this.var_4639.asset)))
                {
                    if (((this.var_4639.width <= 1) || (this.var_4639.height <= 1)))
                    {
                        return;
                    };
                    if (this.var_2895 == null)
                    {
                        this.var_2895 = this.var_4639.asset.clone();
                        if (this.var_4634.alphaMultiplier != 1)
                        {
                            this.var_4642 = new BitmapData(this.var_2895.width, this.var_2895.height, true, 0xFF000000);
                        };
                    };
                    this.var_4513 = -(this.var_4639.offsetX);
                    this.var_4514 = -(this.var_4639.offsetY);
                    this.var_4639.asset = this.var_2895;
                };
                if (this.var_2895)
                {
                    this.var_2895.fillRect(this.var_2895.rect, 0xFF000000);
                };
                if (this.var_4642)
                {
                    this.var_4642.fillRect(this.var_4642.rect, 0xFF000000);
                };
            };
        }

        public function getSpriteYOffset(param1:int, param2:int, param3:int):int
        {
            if (((this.var_4638) && (this.var_4638.roomObjectSpriteId == param3)))
            {
                return (this.var_4638.y * this.var_4641);
            };
            return (0);
        }

        public function controlsSprite(param1:int):Boolean
        {
            if (this.var_4638)
            {
                return (this.var_4638.roomObjectSpriteId == param1);
            };
            return (false);
        }

        public function updateSprites():void
        {
            if (((!(this.var_4638)) || (!(this.var_4639))))
            {
                return;
            };
            if (((this.var_2895) && (!(this.var_4639.asset == this.var_2895))))
            {
                this.var_4639.asset = this.var_2895;
            };
            if (this.var_4640)
            {
                if (this.var_4638.roomObjectSpriteId >= 0)
                {
                    this._visualization.getSprite(this.var_4638.roomObjectSpriteId).visible = false;
                };
            };
        }

        public function updateAnimation():void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:Rectangle;
            var _loc6_:IGraphicAsset;
            var _loc7_:BitmapData;
            var _loc9_:Point;
            var _loc10_:Point;
            var _loc11_:FurnitureParticleSystemParticle;
            if (((!(this.var_4638)) || (!(this.var_4639))))
            {
                return;
            };
            var _loc1_:Number = 10;
            var _loc2_:Number = 0;
            var _loc8_:int;
            if (((!(this.var_4640)) && (this.var_4638.hasIgnited)))
            {
                this.var_4640 = true;
            };
            _loc8_ = (this.var_2703 * this.var_4641);
            this.var_4638.update();
            if (this.var_4640)
            {
                if (this.var_4638.roomObjectSpriteId >= 0)
                {
                    this._visualization.getSprite(this.var_4638.roomObjectSpriteId).visible = false;
                };
                if (!this.var_2895)
                {
                    this.updateCanvas();
                };
                this.var_2895.lock();
                if (this.var_4634.alphaMultiplier == 1)
                {
                    this.var_2895.fillRect(this.var_2895.rect, 0xFF000000);
                }
                else
                {
                    this.var_2895.draw(this.var_4642, this.var_4644, this.var_4634, BlendMode.NORMAL, null, false);
                };
                for each (_loc11_ in this.var_4638.particles)
                {
                    _loc2_ = _loc11_.y;
                    _loc3_ = int((this.var_4513 + ((((_loc11_.x - _loc11_.z) * _loc1_) / 10) * this.var_4641)));
                    _loc4_ = int(((this.var_4514 - _loc8_) + ((((_loc2_ + ((_loc11_.x + _loc11_.z) / 2)) * _loc1_) / 10) * this.var_4641)));
                    _loc6_ = _loc11_.getAsset();
                    if (_loc6_)
                    {
                        _loc7_ = (_loc6_.asset.content as BitmapData);
                        if (((_loc11_.fade) && (_loc11_.alphaMultiplier < 1)))
                        {
                            this._translationMatrix.identity();
                            this._translationMatrix.translate((_loc3_ + _loc6_.offsetX), (_loc4_ + _loc6_.offsetY));
                            this.var_4643.alphaMultiplier = _loc11_.alphaMultiplier;
                            this.var_2895.draw(_loc7_, this._translationMatrix, this.var_4643, BlendMode.NORMAL, null, false);
                        }
                        else
                        {
                            _loc10_ = new Point((_loc3_ + _loc6_.offsetX), (_loc4_ + _loc6_.offsetY));
                            this.var_2895.copyPixels(_loc7_, _loc7_.rect, _loc10_, null, null, true);
                        };
                    }
                    else
                    {
                        _loc5_ = new Rectangle((_loc3_ - 1), (_loc4_ - 1), 2, 2);
                        this.var_2895.fillRect(_loc5_, 0xFFFFFFFF);
                    };
                };
                this.var_2895.unlock();
            };
        }

        public function parseData(param1:XML):void
        {
            var _loc2_:IRoomObjectSprite;
            var _loc3_:XML;
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:FurnitureParticleSystemEmitter;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:Number;
            var _loc13_:Number;
            var _loc14_:Number;
            var _loc15_:Number;
            var _loc16_:String;
            var _loc17_:Number;
            var _loc18_:int;
            var _loc19_:Boolean;
            var _loc20_:Boolean;
            var _loc21_:Array;
            var _loc22_:IGraphicAsset;
            var _loc23_:XML;
            var _loc24_:XML;
            this.var_4636 = parseInt(param1.@size);
            this.var_4637 = ((param1.hasOwnProperty("@canvas_id")) ? parseInt(param1.@canvas_id) : -1);
            this.var_2703 = ((param1.hasOwnProperty("@offset_y")) ? parseInt(param1.@offset_y) : 10);
            this.var_4641 = (this.var_4636 / 64);
            this.var_1213 = ((param1.hasOwnProperty("@blend")) ? Number(param1.@blend) : 1);
            this.var_1213 = Math.min(this.var_1213, 1);
            this.var_4634.alphaMultiplier = this.var_1213;
            for each (_loc3_ in param1.emitter)
            {
                _loc4_ = parseInt(_loc3_.@id);
                _loc5_ = _loc3_.@name;
                _loc6_ = parseInt(_loc3_.@sprite_id);
                _loc7_ = new FurnitureParticleSystemEmitter(_loc5_, _loc6_);
                this.var_4635[_loc4_] = _loc7_;
                _loc8_ = parseInt(_loc3_.@max_num_particles);
                _loc9_ = parseInt(_loc3_.@particles_per_frame);
                _loc10_ = ((_loc3_.hasOwnProperty("@burst_pulse")) ? parseInt(_loc3_.@burst_pulse) : 1);
                _loc11_ = parseInt(_loc3_.@fuse_time);
                _loc12_ = Number(_loc3_.simulation.@force);
                _loc13_ = Number(_loc3_.simulation.@direction);
                _loc14_ = Number(_loc3_.simulation.@gravity);
                _loc15_ = Number(_loc3_.simulation.@airfriction);
                _loc16_ = _loc3_.simulation.@shape;
                _loc17_ = Number(_loc3_.simulation.@energy);
                for each (_loc23_ in _loc3_.particles.particle)
                {
                    _loc18_ = parseInt(_loc23_.@lifetime);
                    _loc19_ = ((_loc23_.@is_emitter == "false") ? false : true);
                    _loc20_ = (((_loc23_.hasOwnProperty("@fade")) && (_loc23_.@fade == "true")) ? true : false);
                    _loc21_ = [];
                    for each (_loc24_ in _loc23_.frame)
                    {
                        _loc22_ = this._visualization.assetCollection.getAsset(_loc24_.@name);
                        _loc21_.push(_loc22_);
                    };
                    _loc7_.configureParticle(_loc18_, _loc19_, _loc21_, _loc20_);
                };
                _loc7_.setup(_loc8_, _loc9_, _loc12_, new Vector3D(0, _loc13_, 0), _loc14_, _loc15_, _loc16_, _loc17_, _loc11_, _loc10_);
            };
        }


    }
}