package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularTagData 
    {

        private var var_3495:String;
        private var var_3466:int;

        public function PopularTagData(param1:IMessageDataWrapper)
        {
            this.var_3495 = param1.readString();
            this.var_3466 = param1.readInteger();
        }

        public function get tagName():String
        {
            return (this.var_3495);
        }

        public function get userCount():int
        {
            return (this.var_3466);
        }


    }
}