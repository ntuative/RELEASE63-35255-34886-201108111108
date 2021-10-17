package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class AnimationData 
    {

        public static const var_2234:int = 0;
        private static const TRANSITION_TO_ANIMATION_OFFSET:int = 1000000;
        private static const TRANSITION_FROM_ANIMATION_OFFSET:int = 2000000;

        private var var_4590:Map = null;
        private var var_4591:int = -1;
        private var var_4592:Boolean = false;
        private var var_4593:Array = null;

        public function AnimationData()
        {
            this.var_4590 = new Map();
        }

        public static function getTransitionToAnimationId(param1:int):int
        {
            return (TRANSITION_TO_ANIMATION_OFFSET + param1);
        }

        public static function var_1459(param1:int):int
        {
            return (TRANSITION_FROM_ANIMATION_OFFSET + param1);
        }

        public static function isTransitionToAnimation(param1:int):Boolean
        {
            return ((param1 >= TRANSITION_TO_ANIMATION_OFFSET) && (param1 < TRANSITION_FROM_ANIMATION_OFFSET));
        }

        public static function isTransitionFromAnimation(param1:int):Boolean
        {
            return (param1 >= TRANSITION_FROM_ANIMATION_OFFSET);
        }


        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:AnimationLayerData;
            if (this.var_4590 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4590.length)
                {
                    _loc2_ = (this.var_4590.getWithIndex(_loc1_) as AnimationLayerData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4590.dispose();
                this.var_4590 = null;
            };
            this.var_4593 = null;
        }

        public function setImmediateChanges(param1:Array):void
        {
            this.var_4593 = param1;
        }

        public function isImmediateChange(param1:int):Boolean
        {
            if (((!(this.var_4593 == null)) && (this.var_4593.indexOf(param1) >= 0)))
            {
                return (true);
            };
            return (false);
        }

        public function getStartFrame(param1:int):int
        {
            if (!this.var_4592)
            {
                return (0);
            };
            return (Math.random() * this.var_4591);
        }

        public function initialize(param1:XML):Boolean
        {
            var _loc5_:XML;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:Boolean;
            var _loc10_:String;
            var _loc11_:String;
            this.var_4592 = false;
            if (int(param1.@randomStart) != 0)
            {
                this.var_4592 = true;
            };
            var _loc2_:Array = ["id"];
            var _loc3_:XMLList = param1.animationLayer;
            var _loc4_:int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                if (!XMLValidator.checkRequiredAttributes(_loc5_, _loc2_))
                {
                    return (false);
                };
                _loc6_ = int(_loc5_.@id);
                _loc7_ = 1;
                _loc8_ = 1;
                _loc9_ = false;
                _loc10_ = _loc5_.@loopCount;
                if (_loc10_.length > 0)
                {
                    _loc7_ = int(_loc10_);
                };
                _loc11_ = _loc5_.@frameRepeat;
                if (_loc11_.length > 0)
                {
                    _loc8_ = int(_loc11_);
                };
                _loc9_ = (!(int(_loc5_.@random) == 0));
                if (!this.addLayer(_loc6_, _loc7_, _loc8_, _loc9_, _loc5_))
                {
                    return (false);
                };
                _loc4_++;
            };
            return (true);
        }

        private function addLayer(param1:int, param2:int, param3:int, param4:Boolean, param5:XML):Boolean
        {
            var _loc11_:XML;
            var _loc12_:int;
            var _loc13_:Boolean;
            var _loc14_:String;
            var _loc15_:AnimationFrameSequenceData;
            var _loc16_:XMLList;
            var _loc17_:int;
            var _loc18_:XML;
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:int;
            var _loc22_:int;
            var _loc23_:int;
            var _loc24_:DirectionalOffsetData;
            var _loc6_:AnimationLayerData = new AnimationLayerData(param2, param3, param4);
            var _loc7_:Array = ["id"];
            var _loc8_:XMLList = param5.frameSequence;
            var _loc9_:int;
            while (_loc9_ < _loc8_.length())
            {
                _loc11_ = _loc8_[_loc9_];
                _loc12_ = 1;
                _loc13_ = false;
                _loc14_ = _loc11_.@loopCount;
                if (_loc14_.length > 0)
                {
                    _loc12_ = int(_loc14_);
                };
                if (int(_loc11_.@random) != 0)
                {
                    _loc13_ = true;
                };
                _loc15_ = _loc6_.addFrameSequence(_loc12_, _loc13_);
                _loc16_ = _loc11_.frame;
                _loc17_ = 0;
                while (_loc17_ < _loc16_.length())
                {
                    _loc18_ = _loc16_[_loc17_];
                    if (!XMLValidator.checkRequiredAttributes(_loc18_, _loc7_))
                    {
                        _loc6_.dispose();
                        return (false);
                    };
                    _loc19_ = int(_loc18_.@id);
                    _loc20_ = int(_loc18_.@x);
                    _loc21_ = int(_loc18_.@y);
                    _loc22_ = int(_loc18_.@randomX);
                    _loc23_ = int(_loc18_.@randomY);
                    _loc24_ = this.readDirectionalOffsets(_loc18_);
                    _loc15_.addFrame(_loc19_, _loc20_, _loc21_, _loc22_, _loc23_, _loc24_);
                    _loc17_++;
                };
                _loc15_.initialize();
                _loc9_++;
            };
            _loc6_.calculateLength();
            this.var_4590.add(param1, _loc6_);
            var _loc10_:int = _loc6_.frameCount;
            if (_loc10_ > this.var_4591)
            {
                this.var_4591 = _loc10_;
            };
            return (true);
        }

        private function readDirectionalOffsets(param1:XML):DirectionalOffsetData
        {
            var _loc4_:Array;
            var _loc5_:XML;
            var _loc6_:XMLList;
            var _loc7_:int;
            var _loc8_:XML;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc2_:DirectionalOffsetData;
            var _loc3_:XMLList = param1.offsets;
            if (_loc3_.length() > 0)
            {
                _loc4_ = ["direction"];
                _loc5_ = _loc3_[0];
                _loc6_ = _loc5_.offset;
                _loc7_ = 0;
                while (_loc7_ < _loc6_.length())
                {
                    _loc8_ = _loc6_[_loc7_];
                    if (XMLValidator.checkRequiredAttributes(_loc8_, _loc4_))
                    {
                        _loc9_ = int(_loc8_.@direction);
                        _loc10_ = int(_loc8_.@x);
                        _loc11_ = int(_loc8_.@y);
                        if (_loc2_ == null)
                        {
                            _loc2_ = new DirectionalOffsetData();
                        };
                        _loc2_.setOffset(_loc9_, _loc10_, _loc11_);
                    };
                    _loc7_++;
                };
            };
            return (_loc2_);
        }

        public function getFrame(param1:int, param2:int, param3:int):AnimationFrame
        {
            var _loc4_:AnimationLayerData = (this.var_4590.getValue(param2) as AnimationLayerData);
            if (_loc4_ != null)
            {
                return (_loc4_.getFrame(param1, param3));
            };
            return (null);
        }

        public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int, param5:int):AnimationFrame
        {
            var _loc6_:AnimationLayerData = (this.var_4590.getValue(param2) as AnimationLayerData);
            if (_loc6_ != null)
            {
                return (_loc6_.getFrameFromSequence(param1, param3, param4, param5));
            };
            return (null);
        }


    }
}