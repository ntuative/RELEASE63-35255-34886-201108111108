package com.sulake.core.window.graphics
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.utils.TypeCodeTable;
    import com.sulake.core.window.utils.StateCodeTable;
    import com.sulake.core.window.graphics.renderer.BitmapSkinRenderer;
    import com.sulake.core.window.graphics.renderer.BitmapDataRenderer;
    import com.sulake.core.window.graphics.renderer.FillSkinRenderer;
    import com.sulake.core.window.graphics.renderer.TextSkinRenderer;
    import com.sulake.core.window.graphics.renderer.LabelRenderer;
    import com.sulake.core.window.graphics.renderer.ShapeSkinRenderer;
    import com.sulake.core.window.graphics.renderer.SkinRenderer;
    import com.sulake.core.window.graphics.renderer.NullSkinRenderer;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.graphics.renderer.*;

    public class SkinContainer implements ISkinContainer 
    {

        private static const var_1191:uint = 8;
        private static const var_1177:String = "skin";
        private static const get:String = "bitmap";
        private static const var_1178:String = "fill";
        private static const var_1179:String = "text";
        private static const var_1180:String = "label";
        private static const var_1181:String = "shape";
        private static const RENDERER_TYPE_UNKNOWN:String = "unknown";
        private static const RENDERER_TYPE_NULL:String = "null";
        protected static var var_1182:Array;

        private var _disposed:Boolean = false;
        private var _assetLibrary:IAssetLibrary;
        private var var_2749:Dictionary;
        private var var_2750:Dictionary;
        private var var_2748:Dictionary;
        private var var_2744:Dictionary;
        private var var_2745:Dictionary;
        private var var_2746:Dictionary;
        private var var_2747:Dictionary;

        public function SkinContainer(param1:XML, param2:IAssetLibrary)
        {
            var _loc3_:XMLList;
            var _loc4_:uint;
            var _loc5_:XML;
            var _loc6_:XMLList;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:uint;
            var _loc10_:uint;
            var _loc11_:String;
            var _loc12_:String;
            var _loc13_:IAsset;
            var _loc14_:ISkinRenderer;
            var _loc15_:String;
            var _loc16_:Class;
            var _loc17_:DefaultAttStruct;
            var _loc18_:uint;
            super();
            this._assetLibrary = param2;
            this.var_2749 = new Dictionary();
            this.var_2750 = new Dictionary();
            this.var_2744 = new Dictionary();
            this.var_2745 = new Dictionary();
            TypeCodeTable.fillTables(this.var_2744, this.var_2745);
            this.var_2746 = new Dictionary();
            this.var_2747 = new Dictionary();
            StateCodeTable.fillTables(this.var_2746, this.var_2747);
            this.var_2748 = new Dictionary();
            this.var_2748[var_1177] = BitmapSkinRenderer;
            this.var_2748[get] = BitmapDataRenderer;
            this.var_2748[var_1178] = FillSkinRenderer;
            this.var_2748[var_1179] = TextSkinRenderer;
            this.var_2748[var_1180] = LabelRenderer;
            this.var_2748[var_1181] = ShapeSkinRenderer;
            this.var_2748[RENDERER_TYPE_UNKNOWN] = SkinRenderer;
            this.var_2748[RENDERER_TYPE_NULL] = NullSkinRenderer;
            if (var_1182 == null)
            {
                var_1182 = new Array();
                var_1182.push(WindowState.var_1183);
                var_1182.push(WindowState.var_1184);
                var_1182.push(WindowState.var_1185);
                var_1182.push(WindowState.var_1186);
                var_1182.push(WindowState.var_1187);
                var_1182.push(WindowState.var_1188);
                var_1182.push(WindowState.var_743);
                var_1182.push(WindowState.var_1189);
            };
            if (param1 != null)
            {
                _loc3_ = param1.child("component");
                _loc4_ = _loc3_.length();
                if (_loc4_ > 0)
                {
                    _loc18_ = 0;
                    while (_loc18_ < _loc4_)
                    {
                        _loc5_ = _loc3_[_loc18_];
                        _loc7_ = _loc5_.attribute("type");
                        _loc8_ = _loc5_.attribute("style");
                        _loc9_ = (_loc5_.attribute("blend") as uint);
                        _loc10_ = (_loc5_.attribute("color") as uint);
                        _loc11_ = _loc5_.attribute("asset");
                        _loc12_ = _loc5_.attribute("layout");
                        _loc15_ = _loc5_.attribute("renderer");
                        _loc6_ = _loc5_.child("states");
                        _loc16_ = this.var_2748[_loc15_];
                        if (_loc16_)
                        {
                            _loc14_ = new _loc16_(_loc12_);
                            if (_loc14_)
                            {
                                _loc13_ = this._assetLibrary.getAssetByName(_loc11_);
                                _loc14_.parse(_loc13_, _loc6_, this._assetLibrary);
                            };
                        };
                        _loc17_ = new DefaultAttStruct();
                        _loc17_.var_1190 = ((_loc5_.@treshold[0]) ? uint(_loc5_.@treshold[0]) : 10);
                        _loc17_.background = ((_loc5_.@background[0]) ? (_loc5_.@background[0] == "true") : false);
                        _loc17_.blend = ((_loc5_.@blend[0]) ? Number(_loc5_.@blend[0]) : 1);
                        _loc17_.color = ((_loc5_.@color[0]) ? uint(_loc5_.@color[0]) : 0xFFFFFF);
                        _loc17_.width_min = ((_loc5_.@width_min[0]) ? int(_loc5_.@width_min[0]) : int.MIN_VALUE);
                        _loc17_.width_max = ((_loc5_.@width_max[0]) ? int(_loc5_.@width_max[0]) : int.MAX_VALUE);
                        _loc17_.height_min = ((_loc5_.@height_min[0]) ? int(_loc5_.@height_min[0]) : int.MIN_VALUE);
                        _loc17_.height_max = ((_loc5_.@height_max[0]) ? int(_loc5_.@height_max[0]) : int.MAX_VALUE);
                        this.addSkinRenderer(this.var_2744[_loc7_], uint(_loc8_), _loc14_, _loc17_);
                        _loc18_++;
                    };
                };
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            this.var_2749 = null;
            this.var_2750 = null;
            this._assetLibrary = null;
            this._disposed = true;
        }

        public function addSkinRenderer(param1:uint, param2:uint, param3:ISkinRenderer, param4:DefaultAttStruct):void
        {
            if (this.var_2749[param1] == null)
            {
                this.var_2749[param1] = new Array(var_1191);
            };
            this.var_2749[param1][param2] = param3;
            if (this.var_2750[param1] == null)
            {
                this.var_2750[param1] = new Array(var_1191);
            };
            this.var_2750[param1][param2] = param4;
        }

        public function getSkinRendererByTypeAndStyle(param1:uint, param2:uint):ISkinRenderer
        {
            var _loc4_:ISkinRenderer;
            var _loc3_:Array = this.var_2749[param1];
            if (_loc3_)
            {
                _loc4_ = _loc3_[param2];
                if (((!(_loc4_)) && (!(param2 == WindowStyle.var_1192))))
                {
                    _loc4_ = _loc3_[WindowStyle.var_1192];
                };
            };
            return (_loc4_);
        }

        public function getDefaultAttributesByTypeAndStyle(param1:uint, param2:uint):DefaultAttStruct
        {
            var _loc4_:DefaultAttStruct;
            var _loc3_:Array = this.var_2750[param1];
            if (_loc3_)
            {
                _loc4_ = _loc3_[param2];
                if (((!(_loc4_)) && (!(param2 == WindowStyle.var_1192))))
                {
                    _loc4_ = _loc3_[WindowStyle.var_1192];
                };
            };
            return (_loc4_);
        }

        public function getTheActualState(param1:uint, param2:uint, param3:uint):uint
        {
            var _loc5_:uint;
            var _loc4_:ISkinRenderer = this.getSkinRendererByTypeAndStyle(param1, param2);
            if (_loc4_)
            {
                for each (_loc5_ in var_1182)
                {
                    if ((param3 & _loc5_) == _loc5_)
                    {
                        if (_loc4_.isStateDrawable(_loc5_))
                        {
                            return (_loc5_);
                        };
                    };
                };
            };
            return (0);
        }


    }
}