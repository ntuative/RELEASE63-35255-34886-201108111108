package com.sulake.habbo.communication.messages.parser.facebook
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaceBookAppRequestMessageParser implements IMessageParser 
    {

        private var var_3652:String;
        private var _data:String;
        private var var_3653:String;
        private var var_3654:int;


        public function get authToken():String
        {
            return (this.var_3652);
        }

        public function get data():String
        {
            return (this._data);
        }

        public function get userFilter():String
        {
            return (this.var_3653);
        }

        public function get senderReference():int
        {
            return (this.var_3654);
        }

        public function flush():Boolean
        {
            this.var_3652 = (this._data = (this.var_3653 = null));
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3652 = param1.readString();
            this._data = param1.readString();
            this.var_3653 = param1.readString();
            this.var_3654 = param1.readInteger();
            return (true);
        }


    }
}