package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ActionDefinition extends Triggerable 
    {

        private var _type:int;
        private var var_3572:int;
        private var var_3571:Array = new Array();

        public function ActionDefinition(param1:IMessageDataWrapper)
        {
            super(param1);
            this._type = param1.readInteger();
            this.var_3572 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3571.push(param1.readInteger());
                _loc3_++;
            };
        }

        public function get type():int
        {
            return (this._type);
        }

        override public function get code():int
        {
            return (this._type);
        }

        public function get delayInPulses():int
        {
            return (this.var_3572);
        }

        public function get conflictingTriggers():Array
        {
            return (this.var_3571);
        }


    }
}