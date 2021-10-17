package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomModerationData implements IDisposable 
    {

        private var var_3465:int;
        private var var_3466:int;
        private var var_3467:Boolean;
        private var var_3468:int;
        private var _ownerName:String;
        private var var_3448:RoomData;
        private var var_2723:RoomData;
        private var _disposed:Boolean;

        public function RoomModerationData(param1:IMessageDataWrapper)
        {
            this.var_3465 = param1.readInteger();
            this.var_3466 = param1.readInteger();
            this.var_3467 = param1.readBoolean();
            this.var_3468 = param1.readInteger();
            this._ownerName = param1.readString();
            this.var_3448 = new RoomData(param1);
            this.var_2723 = new RoomData(param1);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_3448 != null)
            {
                this.var_3448.dispose();
                this.var_3448 = null;
            };
            if (this.var_2723 != null)
            {
                this.var_2723.dispose();
                this.var_2723 = null;
            };
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get userCount():int
        {
            return (this.var_3466);
        }

        public function get ownerInRoom():Boolean
        {
            return (this.var_3467);
        }

        public function get ownerId():int
        {
            return (this.var_3468);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get room():RoomData
        {
            return (this.var_3448);
        }

        public function get event():RoomData
        {
            return (this.var_2723);
        }


    }
}