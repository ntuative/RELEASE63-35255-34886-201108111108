package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEventData implements IDisposable 
    {

        private var var_3464:Boolean;
        private var var_3501:int;
        private var var_3502:String;
        private var var_3465:int;
        private var var_3503:int;
        private var var_3504:String;
        private var var_3505:String;
        private var var_3506:String;
        private var var_1209:Array = new Array();
        private var _disposed:Boolean;

        public function RoomEventData(param1:IMessageDataWrapper)
        {
            var _loc5_:String;
            super();
            var _loc2_:String = param1.readString();
            if (_loc2_ == "-1")
            {
                Logger.log("Got null room event");
                this.var_3464 = false;
                return;
            };
            this.var_3464 = true;
            this.var_3501 = int(_loc2_);
            this.var_3502 = param1.readString();
            this.var_3465 = int(param1.readString());
            this.var_3503 = param1.readInteger();
            this.var_3504 = param1.readString();
            this.var_3505 = param1.readString();
            this.var_3506 = param1.readString();
            var _loc3_:int = param1.readInteger();
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc5_ = param1.readString();
                this.var_1209.push(_loc5_);
                _loc4_++;
            };
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_1209 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get ownerAvatarId():int
        {
            return (this.var_3501);
        }

        public function get ownerAvatarName():String
        {
            return (this.var_3502);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get eventType():int
        {
            return (this.var_3503);
        }

        public function get eventName():String
        {
            return (this.var_3504);
        }

        public function get eventDescription():String
        {
            return (this.var_3505);
        }

        public function get creationTime():String
        {
            return (this.var_3506);
        }

        public function get tags():Array
        {
            return (this.var_1209);
        }

        public function get exists():Boolean
        {
            return (this.var_3464);
        }


    }
}