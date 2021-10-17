package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetCommandsMessageParser implements IMessageParser 
    {

        private var var_3606:int;
        private var var_3832:Array;
        private var var_3833:Array;


        public function get petId():int
        {
            return (this.var_3606);
        }

        public function get allCommands():Array
        {
            return (this.var_3832);
        }

        public function get enabledCommands():Array
        {
            return (this.var_3833);
        }

        public function flush():Boolean
        {
            this.var_3606 = -1;
            this.var_3832 = null;
            this.var_3833 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3606 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            this.var_3832 = new Array();
            while (_loc2_-- > 0)
            {
                this.var_3832.push(param1.readInteger());
            };
            var _loc3_:int = param1.readInteger();
            this.var_3833 = new Array();
            while (_loc3_-- > 0)
            {
                this.var_3833.push(param1.readInteger());
            };
            return (true);
        }


    }
}