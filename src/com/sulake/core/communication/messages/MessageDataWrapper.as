package com.sulake.core.communication.messages
{
    import flash.utils.ByteArray;
    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import com.sulake.core.communication.util.Short;

    public class MessageDataWrapper implements IMessageDataWrapper 
    {

        private var _data:ByteArray;
        private var var_2594:IProtocolDecoder;

        public function MessageDataWrapper(param1:ByteArray, param2:IProtocolDecoder)
        {
            this._data = param1;
            this.var_2594 = param2;
        }

        public function readString():String
        {
            return (this.var_2594.readString(this._data));
        }

        public function readInteger():int
        {
            return (this.var_2594.readInteger(this._data));
        }

        public function readBoolean():Boolean
        {
            return (this.var_2594.readBoolean(this._data));
        }

        public function readShort():Short
        {
            return (this.var_2594.readShort(this._data));
        }

        public function get bytesAvailable():uint
        {
            return (this._data.bytesAvailable);
        }


    }
}