package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserObjectMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _name:String;
        private var var_2994:String;
        private var var_3546:String;
        private var var_3687:String;
        private var _realName:String;
        private var var_3688:int;
        private var var_3689:int;
        private var var_3690:int;
        private var var_3691:int;
        private var var_3692:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._id = int(param1.readString());
            this._name = param1.readString();
            this.var_2994 = param1.readString();
            this.var_3546 = param1.readString();
            this.var_3687 = param1.readString();
            this._realName = param1.readString();
            this.var_3688 = param1.readInteger();
            this.var_3689 = param1.readInteger();
            this.var_3690 = param1.readInteger();
            this.var_3691 = param1.readInteger();
            this.var_3692 = param1.readBoolean();
            return (true);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get sex():String
        {
            return (this.var_3546);
        }

        public function get customData():String
        {
            return (this.var_3687);
        }

        public function get realName():String
        {
            return (this._realName);
        }

        public function get directMail():int
        {
            return (this.var_3688);
        }

        public function get respectTotal():int
        {
            return (this.var_3689);
        }

        public function get respectLeft():int
        {
            return (this.var_3690);
        }

        public function get petRespectLeft():int
        {
            return (this.var_3691);
        }

        public function get streamPublishingAllowed():Boolean
        {
            return (this.var_3692);
        }


    }
}