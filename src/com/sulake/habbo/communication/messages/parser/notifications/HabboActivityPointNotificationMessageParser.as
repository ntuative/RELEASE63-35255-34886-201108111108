package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboActivityPointNotificationMessageParser implements IMessageParser 
    {

        private var var_3774:int = 0;
        private var var_3775:int = 0;
        private var _type:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3774 = param1.readInteger();
            this.var_3775 = param1.readInteger();
            this._type = param1.readInteger();
            return (true);
        }

        public function get amount():int
        {
            return (this.var_3774);
        }

        public function get change():int
        {
            return (this.var_3775);
        }

        public function get type():int
        {
            return (this._type);
        }


    }
}