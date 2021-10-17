package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomsData implements IDisposable, MsgWithRequestId 
    {

        private var var_3494:Array = new Array();
        private var _disposed:Boolean;

        public function OfficialRoomsData(param1:IMessageDataWrapper)
        {
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3494.push(new OfficialRoomEntryData(param1));
                _loc3_++;
            };
        }

        public function dispose():void
        {
            var _loc1_:OfficialRoomEntryData;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_3494 != null)
            {
                for each (_loc1_ in this.var_3494)
                {
                    _loc1_.dispose();
                };
            };
            this.var_3494 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get entries():Array
        {
            return (this.var_3494);
        }


    }
}