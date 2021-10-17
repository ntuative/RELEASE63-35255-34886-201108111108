package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRespectNotificationParser implements IMessageParser 
    {

        private var var_3840:int;
        private var var_3863:int;
        private var _petData:PetData;


        public function flush():Boolean
        {
            this._petData = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3840 = param1.readInteger();
            this.var_3863 = param1.readInteger();
            this._petData = new PetData(param1);
            return (true);
        }

        public function get petOwnerId():int
        {
            return (this.var_3863);
        }

        public function get respect():int
        {
            return (this.var_3840);
        }

        public function get petData():PetData
        {
            return (this._petData);
        }


    }
}