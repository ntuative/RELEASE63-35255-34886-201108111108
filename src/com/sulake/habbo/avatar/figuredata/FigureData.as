package com.sulake.habbo.avatar.figuredata
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class FigureData implements IAvatarImageListener 
    {

        public static const var_1672:String = "M";
        public static const FEMALE:String = "F";
        public static const var_1852:String = "U";
        public static const var_2358:String = "h";
        public static const var_2359:String = "std";
        public static const var_2360:String = "4";
        public static const var_221:String = "0";
        public static const var_1850:String = "hd";
        public static const var_2361:String = "hr";
        public static const var_2362:String = "ha";
        public static const var_2363:String = "he";
        public static const var_2364:String = "ea";
        public static const var_2365:String = "fa";
        public static const var_2366:String = "cc";
        public static const var_2367:String = "ch";
        public static const var_2368:String = "ca";
        public static const CHEST_PRINTS:String = "cp";
        public static const var_2369:String = "lg";
        public static const var_2370:String = "sh";
        public static const var_2371:String = "wa";

        private var var_2937:HabboAvatarEditor;
        private var _view:FigureDataView;
        private var _data:Dictionary;
        private var _colors:Dictionary;
        private var var_2938:String = "M";
        private var var_1023:Boolean;

        public function FigureData(param1:HabboAvatarEditor)
        {
            this.var_2937 = param1;
            this._view = new FigureDataView(param1.manager.windowManager, param1.manager.assets);
        }

        public function loadAvatarData(param1:String, param2:String):void
        {
            this._data = new Dictionary();
            this._colors = new Dictionary();
            this.var_2938 = param2;
            this.parseFigureString(param1);
            this.updateView();
        }

        public function dispose():void
        {
            this.var_2937 = null;
            this._view = null;
            this._data = null;
            this._colors = null;
            this.var_1023 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        private function parseFigureString(param1:String):void
        {
            var _loc2_:String;
            var _loc3_:Array;
            var _loc4_:String;
            var _loc5_:int;
            var _loc6_:Array;
            var _loc7_:int;
            if (param1 == null)
            {
                return;
            };
            for each (_loc2_ in param1.split("."))
            {
                _loc3_ = _loc2_.split("-");
                if (_loc3_.length > 0)
                {
                    _loc4_ = String(_loc3_[0]);
                    _loc5_ = parseInt(_loc3_[1]);
                    _loc6_ = new Array();
                    _loc7_ = 2;
                    while (_loc7_ < _loc3_.length)
                    {
                        _loc6_.push(_loc3_[_loc7_]);
                        _loc7_++;
                    };
                    if (_loc6_.length == 0)
                    {
                        _loc6_.push(0);
                    };
                    this.savePartSetId(_loc4_, _loc5_, false);
                    this.savePartSetColourId(_loc4_, _loc6_, false);
                };
            };
        }

        public function getPartSetId(param1:String):int
        {
            if (this._data[param1] != null)
            {
                return (this._data[param1]);
            };
            return (-1);
        }

        public function getColourIds(param1:String):Array
        {
            if (this._colors[param1] != null)
            {
                return (this._colors[param1]);
            };
            return ([this.var_2937.getDefaultColour(param1)]);
        }

        public function getFigureString():String
        {
            var _loc3_:String;
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:Array;
            var _loc7_:String;
            var _loc8_:int;
            var _loc1_:String = "";
            var _loc2_:Array = [];
            for (_loc3_ in this._data)
            {
                if (this._data[_loc3_] != null)
                {
                    _loc5_ = this._data[_loc3_];
                    _loc6_ = (this._colors[_loc3_] as Array);
                    _loc7_ = ((_loc3_ + "-") + _loc5_);
                    if (_loc6_)
                    {
                        _loc8_ = 0;
                        while (_loc8_ < _loc6_.length)
                        {
                            _loc7_ = (_loc7_ + ("-" + _loc6_[_loc8_]));
                            _loc8_++;
                        };
                    };
                    _loc2_.push(_loc7_);
                };
            };
            _loc4_ = 0;
            while (_loc4_ < _loc2_.length)
            {
                _loc1_ = (_loc1_ + _loc2_[_loc4_]);
                if (_loc4_ < (_loc2_.length - 1))
                {
                    _loc1_ = (_loc1_ + ".");
                };
                _loc4_++;
            };
            return (_loc1_);
        }

        public function savePartData(param1:String, param2:int, param3:Array, param4:Boolean=false):void
        {
            this.savePartSetId(param1, param2, param4);
            this.savePartSetColourId(param1, param3, param4);
        }

        private function savePartSetId(param1:String, param2:int, param3:Boolean=true):void
        {
            switch (param1)
            {
                case var_1850:
                case var_2361:
                case var_2362:
                case var_2363:
                case var_2364:
                case var_2365:
                case var_2367:
                case var_2366:
                case var_2368:
                case CHEST_PRINTS:
                case var_2369:
                case var_2370:
                case var_2371:
                    if (param2 >= 0)
                    {
                        this._data[param1] = param2;
                    }
                    else
                    {
                        delete this._data[param1];
                    };
                    break;
                default:
                    Logger.log(((("[FigureData] Unknown partset: " + param1) + ", can not store id: ") + param2));
            };
            if (param3)
            {
                this.updateView();
            };
        }

        public function savePartSetColourId(param1:String, param2:Array, param3:Boolean=true):void
        {
            switch (param1)
            {
                case var_1850:
                case var_2361:
                case var_2362:
                case var_2363:
                case var_2364:
                case var_2365:
                case var_2367:
                case var_2366:
                case var_2368:
                case CHEST_PRINTS:
                case var_2369:
                case var_2370:
                case var_2371:
                    this._colors[param1] = param2;
                    break;
                default:
                    Logger.log((("[FigureData] Unknown partset: " + param1) + ", can not store color-ids"));
            };
            if (param3)
            {
                this.updateView();
            };
        }

        public function getFigureStringWithFace(param1:int):String
        {
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:Array;
            var _loc9_:String;
            var _loc10_:int;
            var _loc2_:Array = [];
            _loc2_.push(var_1850);
            var _loc3_:String = "";
            var _loc4_:Array = [];
            for each (_loc5_ in _loc2_)
            {
                if (this._colors[_loc5_] != null)
                {
                    _loc7_ = this._data[_loc5_];
                    _loc8_ = (this._colors[_loc5_] as Array);
                    if (_loc5_ == var_1850)
                    {
                        _loc7_ = param1;
                    };
                    _loc9_ = ((_loc5_ + "-") + _loc7_);
                    if (_loc7_ >= 0)
                    {
                        _loc10_ = 0;
                        while (_loc10_ < _loc8_.length)
                        {
                            _loc9_ = (_loc9_ + ("-" + _loc8_[_loc10_]));
                            _loc10_++;
                        };
                    };
                    _loc4_.push(_loc9_);
                };
            };
            _loc6_ = 0;
            while (_loc6_ < _loc4_.length)
            {
                _loc3_ = (_loc3_ + _loc4_[_loc6_]);
                if (_loc6_ < (_loc4_.length - 1))
                {
                    _loc3_ = (_loc3_ + ".");
                };
                _loc6_++;
            };
            return (_loc3_);
        }

        public function updateView():void
        {
            var _loc3_:BitmapData;
            var _loc4_:BitmapData;
            var _loc1_:String = this.getFigureString();
            var _loc2_:IAvatarImage = this.var_2937.manager.avatarRenderManager.createAvatarImage(_loc1_, AvatarScaleType.var_128, this.gender, this);
            if (_loc2_)
            {
                _loc2_.setDirection(AvatarSetType.var_129, int(var_2360));
                _loc3_ = _loc2_.getImage(AvatarSetType.var_129, true);
                this._view.udpate(_loc3_);
                _loc2_.dispose();
            }
            else
            {
                Logger.log("Unable to create avatar image for the preview in avatar editor!");
                _loc4_ = new BitmapData(1, 1);
                this._view.udpate(_loc4_);
            };
        }

        public function get view():FigureDataView
        {
            return (this._view);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }

        public function avatarImageReady(param1:String):void
        {
            this.updateView();
        }


    }
}