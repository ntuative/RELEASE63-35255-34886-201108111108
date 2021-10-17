package com.sulake.habbo.notifications
{
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;

    public class HabboNotificationItemStyle 
    {

        private var var_4378:Array;
        private var _icon:BitmapData;
        private var var_4379:Boolean;
        private var var_4380:String;

        public function HabboNotificationItemStyle(param1:Map, param2:BitmapData, param3:Boolean, param4:String)
        {
            if (param1 == null)
            {
                this.var_4378 = [];
                this._icon = null;
            }
            else
            {
                this.var_4378 = param1["uilinks"];
                this._icon = param1["icon"];
            };
            if (param2 != null)
            {
                this._icon = param2;
                this.var_4379 = param3;
            }
            else
            {
                this.var_4379 = false;
            };
            this.var_4380 = param4;
        }

        public function dispose():void
        {
            if (((this.var_4379) && (!(this._icon == null))))
            {
                this._icon.dispose();
                this._icon = null;
            };
        }

        public function get icon():BitmapData
        {
            return (this._icon);
        }

        public function get componentLinks():Array
        {
            return (this.var_4378);
        }

        public function get iconSrc():String
        {
            return (this.var_4380);
        }


    }
}