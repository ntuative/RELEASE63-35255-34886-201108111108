package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import flash.display.Shader;
    import flash.filters.ShaderFilter;
    import flash.filters.ColorMatrixFilter;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.display.BlendMode;

    public class RoomObjectHightLighter 
    {

        private var var_4942:HabboUserDefinedRoomEvents;
        private var var_4958:Array;

        public function RoomObjectHightLighter(param1:HabboUserDefinedRoomEvents)
        {
            var _loc2_:Class;
            var _loc3_:Shader;
            var _loc4_:ShaderFilter;
            var _loc5_:Array;
            var _loc6_:ColorMatrixFilter;
            super();
            this.var_4942 = param1;
            _loc2_ = RoomObjectHightLighter_GrayscaleFilter;
            _loc3_ = new Shader((new (_loc2_)() as ByteArray));
            _loc4_ = new ShaderFilter(_loc3_);
            this.var_4958 = [_loc4_];
            return;
            _loc5_ = [3.5, 6.5, 1, 0, -1200, 3.5, 6.5, 1, 0, -1200, 3.5, 6.5, 1, 0, -1200, 0, 0, 0, 1, 0];
            _loc6_ = new ColorMatrixFilter(_loc5_);
            this.var_4958 = [_loc6_];
        }

        public function hide(param1:int):void
        {
            this.inactivateFurni(this.getFurni(param1));
        }

        public function hideAll(param1:Dictionary):void
        {
            var _loc2_:String;
            for (_loc2_ in param1)
            {
                Logger.log(("Show furni as unselected: " + _loc2_));
                this.inactivateFurni(this.getFurni(parseInt(_loc2_)));
            };
        }

        public function show(param1:int):void
        {
            this.activateFurni(this.getFurni(param1));
        }

        public function showAll(param1:Dictionary):void
        {
            var _loc2_:String;
            for (_loc2_ in param1)
            {
                Logger.log(("Show furni as selected: " + _loc2_));
                this.activateFurni(this.getFurni(parseInt(_loc2_)));
            };
        }

        private function getFurni(param1:int):IRoomObject
        {
            return (this.var_4942.roomEngine.getRoomObject(this.var_4942.roomId, this.var_4942.roomCategory, param1, RoomObjectCategoryEnum.var_70));
        }

        private function activateFurni(param1:IRoomObject):void
        {
            var _loc2_:IRoomObjectSpriteVisualization;
            var _loc3_:int;
            var _loc4_:IRoomObjectSprite;
            if (param1)
            {
                _loc2_ = (param1.getVisualization() as IRoomObjectSpriteVisualization);
                Logger.log(("Furni visualization: " + _loc2_));
                _loc3_ = 0;
                while (_loc3_ < _loc2_.spriteCount)
                {
                    _loc4_ = _loc2_.getSprite(_loc3_);
                    if (_loc4_.blendMode != BlendMode.ADD)
                    {
                        _loc4_.filters = this.var_4958;
                    };
                    _loc3_++;
                };
            };
        }

        private function inactivateFurni(param1:IRoomObject):void
        {
            var _loc2_:IRoomObjectSpriteVisualization;
            var _loc3_:int;
            var _loc4_:IRoomObjectSprite;
            if (param1)
            {
                _loc2_ = (param1.getVisualization() as IRoomObjectSpriteVisualization);
                Logger.log(("Furni visualization: " + _loc2_));
                _loc3_ = 0;
                while (_loc3_ < _loc2_.spriteCount)
                {
                    _loc4_ = _loc2_.getSprite(_loc3_);
                    _loc4_.filters = [];
                    _loc3_++;
                };
            };
        }


    }
}