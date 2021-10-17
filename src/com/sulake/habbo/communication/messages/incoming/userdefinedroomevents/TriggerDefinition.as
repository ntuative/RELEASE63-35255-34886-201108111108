package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TriggerDefinition extends Triggerable 
    {

        private var var_3580:int;
        private var var_3579:Array = new Array();

        public function TriggerDefinition(param1:IMessageDataWrapper)
        {
            super(param1);
            this.var_3580 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3579.push(param1.readInteger());
                _loc3_++;
            };
        }

        public function get triggerConf():int
        {
            return (this.var_3580);
        }

        override public function get code():int
        {
            return (this.var_3580);
        }

        public function get conflictingActions():Array
        {
            return (this.var_3579);
        }


    }
}