package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class EventLogMessageComposer implements IMessageComposer 
    {

        private var _category:String;
        private var _type:String;
        private var _action:String;
        private var var_3618:String;
        private var var_3619:int;

        public function EventLogMessageComposer(param1:String, param2:String, param3:String, param4:String="", param5:int=0)
        {
            if ((((param1 == null) || (param2 == null)) || (param3 == null)))
            {
            };
            this._category = ((param1) ? param1 : "");
            this._type = ((param2) ? param2 : "");
            this._action = ((param3) ? param3 : "");
            this.var_3618 = ((param4) ? param4 : "");
            this.var_3619 = ((param5) ? param5 : 0);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this._category, this._type, this._action, this.var_3618, this.var_3619]);
        }


    }
}