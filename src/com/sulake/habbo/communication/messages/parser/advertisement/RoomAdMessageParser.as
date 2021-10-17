package com.sulake.habbo.communication.messages.parser.advertisement
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomAdMessageParser implements IMessageParser 
    {

        private var _imageUrl:String;
        private var var_2820:String;


        public function get imageUrl():String
        {
            return (this._imageUrl);
        }

        public function get clickUrl():String
        {
            return (this.var_2820);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._imageUrl = param1.readString();
            this.var_2820 = param1.readString();
            return (true);
        }


    }
}