package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollOfferParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var var_3782:String = "";


        public function get id():int
        {
            return (this._id);
        }

        public function get summary():String
        {
            return (this.var_3782);
        }

        public function flush():Boolean
        {
            this._id = -1;
            this.var_3782 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._id = param1.readInteger();
            this.var_3782 = param1.readString();
            return (true);
        }


    }
}