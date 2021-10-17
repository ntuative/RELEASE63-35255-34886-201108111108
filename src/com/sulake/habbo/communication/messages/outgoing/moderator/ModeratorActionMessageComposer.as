package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class ModeratorActionMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const var_2159:int = 0;
        public static const var_2160:int = 1;
        public static const var_2161:int = 0;
        public static const var_2162:int = 1;
        public static const var_2163:int = 2;
        public static const var_2164:int = 3;
        public static const var_2165:int = 4;

        private var var_2493:Array = new Array();

        public function ModeratorActionMessageComposer(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int=0)
        {
            this.var_2493.push(param1);
            this.var_2493.push(param2);
            this.var_2493.push(param3);
            this.var_2493.push(param4);
            this.var_2493.push(param5);
            this.var_2493.push(param6);
            this.var_2493.push(false);
            this.var_2493.push(false);
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