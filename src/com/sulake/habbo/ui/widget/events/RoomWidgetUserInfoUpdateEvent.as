package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1697:String = "RWUIUE_OWN_USER";
        public static const BOT:String = "RWUIUE_BOT";
        public static const var_1641:String = "RWUIUE_PEER";
        public static const TRADE_REASON_OK:int = 0;
        public static const var_2312:int = 2;
        public static const var_2313:int = 3;
        public static const var_2314:String = "BOT";

        private var _name:String = "";
        private var var_3402:String = "";
        private var var_3548:int;
        private var var_3549:int = 0;
        private var var_3552:int = 0;
        private var var_2994:String = "";
        private var var_1033:BitmapData = null;
        private var var_3862:Array = [];
        private var var_3581:int = 0;
        private var var_5264:String = "";
        private var var_5265:int = 0;
        private var var_5266:int = 0;
        private var var_4996:Boolean = false;
        private var _realName:String = "";
        private var var_5185:Boolean = false;
        private var var_5267:Boolean = false;
        private var var_5268:Boolean = true;
        private var var_3690:int = 0;
        private var var_5269:Boolean = false;
        private var var_5270:Boolean = false;
        private var var_5271:Boolean = false;
        private var var_5272:Boolean = false;
        private var var_5273:Boolean = false;
        private var var_5274:Boolean = false;
        private var var_5275:int = 0;
        private var var_4993:Boolean = false;

        public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set motto(param1:String):void
        {
            this.var_3402 = param1;
        }

        public function get motto():String
        {
            return (this.var_3402);
        }

        public function set achievementScore(param1:int):void
        {
            this.var_3548 = param1;
        }

        public function get achievementScore():int
        {
            return (this.var_3548);
        }

        public function set webID(param1:int):void
        {
            this.var_3549 = param1;
        }

        public function get webID():int
        {
            return (this.var_3549);
        }

        public function set xp(param1:int):void
        {
            this.var_3552 = param1;
        }

        public function get xp():int
        {
            return (this.var_3552);
        }

        public function set figure(param1:String):void
        {
            this.var_2994 = param1;
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function set image(param1:BitmapData):void
        {
            this.var_1033 = param1;
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function set badges(param1:Array):void
        {
            this.var_3862 = param1;
        }

        public function get badges():Array
        {
            return (this.var_3862);
        }

        public function set groupId(param1:int):void
        {
            this.var_3581 = param1;
        }

        public function get groupId():int
        {
            return (this.var_3581);
        }

        public function set groupBadgeId(param1:String):void
        {
            this.var_5264 = param1;
        }

        public function get groupBadgeId():String
        {
            return (this.var_5264);
        }

        public function set canBeAskedAsFriend(param1:Boolean):void
        {
            this.var_5267 = param1;
        }

        public function get canBeAskedAsFriend():Boolean
        {
            return (this.var_5267);
        }

        public function set respectLeft(param1:int):void
        {
            this.var_3690 = param1;
        }

        public function get respectLeft():int
        {
            return (this.var_3690);
        }

        public function set isIgnored(param1:Boolean):void
        {
            this.var_5269 = param1;
        }

        public function get isIgnored():Boolean
        {
            return (this.var_5269);
        }

        public function set amIOwner(param1:Boolean):void
        {
            this.var_5270 = param1;
        }

        public function get amIOwner():Boolean
        {
            return (this.var_5270);
        }

        public function set amIController(param1:Boolean):void
        {
            this.var_5271 = param1;
        }

        public function get amIController():Boolean
        {
            return (this.var_5271);
        }

        public function set amIAnyRoomController(param1:Boolean):void
        {
            this.var_5272 = param1;
        }

        public function get amIAnyRoomController():Boolean
        {
            return (this.var_5272);
        }

        public function set hasFlatControl(param1:Boolean):void
        {
            this.var_5273 = param1;
        }

        public function get hasFlatControl():Boolean
        {
            return (this.var_5273);
        }

        public function set canTrade(param1:Boolean):void
        {
            this.var_5274 = param1;
        }

        public function get canTrade():Boolean
        {
            return (this.var_5274);
        }

        public function set canTradeReason(param1:int):void
        {
            this.var_5275 = param1;
        }

        public function get canTradeReason():int
        {
            return (this.var_5275);
        }

        public function set canBeKicked(param1:Boolean):void
        {
            this.var_5268 = param1;
        }

        public function get canBeKicked():Boolean
        {
            return (this.var_5268);
        }

        public function set isRoomOwner(param1:Boolean):void
        {
            this.var_4993 = param1;
        }

        public function get isRoomOwner():Boolean
        {
            return (this.var_4993);
        }

        public function set carryItem(param1:int):void
        {
            this.var_5265 = param1;
        }

        public function get carryItem():int
        {
            return (this.var_5265);
        }

        public function set userRoomId(param1:int):void
        {
            this.var_5266 = param1;
        }

        public function get userRoomId():int
        {
            return (this.var_5266);
        }

        public function set isSpectatorMode(param1:Boolean):void
        {
            this.var_4996 = param1;
        }

        public function get isSpectatorMode():Boolean
        {
            return (this.var_4996);
        }

        public function set realName(param1:String):void
        {
            this._realName = param1;
        }

        public function get realName():String
        {
            return (this._realName);
        }

        public function set allowNameChange(param1:Boolean):void
        {
            this.var_5185 = param1;
        }

        public function get allowNameChange():Boolean
        {
            return (this.var_5185);
        }


    }
}