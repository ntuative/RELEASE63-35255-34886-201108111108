package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OffenceData implements INamed 
    {

        private var _name:String;
        private var var_3453:String;

        public function OffenceData(param1:IMessageDataWrapper)
        {
            this._name = param1.readString();
            this.var_3453 = param1.readString();
            Logger.log(((("READ OFF: " + this._name) + ", ") + this.var_3453));
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get msg():String
        {
            return (this.var_3453);
        }


    }
}