package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TutorialStatusMessageParser implements IMessageParser 
    {

        private var var_3700:Boolean;
        private var var_3701:Boolean;
        private var var_3702:Boolean;


        public function get hasChangedLooks():Boolean
        {
            return (this.var_3700);
        }

        public function get hasChangedName():Boolean
        {
            return (this.var_3701);
        }

        public function get hasCalledGuideBot():Boolean
        {
            return (this.var_3702);
        }

        public function flush():Boolean
        {
            this.var_3700 = false;
            this.var_3701 = false;
            this.var_3702 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3700 = param1.readBoolean();
            this.var_3701 = param1.readBoolean();
            this.var_3702 = param1.readBoolean();
            return (true);
        }


    }
}