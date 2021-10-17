package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.FontStyle;
    import flash.text.AntiAliasType;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.utils.FontEnum;

    public class TextFieldCache implements IDisposable 
    {

        private static var var_2495:Map = new Map();
        private static var _instance:TextFieldCache = new (TextFieldCache)();

        private var _disposed:Boolean = false;

        public function TextFieldCache()
        {
            if (_instance == null)
            {
                TextStyleManager.events.addEventListener(Event.CHANGE, this.onTextStyleChanged);
            };
        }

        public static function getTextFieldByStyle(param1:TextStyle):TextField
        {
            var _loc2_:TextField = var_2495[param1.name];
            if (_loc2_)
            {
                return (_loc2_);
            };
            _loc2_ = new TextField();
            var _loc3_:TextFormat = _loc2_.defaultTextFormat;
            if (!param1)
            {
                param1 = TextStyleManager.getStyle(TextStyleManager.var_1219);
            };
            _loc3_.font = param1.fontFamily;
            _loc3_.size = param1.fontSize;
            _loc3_.color = param1.color;
            _loc3_.bold = ((param1.fontWeight == FontStyle.BOLD) ? true : null);
            _loc3_.italic = ((param1.fontStyle == FontStyle.ITALIC) ? true : null);
            _loc3_.underline = ((param1.textDecoration == TextStyle.var_1218) ? true : null);
            _loc3_.indent = param1.textIndent;
            _loc3_.leading = param1.leading;
            _loc3_.kerning = param1.kerning;
            _loc3_.letterSpacing = param1.letterSpacing;
            _loc2_.antiAliasType = ((param1.antiAliasType == AntiAliasType.ADVANCED) ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL);
            _loc2_.sharpness = ((param1.sharpness) ? (param1.sharpness as int) : 0);
            _loc2_.thickness = ((param1.thickness) ? (param1.thickness as int) : 0);
            if (!param1.fontWeight)
            {
                _loc3_.bold = false;
            };
            if (!param1.fontStyle)
            {
                _loc3_.italic = false;
            };
            if (!param1.textDecoration)
            {
                _loc3_.underline = false;
            };
            if (!param1.textIndent)
            {
                _loc3_.indent = 0;
            };
            if (!param1.leading)
            {
                _loc3_.leading = 0;
            };
            if (!param1.kerning)
            {
                _loc3_.kerning = false;
            };
            if (!param1.letterSpacing)
            {
                _loc3_.letterSpacing = 0;
            };
            if (!param1.antiAliasType)
            {
                _loc2_.antiAliasType = AntiAliasType.NORMAL;
            };
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc2_.setTextFormat(_loc3_);
            _loc2_.embedFonts = FontEnum.isEmbeddedFont(_loc3_.font);
            _loc2_.defaultTextFormat = _loc3_;
            var_2495[param1.name] = _loc2_;
            return (_loc2_);
        }

        public static function getTextFieldByStyleName(param1:String):TextField
        {
            var _loc2_:TextStyle = TextStyleManager.getStyle(param1);
            if (!_loc2_)
            {
                Logger.log((('TextFieldCache.getTextFieldByStyleName(...); No such style: "' + param1) + '"!'));
                return (null);
            };
            return (getTextFieldByStyle(_loc2_));
        }


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            TextStyleManager.events.removeEventListener(Event.CHANGE, this.onTextStyleChanged);
            var_2495.reset();
            _instance = null;
            this._disposed = true;
        }

        private function onTextStyleChanged(param1:Event):void
        {
            var_2495.reset();
        }


    }
}