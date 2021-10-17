package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetLevelNotificationParser implements IMessageParser 
    {

        private var var_3606:int;
        private var var_3609:String;
        private var var_3416:int;
        private var var_3074:int;
        private var var_2978:int;
        private var _color:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3606 = param1.readInteger();
            this.var_3609 = param1.readString();
            this.var_3416 = param1.readInteger();
            this.var_3074 = param1.readInteger();
            this.var_2978 = param1.readInteger();
            this._color = param1.readString();
            return (true);
        }

        public function get petId():int
        {
            return (this.var_3606);
        }

        public function get petName():String
        {
            return (this.var_3609);
        }

        public function get level():int
        {
            return (this.var_3416);
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


    }
}