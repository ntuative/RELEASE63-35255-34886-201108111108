package com.sulake.core.window.utils
{
    public class TextStyle 
    {

        public static const NORMAL:String = "normal";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";
        public static const var_1218:String = "underline";
        public static const NONE:String = "none";
        public static const ADVANCED:String = "advanced";

        public var name:String;
        public var color:Object;
        public var fontFamily:String;
        public var fontSize:Object = null;
        public var fontStyle:String = null;
        public var fontWeight:String = null;
        public var kerning:Object = null;
        public var leading:Object = null;
        public var letterSpacing:Object = null;
        public var textDecoration:String = null;
        public var textIndent:Object = null;
        public var antiAliasType:String = null;
        public var sharpness:Object = null;
        public var thickness:Object = null;


        public function toString():String
        {
            var _loc1_:String = "";
            _loc1_ = (_loc1_ + (this.name + " {\n"));
            if (this.color)
            {
                _loc1_ = (_loc1_ + (("\tcolor: #" + this.color.toString(16)) + ";\n"));
            };
            if (this.fontFamily)
            {
                _loc1_ = (_loc1_ + (("\tfont-family: " + this.fontFamily) + ";\n"));
            };
            if (this.fontSize)
            {
                _loc1_ = (_loc1_ + (("\tfont-size: " + this.fontSize) + ";\n"));
            };
            if (this.fontStyle)
            {
                _loc1_ = (_loc1_ + (("\tfont-style: " + this.fontStyle) + ";\n"));
            };
            if (this.fontWeight)
            {
                _loc1_ = (_loc1_ + (("\tfont-weight: " + this.fontWeight) + ";\n"));
            };
            if (this.kerning)
            {
                _loc1_ = (_loc1_ + (("\tkerning: " + this.kerning) + ";\n"));
            };
            if (this.leading)
            {
                _loc1_ = (_loc1_ + (("\tleading: " + this.leading) + ";\n"));
            };
            if (this.letterSpacing)
            {
                _loc1_ = (_loc1_ + (("\tletter-spacing: " + this.letterSpacing) + ";\n"));
            };
            if (this.textDecoration)
            {
                _loc1_ = (_loc1_ + (("\ttext-decoration: " + this.textDecoration) + ";\n"));
            };
            if (this.textIndent)
            {
                _loc1_ = (_loc1_ + (("\ttext-indent: " + this.textIndent) + ";\n"));
            };
            if (this.antiAliasType)
            {
                _loc1_ = (_loc1_ + (("\tanti-alias-type: " + this.antiAliasType) + ";\n"));
            };
            if (this.sharpness)
            {
                _loc1_ = (_loc1_ + (("\tsharpness: " + this.sharpness) + ";\n"));
            };
            if (this.thickness)
            {
                _loc1_ = (_loc1_ + (("\tthickness: " + this.thickness) + ";\n"));
            };
            return (_loc1_ + "}");
        }

        public function equals(param1:TextStyle):Boolean
        {
            return (((((((((((((this.color == param1.color) && (this.fontFamily == param1.fontFamily)) && (this.fontSize == param1.fontSize)) && (this.fontStyle == param1.fontStyle)) && (this.fontWeight == param1.fontWeight)) && (this.kerning == param1.kerning)) && (this.leading == param1.leading)) && (this.letterSpacing == param1.letterSpacing)) && (this.textDecoration == param1.textDecoration)) && (this.textIndent == param1.textIndent)) && (this.antiAliasType == param1.antiAliasType)) && (this.sharpness == param1.sharpness)) && (this.thickness == param1.thickness));
        }

        public function clone():TextStyle
        {
            var _loc1_:TextStyle = new TextStyle();
            _loc1_.name = this.name;
            _loc1_.color = this.color;
            _loc1_.fontFamily = this.fontFamily;
            _loc1_.fontSize = this.fontSize;
            _loc1_.fontStyle = this.fontStyle;
            _loc1_.fontWeight = this.fontWeight;
            _loc1_.kerning = this.kerning;
            _loc1_.leading = this.leading;
            _loc1_.letterSpacing = this.letterSpacing;
            _loc1_.textDecoration = this.textDecoration;
            _loc1_.textIndent = this.textIndent;
            _loc1_.antiAliasType = this.antiAliasType;
            _loc1_.sharpness = this.sharpness;
            _loc1_.thickness = this.thickness;
            return (_loc1_);
        }


    }
}