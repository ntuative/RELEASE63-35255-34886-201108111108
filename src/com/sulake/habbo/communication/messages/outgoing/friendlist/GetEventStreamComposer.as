package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetEventStreamComposer implements IMessageComposer 
    {

        public static const var_1371:int = 0;
        public static const var_1372:int = 1;

        private var var_1198:int;

        public function GetEventStreamComposer(param1:int=0)
        {
            this.var_1198 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_1198]);
        }


    }
}