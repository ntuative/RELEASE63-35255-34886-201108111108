package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class UpdateRoomThumbnailMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2493:Array = new Array();

        public function UpdateRoomThumbnailMessageComposer(param1:int, param2:int, param3:int, param4:int)
        {
            this.var_2493.push(param1);
            this.var_2493.push(param2);
            this.var_2493.push(param3);
            this.var_2493.push(param4);
        }

        public function addObj(param1:int, param2:int):void
        {
            this.var_2493.push(param1);
            this.var_2493.push(param2);
        }

        public function getMessageArray():Array
        {
            return (this.var_2493);
        }

        public function dispose():void
        {
            this.var_2493 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}