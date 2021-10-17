package com.sulake.habbo.navigator.domain
{
    import com.sulake.core.window.IWindowContainer;

    public class RoomLayout 
    {

        private var var_3416:int;
        private var _tileSize:int;
        private var _name:String;
        private var _view:IWindowContainer;

        public function RoomLayout(param1:int, param2:int, param3:String)
        {
            this.var_3416 = param1;
            this._tileSize = param2;
            this._name = param3;
        }

        public function get requiredClubLevel():int
        {
            return (this.var_3416);
        }

        public function get tileSize():int
        {
            return (this._tileSize);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get view():IWindowContainer
        {
            return (this._view);
        }

        public function set view(param1:IWindowContainer):void
        {
            this._view = param1;
        }


    }
}