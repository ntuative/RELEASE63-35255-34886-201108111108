package com.sulake.habbo.session.handler
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;

    public class BaseHandler implements IDisposable 
    {

        private var _connection:IConnection;
        private var var_4981:IRoomHandlerListener;
        private var _disposed:Boolean = false;
        public var _xxxRoomId:int;
        public var var_99:int;

        public function BaseHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            this._connection = param1;
            this.var_4981 = param2;
        }

        public function dispose():void
        {
            this._connection = null;
            this.var_4981 = null;
            this._disposed = true;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get connection():IConnection
        {
            return (this._connection);
        }

        public function get listener():IRoomHandlerListener
        {
            return (this.var_4981);
        }


    }
}