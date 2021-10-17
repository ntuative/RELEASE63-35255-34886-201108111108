package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.utils.Dictionary;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureFireworksVisualization extends AnimatedFurnitureVisualization 
    {

        private var var_4630:Dictionary;
        private var var_4631:FurnitureParticleSystem;


        override public function dispose():void
        {
            var _loc1_:FurnitureParticleSystem;
            super.dispose();
            this.var_4631 = null;
            if (this.var_4630)
            {
                for each (_loc1_ in this.var_4630)
                {
                    _loc1_.dispose();
                };
                this.var_4630 = null;
            };
        }

        override protected function updateObject(param1:Number, param2:Number):Boolean
        {
            var _loc3_:Boolean;
            if (super.updateObject(param1, param2))
            {
                _loc3_ = false;
                if (!this.var_4630)
                {
                    this.readDefinition();
                    this.var_4631 = this.var_4630[param1];
                    _loc3_ = true;
                }
                else
                {
                    if (param1 != var_1456)
                    {
                        if (this.var_4631)
                        {
                            this.var_4631.reset();
                        };
                        this.var_4631 = this.var_4630[param1];
                        _loc3_ = true;
                    };
                };
                return (true);
            };
            return (false);
        }

        override protected function updateSprites(param1:int, param2:Boolean, param3:int):void
        {
            super.updateSprites(param1, param2, param3);
            if (this.var_4631)
            {
                this.var_4631.updateSprites();
            };
        }

        override protected function updateAnimation(param1:Number):int
        {
            if (this.var_4631)
            {
                this.var_4631.updateAnimation();
            };
            return (super.updateAnimation(param1));
        }

        override protected function setAnimation(param1:int):void
        {
            if (this.var_4631)
            {
                this.var_4631.setAnimation(param1);
            };
            super.setAnimation(param1);
        }

        override protected function getSpriteYOffset(param1:int, param2:int, param3:int):int
        {
            if (((this.var_4631) && (this.var_4631.controlsSprite(param3))))
            {
                return (this.var_4631.getSpriteYOffset(param1, param2, param3));
            };
            return (super.getSpriteYOffset(param1, param2, param3));
        }

        private function readDefinition():Boolean
        {
            var _loc5_:FurnitureParticleSystem;
            var _loc6_:int;
            var _loc7_:XML;
            var _loc1_:IRoomObject = object;
            if (_loc1_ == null)
            {
                return (false);
            };
            var _loc2_:IRoomObjectModel = _loc1_.getModel();
            if (_loc2_ == null)
            {
                return (false);
            };
            var _loc3_:String = _loc2_.getString(RoomObjectVariableEnum.var_767);
            if (_loc3_.length == 0)
            {
                Logger.log("No Particle System Data Found.");
                return (false);
            };
            var _loc4_:XML = XML(_loc3_);
            this.var_4630 = new Dictionary();
            for each (_loc7_ in _loc4_.particlesystem)
            {
                if (!_loc7_.hasOwnProperty("@size"))
                {
                    Logger.log("Particle System does not have size property!");
                }
                else
                {
                    _loc6_ = int(_loc7_.@size);
                    _loc5_ = new FurnitureParticleSystem(this);
                    _loc5_.parseData(_loc7_);
                    this.var_4630[_loc6_] = _loc5_;
                };
            };
            return (true);
        }


    }
}