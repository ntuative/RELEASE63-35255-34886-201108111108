package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageRequestedMessageParser implements IMessageParser 
    {

        private var var_1678:int = -1;
        private var var_3074:int = -1;
        private var var_2978:int = -1;
        private var _color:String = "";


        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get petType():int
        {
            return (this.var_3074);
        }

        public function get breed():int
        {
            return (this.var_2978);
        }

        public function get color():String
        {
            return (this._color);
        }

        public function flush():Boolean
        {
            this.var_1678 = -1;
            this.var_3074 = -1;
            this.var_2978 = -1;
            this._color = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_1678 = param1.readInteger();
            this.var_3074 = param1.readInteger();
            this.var_2978 = param1.readInteger();
            this._color = param1.readString();
            return (true);
        }


    }
}