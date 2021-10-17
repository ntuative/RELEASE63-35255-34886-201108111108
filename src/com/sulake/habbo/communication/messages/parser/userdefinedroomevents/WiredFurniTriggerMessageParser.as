package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WiredFurniTriggerMessageParser implements IMessageParser 
    {

        private var var_3861:TriggerDefinition;


        public function flush():Boolean
        {
            this.var_3861 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3861 = new TriggerDefinition(param1);
            return (true);
        }

        public function get def():TriggerDefinition
        {
            return (this.var_3861);
        }


    }
}