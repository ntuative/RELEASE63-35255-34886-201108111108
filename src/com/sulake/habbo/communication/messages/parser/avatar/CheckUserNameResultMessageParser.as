package com.sulake.habbo.communication.messages.parser.avatar
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CheckUserNameResultMessageParser implements IMessageParser 
    {

        private var var_3640:int = -1;
        private var _name:String;
        private var var_3641:Array;


        public function get resultCode():int
        {
            return (this.var_3640);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get nameSuggestions():Array
        {
            return (this.var_3641);
        }

        public function flush():Boolean
        {
            this.var_3640 = -1;
            this._name = "";
            this.var_3641 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3640 = param1.readInteger();
            this._name = param1.readString();
            var _loc2_:int = param1.readInteger();
            this.var_3641 = new Array();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3641.push(param1.readString());
                _loc3_++;
            };
            return (true);
        }


    }
}