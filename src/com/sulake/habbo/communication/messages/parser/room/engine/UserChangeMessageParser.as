package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChangeMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var var_2994:String;
        private var var_3546:String;
        private var var_3821:String;
        private var var_3548:int;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get sex():String
        {
            return (this.var_3546);
        }

        public function get customInfo():String
        {
            return (this.var_3821);
        }

        public function get achievementScore():int
        {
            return (this.var_3548);
        }

        public function flush():Boolean
        {
            this._id = 0;
            this.var_2994 = "";
            this.var_3546 = "";
            this.var_3821 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._id = param1.readInteger();
            this.var_2994 = param1.readString();
            this.var_3546 = param1.readString();
            this.var_3821 = param1.readString();
            this.var_3548 = param1.readInteger();
            if (this.var_3546)
            {
                this.var_3546 = this.var_3546.toUpperCase();
            };
            return (true);
        }


    }
}