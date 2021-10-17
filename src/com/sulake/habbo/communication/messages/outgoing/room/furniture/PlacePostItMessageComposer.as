package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PlacePostItMessageComposer implements IMessageComposer 
    {

        private var var_3608:int;
        private var var_2957:String;

        public function PlacePostItMessageComposer(param1:int, param2:String)
        {
            this.var_3608 = param1;
            this.var_2957 = param2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3608, this.var_2957]);
        }


    }
}