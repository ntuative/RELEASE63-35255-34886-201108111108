package com.sulake.core.window.utils
{
    import com.sulake.core.window.IWindow;

    public class WindowRectLimits implements IRectLimiter 
    {

        private var var_2802:int = -2147483648;
        private var var_2803:int = 2147483647;
        private var var_2804:int = -2147483648;
        private var var_2805:int = 2147483647;
        private var _target:IWindow;

        public function WindowRectLimits(param1:IWindow)
        {
            this._target = param1;
        }

        public function get minWidth():int
        {
            return (this.var_2802);
        }

        public function get maxWidth():int
        {
            return (this.var_2803);
        }

        public function get minHeight():int
        {
            return (this.var_2804);
        }

        public function get maxHeight():int
        {
            return (this.var_2805);
        }

        public function set minWidth(param1:int):void
        {
            this.var_2802 = param1;
            if ((((this.var_2802 > int.MIN_VALUE) && (!(this._target.disposed))) && (this._target.width < this.var_2802)))
            {
                this._target.width = this.var_2802;
            };
        }

        public function set maxWidth(param1:int):void
        {
            this.var_2803 = param1;
            if ((((this.var_2803 < int.MAX_VALUE) && (!(this._target.disposed))) && (this._target.width > this.var_2803)))
            {
                this._target.width = this.var_2803;
            };
        }

        public function set minHeight(param1:int):void
        {
            this.var_2804 = param1;
            if ((((this.var_2804 > int.MIN_VALUE) && (!(this._target.disposed))) && (this._target.height < this.var_2804)))
            {
                this._target.height = this.var_2804;
            };
        }

        public function set maxHeight(param1:int):void
        {
            this.var_2805 = param1;
            if ((((this.var_2805 < int.MAX_VALUE) && (!(this._target.disposed))) && (this._target.height > this.var_2805)))
            {
                this._target.height = this.var_2805;
            };
        }

        public function get isEmpty():Boolean
        {
            return ((((this.var_2802 == int.MIN_VALUE) && (this.var_2803 == int.MAX_VALUE)) && (this.var_2804 == int.MIN_VALUE)) && (this.var_2805 == int.MAX_VALUE));
        }

        public function setEmpty():void
        {
            this.var_2802 = int.MIN_VALUE;
            this.var_2803 = int.MAX_VALUE;
            this.var_2804 = int.MIN_VALUE;
            this.var_2805 = int.MAX_VALUE;
        }

        public function limit():void
        {
            if (((!(this.isEmpty)) && (this._target)))
            {
                if (this._target.width < this.var_2802)
                {
                    this._target.width = this.var_2802;
                }
                else
                {
                    if (this._target.width > this.var_2803)
                    {
                        this._target.width = this.var_2803;
                    };
                };
                if (this._target.height < this.var_2804)
                {
                    this._target.height = this.var_2804;
                }
                else
                {
                    if (this._target.height > this.var_2805)
                    {
                        this._target.height = this.var_2805;
                    };
                };
            };
        }

        public function assign(param1:int, param2:int, param3:int, param4:int):void
        {
            this.var_2802 = param1;
            this.var_2803 = param2;
            this.var_2804 = param3;
            this.var_2805 = param4;
            this.limit();
        }

        public function clone(param1:IWindow):WindowRectLimits
        {
            var _loc2_:WindowRectLimits = new WindowRectLimits(param1);
            _loc2_.var_2802 = this.var_2802;
            _loc2_.var_2803 = this.var_2803;
            _loc2_.var_2804 = this.var_2804;
            _loc2_.var_2805 = this.var_2805;
            return (_loc2_);
        }


    }
}