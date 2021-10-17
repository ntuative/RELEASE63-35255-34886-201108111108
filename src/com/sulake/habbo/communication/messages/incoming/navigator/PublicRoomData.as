package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomData implements IDisposable 
    {

        private var var_3496:String;
        private var var_3497:int;
        private var var_3498:int;
        private var var_3499:String;
        private var var_3500:int;
        private var var_3472:int;
        private var _disposed:Boolean;

        public function PublicRoomData(param1:IMessageDataWrapper)
        {
            this.var_3496 = param1.readString();
            this.var_3497 = param1.readInteger();
            this.var_3498 = param1.readInteger();
            this.var_3499 = param1.readString();
            this.var_3500 = param1.readInteger();
            this.var_3472 = param1.readInteger();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get unitPropertySet():String
        {
            return (this.var_3496);
        }

        public function get unitPort():int
        {
            return (this.var_3497);
        }

        public function get worldId():int
        {
            return (this.var_3498);
        }

        public function get castLibs():String
        {
            return (this.var_3499);
        }

        public function get maxUsers():int
        {
            return (this.var_3500);
        }

        public function get nodeId():int
        {
            return (this.var_3472);
        }


    }
}