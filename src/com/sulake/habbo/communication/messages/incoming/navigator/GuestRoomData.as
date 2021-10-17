package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomData implements IDisposable 
    {

        private var var_3465:int;
        private var var_2723:Boolean;
        private var var_3463:String;
        private var _ownerName:String;
        private var var_3474:int;
        private var var_3466:int;
        private var var_3475:int;
        private var var_2867:String;
        private var var_3476:int;
        private var var_3477:Boolean;
        private var var_3478:int;
        private var var_2930:int;
        private var var_3479:String;
        private var var_1209:Array = new Array();
        private var var_3480:RoomThumbnailData;
        private var var_3481:Boolean;
        private var var_3482:Boolean;
        private var _disposed:Boolean;

        public function GuestRoomData(param1:IMessageDataWrapper)
        {
            var _loc4_:String;
            super();
            this.var_3465 = param1.readInteger();
            this.var_2723 = param1.readBoolean();
            this.var_3463 = param1.readString();
            this._ownerName = param1.readString();
            this.var_3474 = param1.readInteger();
            this.var_3466 = param1.readInteger();
            this.var_3475 = param1.readInteger();
            this.var_2867 = param1.readString();
            this.var_3476 = param1.readInteger();
            this.var_3477 = param1.readBoolean();
            this.var_3478 = param1.readInteger();
            this.var_2930 = param1.readInteger();
            this.var_3479 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readString();
                this.var_1209.push(_loc4_);
                _loc3_++;
            };
            this.var_3480 = new RoomThumbnailData(param1);
            this.var_3481 = param1.readBoolean();
            this.var_3482 = param1.readBoolean();
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

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get event():Boolean
        {
            return (this.var_2723);
        }

        public function get roomName():String
        {
            return (this.var_3463);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get doorMode():int
        {
            return (this.var_3474);
        }

        public function get userCount():int
        {
            return (this.var_3466);
        }

        public function get maxUserCount():int
        {
            return (this.var_3475);
        }

        public function get description():String
        {
            return (this.var_2867);
        }

        public function get srchSpecPrm():int
        {
            return (this.var_3476);
        }

        public function get allowTrading():Boolean
        {
            return (this.var_3477);
        }

        public function get score():int
        {
            return (this.var_3478);
        }

        public function get categoryId():int
        {
            return (this.var_2930);
        }

        public function get eventCreationTime():String
        {
            return (this.var_3479);
        }

        public function get tags():Array
        {
            return (this.var_1209);
        }

        public function get thumbnail():RoomThumbnailData
        {
            return (this.var_3480);
        }

        public function get allowPets():Boolean
        {
            return (this.var_3481);
        }

        public function get displayRoomEntryAd():Boolean
        {
            return (this.var_3482);
        }


    }
}