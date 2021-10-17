package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerAddedMessageParser implements IMessageParser 
    {

        private var var_3465:int;
        private var _data:FlatControllerData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3465 = param1.readInteger();
            this._data = new FlatControllerData(param1);
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get data():FlatControllerData
        {
            return (this._data);
        }


    }
}