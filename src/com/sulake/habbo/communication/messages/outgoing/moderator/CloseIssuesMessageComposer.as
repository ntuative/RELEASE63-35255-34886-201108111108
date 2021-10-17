package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class CloseIssuesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2493:Array = new Array();

        public function CloseIssuesMessageComposer(param1:Array, param2:int)
        {
            this.var_2493.push(param2);
            this.var_2493.push(param1.length);
            var _loc3_:int;
            while (_loc3_ < param1.length)
            {
                this.var_2493.push(param1[_loc3_]);
                _loc3_++;
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