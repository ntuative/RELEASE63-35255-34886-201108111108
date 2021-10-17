package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomSearchResultData implements IDisposable, MsgWithRequestId 
    {

        private var _searchType:int;
        private var var_3483:String;
        private var var_3471:Array = new Array();
        private var var_3484:OfficialRoomEntryData;
        private var _disposed:Boolean;

        public function GuestRoomSearchResultData(param1:IMessageDataWrapper):void
        {
            this._searchType = param1.readInteger();
            this.var_3483 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3471.push(new GuestRoomData(param1));
                _loc3_++;
            };
            var _loc4_:Boolean = param1.readBoolean();
            if (_loc4_)
            {
                this.var_3484 = new OfficialRoomEntryData(param1);
            };
        }

        public function dispose():void
        {
            var _loc1_:GuestRoomData;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_3471 != null)
            {
                for each (_loc1_ in this.var_3471)
                {
                    _loc1_.dispose();
                };
            };
            if (this.var_3484 != null)
            {
                this.var_3484.dispose();
                this.var_3484 = null;
            };
            this.var_3471 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get searchType():int
        {
            return (this._searchType);
        }

        public function get searchParam():String
        {
            return (this.var_3483);
        }

        public function get rooms():Array
        {
            return (this.var_3471);
        }

        public function get ad():OfficialRoomEntryData
        {
            return (this.var_3484);
        }


    }
}