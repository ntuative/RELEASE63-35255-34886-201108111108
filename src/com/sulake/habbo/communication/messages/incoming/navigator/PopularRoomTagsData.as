package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularRoomTagsData implements IDisposable, MsgWithRequestId 
    {

        private var var_1209:Array = new Array();
        private var _disposed:Boolean;

        public function PopularRoomTagsData(param1:IMessageDataWrapper)
        {
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_1209.push(new PopularTagData(param1));
                _loc3_++;
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

        public function get tags():Array
        {
            return (this.var_1209);
        }


    }
}