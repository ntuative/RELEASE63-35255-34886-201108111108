package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicSpaceCastLibsMessageParser implements IMessageParser 
    {

        private var var_3472:int;
        private var var_3499:String;
        private var var_3497:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3472 = param1.readInteger();
            this.var_3499 = param1.readString();
            this.var_3497 = param1.readInteger();
            return (true);
        }

        public function get nodeId():int
        {
            return (this.var_3472);
        }

        public function get castLibs():String
        {
            return (this.var_3499);
        }

        public function get unitPort():int
        {
            return (this.var_3497);
        }


    }
}