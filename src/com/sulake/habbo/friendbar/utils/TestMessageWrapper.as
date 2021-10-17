package com.sulake.habbo.friendbar.utils
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.util.Short;

    public class TestMessageWrapper implements IMessageDataWrapper 
    {

        private var _data:Array;

        public function TestMessageWrapper(param1:Array)
        {
            this._data = param1;
            this._data.reverse();
        }

        public function readString():String
        {
            return (String(this._data.pop()));
        }

        public function readInteger():int
        {
            return (int(this._data.pop()));
        }

        public function readBoolean():Boolean
        {
            return (Boolean(this._data.pop()));
        }

        public function readShort():Short
        {
            return (Short(this._data.pop()));
        }


    }
}