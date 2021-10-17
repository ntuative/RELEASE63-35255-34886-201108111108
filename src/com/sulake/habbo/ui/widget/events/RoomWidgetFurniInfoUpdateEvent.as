package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1702:String = "RWFIUE_FURNI";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _name:String = "";
        private var var_2867:String = "";
        private var var_1033:BitmapData = null;
        private var var_5247:Boolean = false;
        private var var_5248:Boolean = false;
        private var var_4993:Boolean = false;
        private var var_4994:Boolean = false;
        private var var_5244:Boolean = false;
        private var var_3304:int = -1;
        private var var_4978:int = -1;
        private var var_3082:int = -1;
        private var var_3302:String = "";

        public function RoomWidgetFurniInfoUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

        public function set id(param1:int):void
        {
            this._id = param1;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function set category(param1:int):void
        {
            this._category = param1;
        }

        public function get category():int
        {
            return (this._category);
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set description(param1:String):void
        {
            this.var_2867 = param1;
        }

        public function get description():String
        {
            return (this.var_2867);
        }

        public function set image(param1:BitmapData):void
        {
            this.var_1033 = param1;
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function set isWallItem(param1:Boolean):void
        {
            this.var_5247 = param1;
        }

        public function get isWallItem():Boolean
        {
            return (this.var_5247);
        }

        public function set isStickie(param1:Boolean):void
        {
            this.var_5248 = param1;
        }

        public function get isStickie():Boolean
        {
            return (this.var_5248);
        }

        public function set isRoomOwner(param1:Boolean):void
        {
            this.var_4993 = param1;
        }

        public function get isRoomOwner():Boolean
        {
            return (this.var_4993);
        }

        public function set isRoomController(param1:Boolean):void
        {
            this.var_4994 = param1;
        }

        public function get isRoomController():Boolean
        {
            return (this.var_4994);
        }

        public function set isAnyRoomController(param1:Boolean):void
        {
            this.var_5244 = param1;
        }

        public function get isAnyRoomController():Boolean
        {
            return (this.var_5244);
        }

        public function set expiration(param1:int):void
        {
            this.var_3304 = param1;
        }

        public function get expiration():int
        {
            return (this.var_3304);
        }

        public function set catalogPageId(param1:int):void
        {
            this.var_4978 = param1;
        }

        public function get catalogPageId():int
        {
            return (this.var_4978);
        }

        public function set offerId(param1:int):void
        {
            this.var_3082 = param1;
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function set extraParam(param1:String):void
        {
            this.var_3302 = param1;
        }

        public function get extraParam():String
        {
            return (this.var_3302);
        }


    }
}