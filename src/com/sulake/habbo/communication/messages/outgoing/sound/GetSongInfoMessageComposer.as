package com.sulake.habbo.communication.messages.outgoing.sound
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetSongInfoMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2493:Array = new Array();

        public function GetSongInfoMessageComposer(param1:Array)
        {
            var _loc2_:int;
            super();
            this.var_2493.push(param1.length);
            for each (_loc2_ in param1)
            {
                this.var_2493.push(_loc2_);
            };
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