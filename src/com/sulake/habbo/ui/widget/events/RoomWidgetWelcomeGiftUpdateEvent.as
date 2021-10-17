package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetWelcomeGiftUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1609:String = "rwwgue_welcome_gift_widget_status";

        private var var_3828:String;
        private var var_3829:Boolean;
        private var var_5277:Boolean;
        private var _furniId:int;
        private var var_3831:Boolean;

        public function RoomWidgetWelcomeGiftUpdateEvent(param1:Boolean=false, param2:Boolean=false)
        {
            super(var_1609, param1, param2);
        }

        public function get email():String
        {
            return (this.var_3828);
        }

        public function get isVerified():Boolean
        {
            return (this.var_3829);
        }

        public function get allowEmailChange():Boolean
        {
            return (this.var_5277);
        }

        public function get furniId():int
        {
            return (this._furniId);
        }

        public function get requestedByUser():Boolean
        {
            return (this.var_3831);
        }

        public function set email(param1:String):void
        {
            this.var_3828 = param1;
        }

        public function set isVerified(param1:Boolean):void
        {
            this.var_3829 = param1;
        }

        public function set allowEmailChange(param1:Boolean):void
        {
            this.var_5277 = param1;
        }

        public function set furniId(param1:int):void
        {
            this._furniId = param1;
        }

        public function set requestedByUser(param1:Boolean):void
        {
            this.var_3831 = param1;
        }


    }
}