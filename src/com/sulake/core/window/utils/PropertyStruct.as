package com.sulake.core.window.utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.core.utils.Map;
    import flash.utils.getQualifiedClassName;

    public class PropertyStruct 
    {

        public static const var_629:String = "hex";
        public static const var_630:String = "int";
        public static const var_631:String = "uint";
        public static const var_632:String = "Number";
        public static const var_634:String = "Boolean";
        public static const var_636:String = "String";
        public static const var_637:String = "Point";
        public static const var_638:String = "Rectangle";
        public static const var_639:String = "Array";
        public static const var_640:String = "Map";

        private var var_2604:String;
        private var var_2605:Object;
        private var _type:String;
        private var var_2792:Boolean;
        private var var_2794:Boolean;
        private var var_2793:Array;

        public function PropertyStruct(param1:String, param2:Object, param3:String, param4:Boolean, param5:Array=null)
        {
            this.var_2604 = param1;
            this.var_2605 = param2;
            this._type = param3;
            this.var_2792 = param4;
            this.var_2794 = ((((param3 == var_640) || (param3 == var_639)) || (param3 == var_637)) || (param3 == var_638));
            this.var_2793 = param5;
        }

        public function get key():String
        {
            return (this.var_2604);
        }

        public function get value():Object
        {
            return (this.var_2605);
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get valid():Boolean
        {
            return (this.var_2792);
        }

        public function get range():Array
        {
            return (this.var_2793);
        }

        public function toString():String
        {
            switch (this._type)
            {
                case var_629:
                    return ("0x" + uint(this.var_2605).toString(16));
                case var_634:
                    return ((Boolean(this.var_2605) == true) ? "true" : "false");
                case var_637:
                    return (((("Point(" + Point(this.var_2605).x) + ", ") + Point(this.var_2605).y) + ")");
                case var_638:
                    return (((((((("Rectangle(" + Rectangle(this.var_2605).x) + ", ") + Rectangle(this.var_2605).y) + ", ") + Rectangle(this.var_2605).width) + ", ") + Rectangle(this.var_2605).height) + ")");
            };
            return (String(this.value));
        }

        public function toXMLString():String
        {
            var _loc1_:String;
            var _loc2_:int;
            var _loc3_:Map;
            var _loc4_:Array;
            var _loc5_:Point;
            var _loc6_:Rectangle;
            switch (this._type)
            {
                case var_640:
                    _loc3_ = (this.var_2605 as Map);
                    _loc1_ = (((('<var key="' + this.var_2604) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc2_ = 0;
                    while (_loc2_ < _loc3_.length)
                    {
                        _loc1_ = (_loc1_ + (((((('<var key="' + _loc3_.getKey(_loc2_)) + '" value="') + _loc3_.getWithIndex(_loc2_)) + '" type="') + getQualifiedClassName(_loc3_.getWithIndex(_loc2_))) + '" />\r'));
                        _loc2_++;
                    };
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_639:
                    _loc4_ = (this.var_2605 as Array);
                    _loc1_ = (((('<var key="' + this.var_2604) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc2_ = 0;
                    while (_loc2_ < _loc4_.length)
                    {
                        _loc1_ = (_loc1_ + (((((('<var key="' + String(_loc2_)) + '" value="') + _loc4_[_loc2_]) + '" type="') + getQualifiedClassName(_loc4_[_loc2_])) + '" />\r'));
                        _loc2_++;
                    };
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_637:
                    _loc5_ = (this.var_2605 as Point);
                    _loc1_ = (((('<var key="' + this.var_2604) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc1_ = (_loc1_ + (((('<var key="x" value="' + _loc5_.x) + '" type="') + var_630) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="y" value="' + _loc5_.y) + '" type="') + var_630) + '" />\r'));
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_638:
                    _loc6_ = (this.var_2605 as Rectangle);
                    _loc1_ = (((('<var key="' + this.var_2604) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc1_ = (_loc1_ + (((('<var key="x" value="' + _loc6_.x) + '" type="') + var_630) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="y" value="' + _loc6_.y) + '" type="') + var_630) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="width" value="' + _loc6_.width) + '" type="') + var_630) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="height" value="' + _loc6_.height) + '" type="') + var_630) + '" />\r'));
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_629:
                    _loc1_ = ((((((('<var key="' + this.var_2604) + '" value="') + "0x") + uint(this.var_2605).toString(16)) + '" type="') + this._type) + '" />');
                    break;
                default:
                    _loc1_ = (((((('<var key="' + this.var_2604) + '" value="') + this.var_2605) + '" type="') + this._type) + '" />');
            };
            return (_loc1_);
        }


    }
}