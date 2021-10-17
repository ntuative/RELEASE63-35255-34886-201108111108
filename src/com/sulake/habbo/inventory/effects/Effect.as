package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
    import flash.display.BitmapData;

    public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem 
    {

        private var _type:int;
        private var var_3424:int;
        private var var_4062:int = 1;
        private var var_4063:int;
        private var var_4064:Boolean = false;
        private var _isSelected:Boolean = false;
        private var var_4044:Boolean = false;
        private var var_2921:BitmapData;
        private var var_4065:Date;


        public function get type():int
        {
            return (this._type);
        }

        public function get duration():int
        {
            return (this.var_3424);
        }

        public function get effectsInInventory():int
        {
            return (this.var_4062);
        }

        public function get isActive():Boolean
        {
            return (this.var_4064);
        }

        public function get isInUse():Boolean
        {
            return (this.var_4044);
        }

        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }

        public function get icon():BitmapData
        {
            return (this.var_2921);
        }

        public function get iconImage():BitmapData
        {
            return (this.var_2921);
        }

        public function get secondsLeft():int
        {
            var _loc1_:int;
            if (this.var_4064)
            {
                _loc1_ = int((this.var_4063 - ((new Date().valueOf() - this.var_4065.valueOf()) / 1000)));
                _loc1_ = Math.floor(_loc1_);
                if (_loc1_ < 0)
                {
                    _loc1_ = 0;
                };
                return (_loc1_);
            };
            return (this.var_4063);
        }

        public function set type(param1:int):void
        {
            this._type = param1;
        }

        public function set duration(param1:int):void
        {
            this.var_3424 = param1;
        }

        public function set secondsLeft(param1:int):void
        {
            this.var_4063 = param1;
        }

        public function set isSelected(param1:Boolean):void
        {
            this._isSelected = param1;
        }

        public function set isInUse(param1:Boolean):void
        {
            this.var_4044 = param1;
        }

        public function set iconImage(param1:BitmapData):void
        {
            this.var_2921 = param1;
        }

        public function set effectsInInventory(param1:int):void
        {
            this.var_4062 = param1;
        }

        public function set isActive(param1:Boolean):void
        {
            if (((param1) && (!(this.var_4064))))
            {
                this.var_4065 = new Date();
            };
            this.var_4064 = param1;
        }

        public function setOneEffectExpired():void
        {
            this.var_4062--;
            if (this.var_4062 < 0)
            {
                this.var_4062 = 0;
            };
            this.var_4063 = this.var_3424;
            this.var_4064 = false;
            this.var_4044 = false;
        }


    }
}