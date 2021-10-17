package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrame 
    {

        public static const var_1461:int = -1;
        public static const var_1460:int = -1;
        private static const var_2235:int = 3000;
        private static const POOL:Array = [];

        private var _id:int = 0;
        private var _x:int = 0;
        private var var_2960:int = 0;
        private var var_4594:int = 1;
        private var var_4595:int = 1;
        private var var_4596:int = 1;
        private var var_4597:int = -1;
        private var var_4598:int = 0;
        private var var_4599:Boolean = false;
        private var _isRecycled:Boolean = false;


        public static function allocate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:int=-1, param8:int=0):AnimationFrame
        {
            var _loc9_:AnimationFrame = ((POOL.length > 0) ? POOL.pop() : new (AnimationFrame)());
            _loc9_._isRecycled = false;
            _loc9_._id = param1;
            _loc9_._x = param2;
            _loc9_.var_2960 = param3;
            _loc9_.var_4599 = param6;
            if (param4 < 1)
            {
                param4 = 1;
            };
            _loc9_.var_4594 = param4;
            if (param5 < 0)
            {
                param5 = var_1461;
            };
            _loc9_.var_4595 = param5;
            _loc9_.var_4596 = param5;
            if (param7 >= 0)
            {
                _loc9_.var_4597 = param7;
                _loc9_.var_4598 = param8;
            };
            return (_loc9_);
        }


        public function get id():int
        {
            if (this._id >= 0)
            {
                return (this._id);
            };
            return (-(this._id) * Math.random());
        }

        public function get x():int
        {
            return (this._x);
        }

        public function get y():int
        {
            return (this.var_2960);
        }

        public function get repeats():int
        {
            return (this.var_4594);
        }

        public function get frameRepeats():int
        {
            return (this.var_4595);
        }

        public function get isLastFrame():Boolean
        {
            return (this.var_4599);
        }

        public function get remainingFrameRepeats():int
        {
            if (this.var_4595 < 0)
            {
                return (var_1461);
            };
            return (this.var_4596);
        }

        public function set remainingFrameRepeats(param1:int):void
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (((this.var_4595 > 0) && (param1 > this.var_4595)))
            {
                param1 = this.var_4595;
            };
            this.var_4596 = param1;
        }

        public function get activeSequence():int
        {
            return (this.var_4597);
        }

        public function get activeSequenceOffset():int
        {
            return (this.var_4598);
        }

        public function recycle():void
        {
            if (!this._isRecycled)
            {
                this._isRecycled = true;
                if (POOL.length < var_2235)
                {
                    POOL.push(this);
                };
            };
        }


    }
}