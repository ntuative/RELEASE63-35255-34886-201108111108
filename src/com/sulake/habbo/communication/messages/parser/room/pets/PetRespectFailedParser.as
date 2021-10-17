package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRespectFailedParser implements IMessageParser 
    {

        private var _requiredDays:int;
        private var var_3842:int;


        public function get requiredDays():int
        {
            return (this._requiredDays);
        }

        public function get avatarAgeInDays():int
        {
            return (this.var_3842);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._requiredDays = param1.readInteger();
            this.var_3842 = param1.readInteger();
            return (true);
        }


    }
}