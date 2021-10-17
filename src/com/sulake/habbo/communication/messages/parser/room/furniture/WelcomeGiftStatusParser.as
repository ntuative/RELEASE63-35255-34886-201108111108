package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WelcomeGiftStatusParser implements IMessageParser 
    {

        private var var_3828:String;
        private var var_3829:Boolean;
        private var var_3830:Boolean;
        private var _furniId:int;
        private var var_3831:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3828 = param1.readString();
            this.var_3829 = param1.readBoolean();
            this.var_3830 = param1.readBoolean();
            this._furniId = param1.readInteger();
            this.var_3831 = param1.readBoolean();
            return (true);
        }

        public function get requestedByUser():Boolean
        {
            return (this.var_3831);
        }

        public function get email():String
        {
            return (this.var_3828);
        }

        public function get isVerified():Boolean
        {
            return (this.var_3829);
        }

        public function get allowChange():Boolean
        {
            return (this.var_3830);
        }

        public function get furniId():int
        {
            return (this._furniId);
        }


    }
}