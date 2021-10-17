package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCategory 
    {

        private var var_3472:int;
        private var var_3473:String;
        private var var_1169:Boolean;

        public function FlatCategory(param1:IMessageDataWrapper)
        {
            this.var_3472 = param1.readInteger();
            this.var_3473 = param1.readString();
            this.var_1169 = param1.readBoolean();
        }

        public function get nodeId():int
        {
            return (this.var_3472);
        }

        public function get nodeName():String
        {
            return (this.var_3473);
        }

        public function get visible():Boolean
        {
            return (this.var_1169);
        }


    }
}