package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.IChildEntity;
    import flash.geom.Rectangle;

    public class SkinLayoutEntity implements IChildEntity 
    {

        public static const var_2496:uint = (0 << 0);
        public static const var_1995:uint = (1 << 0);
        public static const var_1996:uint = (1 << 1);
        public static const var_1997:uint = (1 << 2);
        public static const var_1998:uint = (1 << 3);

        private var _id:uint;
        private var _name:String;
        public var color:uint;
        public var blend:uint;
        public var var_1994:uint;
        public var var_1999:uint;
        public var region:Rectangle;
        public var colorize:Boolean;

        public function SkinLayoutEntity(param1:uint, param2:String)
        {
            this._id = param1;
            this._name = param2;
        }

        public function get id():uint
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get tags():Array
        {
            return (null);
        }

        public function dispose():void
        {
            this.region = null;
        }


    }
}