package com.sulake.habbo.friendlist.domain
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;

    public class FriendRequest implements IDisposable 
    {

        public static const var_1534:int = 1;
        public static const var_1838:int = 2;
        public static const var_1839:int = 3;
        public static const var_1833:int = 4;

        private var var_3405:int;
        private var var_3406:String;
        private var var_3407:int;
        private var _state:int = 1;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;

        public function FriendRequest(param1:FriendRequestData)
        {
            this.var_3405 = param1.requestId;
            this.var_3406 = param1.requesterName;
            this.var_3407 = param1.requesterUserId;
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.view != null)
            {
                this.view.destroy();
                this.view = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get requestId():int
        {
            return (this.var_3405);
        }

        public function get requesterName():String
        {
            return (this.var_3406);
        }

        public function get requesterUserId():int
        {
            return (this.var_3407);
        }

        public function get view():IWindowContainer
        {
            return (this._view);
        }

        public function get state():int
        {
            return (this._state);
        }

        public function set view(param1:IWindowContainer):void
        {
            this._view = param1;
        }

        public function set state(param1:int):void
        {
            this._state = param1;
        }


    }
}