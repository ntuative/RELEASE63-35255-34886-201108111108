package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class AnimationSizeData extends SizeData 
    {

        private var var_2876:Map = null;
        private var var_4607:Array = [];

        public function AnimationSizeData(param1:int, param2:int)
        {
            super(param1, param2);
            this.var_2876 = new Map();
        }

        override public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:AnimationData;
            super.dispose();
            if (this.var_2876 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_2876.length)
                {
                    _loc2_ = (this.var_2876.getWithIndex(_loc1_) as AnimationData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_2876.dispose();
                this.var_2876 = null;
            };
        }

        public function defineAnimations(param1:XML):Boolean
        {
            var _loc5_:XML;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:String;
            var _loc9_:AnimationData;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:Array;
            var _loc13_:Array;
            var _loc14_:String;
            var _loc15_:int;
            if (param1 == null)
            {
                return (true);
            };
            var _loc2_:Array = ["id"];
            var _loc3_:XMLList = param1.animation;
            var _loc4_:int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                if (!XMLValidator.checkRequiredAttributes(_loc5_, _loc2_))
                {
                    return (false);
                };
                _loc6_ = int(_loc5_.@id);
                _loc7_ = false;
                _loc8_ = _loc5_.@transitionTo;
                if (_loc8_.length > 0)
                {
                    _loc10_ = int(_loc8_);
                    _loc6_ = AnimationData.getTransitionToAnimationId(_loc10_);
                    _loc7_ = true;
                };
                _loc8_ = _loc5_.@transitionFrom;
                if (_loc8_.length > 0)
                {
                    _loc11_ = int(_loc8_);
                    _loc6_ = AnimationData.var_1459(_loc11_);
                    _loc7_ = true;
                };
                _loc9_ = this.createAnimationData();
                if (!_loc9_.initialize(_loc5_))
                {
                    _loc9_.dispose();
                    return (false);
                };
                _loc8_ = _loc5_.@immediateChangeFrom;
                if (_loc8_.length > 0)
                {
                    _loc12_ = _loc8_.split(",");
                    _loc13_ = [];
                    for each (_loc14_ in _loc12_)
                    {
                        _loc15_ = int(_loc14_);
                        if (_loc13_.indexOf(_loc15_) < 0)
                        {
                            _loc13_.push(_loc15_);
                        };
                    };
                    _loc9_.setImmediateChanges(_loc13_);
                };
                this.var_2876.add(_loc6_, _loc9_);
                if (!_loc7_)
                {
                    this.var_4607.push(_loc6_);
                };
                _loc4_++;
            };
            return (true);
        }

        protected function createAnimationData():AnimationData
        {
            return (new AnimationData());
        }

        public function hasAnimation(param1:int):Boolean
        {
            if (this.var_2876.getValue(param1) != null)
            {
                return (true);
            };
            return (false);
        }

        public function getAnimationCount():int
        {
            return (this.var_4607.length);
        }

        public function getAnimationId(param1:int):int
        {
            var _loc2_:int = this.getAnimationCount();
            if (((param1 >= 0) && (_loc2_ > 0)))
            {
                return (this.var_4607[(param1 % _loc2_)]);
            };
            return (0);
        }

        public function isImmediateChange(param1:int, param2:int):Boolean
        {
            var _loc3_:AnimationData = (this.var_2876.getValue(param1) as AnimationData);
            if (_loc3_ != null)
            {
                return (_loc3_.isImmediateChange(param2));
            };
            return (false);
        }

        public function getStartFrame(param1:int, param2:int):int
        {
            var _loc3_:AnimationData = (this.var_2876.getValue(param1) as AnimationData);
            if (_loc3_ != null)
            {
                return (_loc3_.getStartFrame(param2));
            };
            return (0);
        }

        public function getFrame(param1:int, param2:int, param3:int, param4:int):AnimationFrame
        {
            var _loc6_:AnimationFrame;
            var _loc5_:AnimationData = (this.var_2876.getValue(param1) as AnimationData);
            if (_loc5_ != null)
            {
                return (_loc5_.getFrame(param2, param3, param4));
            };
            return (null);
        }

        public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int):AnimationFrame
        {
            var _loc8_:AnimationFrame;
            var _loc7_:AnimationData = (this.var_2876.getValue(param1) as AnimationData);
            if (_loc7_ != null)
            {
                return (_loc7_.getFrameFromSequence(param2, param3, param4, param5, param6));
            };
            return (null);
        }


    }
}