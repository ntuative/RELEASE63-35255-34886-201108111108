package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.avatar.structure.figure.IFigurePart;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarFigureContainer;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;

    public class AvatarEditorGridPartItem implements IAvatarImageListener 
    {

        private static var var_2442:Array = [];

        private const var_2925:int = 0xCCCCCC;
        private const var_2926:int = 0xFFFFFF;
        private const var_2927:Array = [2, 6, 0, 4, 3, 1];

        private var var_2533:IAvatarEditorCategoryModel;
        private var _window:IWindowContainer;
        private var var_2918:IWindow;
        private var var_2919:IFigurePartSet;
        private var _colors:Array;
        private var var_2920:Boolean;
        private var _isSelected:Boolean = false;
        private var var_2921:BitmapData;
        private var var_2922:Rectangle;
        private var var_2917:int = 0;
        private var var_2923:IAvatarRenderManager;
        private var var_1023:Boolean;
        private var var_2924:BitmapData;

        {
            var_2442.push("li");
            var_2442.push("lh");
            var_2442.push("ls");
            var_2442.push("lc");
            var_2442.push("bd");
            var_2442.push("sh");
            var_2442.push("lg");
            var_2442.push("ch");
            var_2442.push("ca");
            var_2442.push("cc");
            var_2442.push("cp");
            var_2442.push("wa");
            var_2442.push("rh");
            var_2442.push("rs");
            var_2442.push("rc");
            var_2442.push("hd");
            var_2442.push("fc");
            var_2442.push("ey");
            var_2442.push("hr");
            var_2442.push("hrb");
            var_2442.push("fa");
            var_2442.push("ea");
            var_2442.push("ha");
            var_2442.push("he");
            var_2442.push("ri");
        }

        public function AvatarEditorGridPartItem(param1:IWindowContainer, param2:IAvatarEditorCategoryModel, param3:IFigurePartSet, param4:Array, param5:Boolean=true)
        {
            var _loc6_:IFigurePart;
            var _loc7_:Array;
            super();
            this.var_2533 = param2;
            this.var_2919 = param3;
            this._window = param1;
            this.var_2918 = this._window.findChildByTag("BG_COLOR");
            this._colors = param4;
            this.var_2920 = param5;
            if (param3 == null)
            {
                this.var_2921 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            if (param3 != null)
            {
                _loc7_ = param3.parts;
                for each (_loc6_ in _loc7_)
                {
                    this.var_2917 = Math.max(this.var_2917, _loc6_.colorLayerIndex);
                };
            };
            this.var_2923 = this.var_2533.controller.manager.avatarRenderManager;
            this.updateThumbVisualization();
        }

        public function dispose():void
        {
            this.var_2533 = null;
            this.var_2919 = null;
            if (this._window != null)
            {
                if (!this._window.disposed)
                {
                    this._window.dispose();
                };
            };
            this._window = null;
            if (this.var_2921)
            {
                this.var_2921.dispose();
            };
            this.var_2921 = null;
            this.var_1023 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get view():IWindowContainer
        {
            return (this._window);
        }

        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }

        public function set isSelected(param1:Boolean):void
        {
            this._isSelected = param1;
            this.updateThumbVisualization();
        }

        public function get id():int
        {
            if (this.var_2919 == null)
            {
                return (-1);
            };
            return (this.var_2919.id);
        }

        public function get colorLayerCount():int
        {
            return (this.var_2917);
        }

        public function update():void
        {
            this.updateThumbVisualization();
        }

        public function set iconImage(param1:BitmapData):void
        {
            this.var_2921 = param1;
            this.updateThumbVisualization();
        }

        public function get partSet():IFigurePartSet
        {
            return (this.var_2919);
        }

        public function set colors(param1:Array):void
        {
            this._colors = param1;
            this.updateThumbVisualization();
        }

        private function updateThumbVisualization():void
        {
            var _loc3_:BitmapData;
            var _loc4_:BitmapData;
            var _loc5_:int;
            var _loc6_:int;
            if (((!(this._window)) || (this._window.disposed)))
            {
                return;
            };
            var _loc1_:IBitmapWrapperWindow = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_loc1_)
            {
                if (((!(this.var_2921 == null)) && (!(this.var_2920))))
                {
                    _loc3_ = this.var_2921;
                }
                else
                {
                    _loc3_ = this.renderThumb();
                    if (!_loc3_)
                    {
                        return;
                    };
                };
                _loc4_ = ((_loc1_.bitmap) ? _loc1_.bitmap : new BitmapData(_loc1_.width, _loc1_.height));
                _loc4_.fillRect(_loc4_.rect, 0xFFFFFF);
                _loc5_ = int(((_loc4_.width - _loc3_.width) / 2));
                _loc6_ = int(((_loc4_.height - _loc3_.height) / 2));
                _loc4_.copyPixels(_loc3_, _loc3_.rect, new Point(_loc5_, _loc6_), null, null, true);
                _loc1_.bitmap = _loc4_;
            };
            var _loc2_:IIconWindow = (this._window.findChildByTag("CLUB_ICON") as IIconWindow);
            if (_loc2_)
            {
                if (this.var_2919)
                {
                    switch (this.var_2919.clubLevel)
                    {
                        case HabboClubLevelEnum.var_255:
                            _loc2_.visible = false;
                            break;
                        case HabboClubLevelEnum.var_256:
                            _loc2_.style = HabboIconType.var_134;
                            break;
                        case HabboClubLevelEnum.var_114:
                            _loc2_.style = HabboIconType.var_135;
                            break;
                    };
                }
                else
                {
                    _loc2_.visible = false;
                };
            };
            if (this.var_2918 == null)
            {
                return;
            };
            if (this.isSelected)
            {
                this.var_2918.color = this.var_2925;
            }
            else
            {
                this.var_2918.color = this.var_2926;
            };
            this._window.invalidate();
        }

        private function analyzePartLayers():Boolean
        {
            var _loc2_:IFigurePart;
            var _loc3_:String;
            var _loc4_:BitmapDataAsset;
            var _loc5_:BitmapData;
            if (this.var_2533 == null)
            {
                this.var_2922 = null;
                return (false);
            };
            if ((((!(this.partSet)) || (!(this.partSet.parts))) || (this.partSet.parts.length == 0)))
            {
                this.var_2922 = null;
                return (false);
            };
            if (!this.var_2923)
            {
                return (false);
            };
            var _loc1_:IAvatarFigureContainer = this.var_2923.createFigureContainer(((this.partSet.type + "-") + this.partSet.id));
            Logger.log(((("QUERYING SET:" + this.partSet.type) + "-") + this.partSet.id));
            if (!this.var_2923.isFigureReady(_loc1_))
            {
                this.var_2923.downloadFigure(_loc1_, this);
                return (false);
            };
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:Rectangle = new Rectangle();
            for each (_loc2_ in this.partSet.parts)
            {
                if (_loc7_)
                {
                    _loc3_ = ((((((((((FigureData.var_2358 + "_") + FigureData.var_2359) + "_") + _loc2_.type) + "_") + _loc2_.id) + "_") + this.var_2927[_loc6_]) + "_") + FigureData.var_221);
                    _loc4_ = (this.var_2923.getAssetByName(_loc3_) as BitmapDataAsset);
                }
                else
                {
                    _loc6_ = 0;
                    while (((!(_loc7_)) && (_loc6_ < this.var_2927.length)))
                    {
                        _loc3_ = ((((((((((FigureData.var_2358 + "_") + FigureData.var_2359) + "_") + _loc2_.type) + "_") + _loc2_.id) + "_") + this.var_2927[_loc6_]) + "_") + FigureData.var_221);
                        _loc4_ = (this.var_2923.getAssetByName(_loc3_) as BitmapDataAsset);
                        if (((_loc4_) && (_loc4_.content)))
                        {
                            _loc7_ = true;
                        }
                        else
                        {
                            _loc6_++;
                        };
                    };
                };
                if (((_loc4_) && (_loc4_.content)))
                {
                    _loc5_ = (_loc4_.content as BitmapData);
                    _loc8_ = _loc8_.union(new Rectangle((-1 * _loc4_.offset.x), (-1 * _loc4_.offset.y), _loc5_.width, _loc5_.height));
                };
            };
            if (((_loc8_) && (_loc8_.width > 0)))
            {
                this.var_2922 = _loc8_;
                return (true);
            };
            return (false);
        }

        private function renderThumb():BitmapData
        {
            var _loc1_:BitmapData;
            var _loc2_:IFigurePart;
            var _loc3_:String;
            var _loc4_:BitmapDataAsset;
            var _loc5_:BitmapData;
            var _loc9_:IAsset;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:IPartColor;
            if (this.partSet == null)
            {
                return (null);
            };
            if (this.var_2533 == null)
            {
                return (null);
            };
            if (this.var_2922 == null)
            {
                if (!this.analyzePartLayers())
                {
                    if (!this.var_2924)
                    {
                        _loc9_ = this.var_2533.controller.manager.assets.getAssetByName("avatar_editor_download_icon");
                        this.var_2924 = (_loc9_.content as BitmapData);
                    };
                    return (this.var_2924);
                };
            };
            if (!this.var_2923)
            {
                return (null);
            };
            _loc1_ = new BitmapData(this.var_2922.width, this.var_2922.height, true, 0xFFFFFF);
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:Array = this.partSet.parts.concat().sort(this.sortByDrawOrder);
            for each (_loc2_ in _loc8_)
            {
                if (_loc7_)
                {
                    _loc3_ = ((((((((((FigureData.var_2358 + "_") + FigureData.var_2359) + "_") + _loc2_.type) + "_") + _loc2_.id) + "_") + this.var_2927[_loc6_]) + "_") + FigureData.var_221);
                    _loc4_ = (this.var_2923.getAssetByName(_loc3_) as BitmapDataAsset);
                }
                else
                {
                    _loc6_ = 0;
                    while (((!(_loc7_)) && (_loc6_ < this.var_2927.length)))
                    {
                        _loc3_ = ((((((((((FigureData.var_2358 + "_") + FigureData.var_2359) + "_") + _loc2_.type) + "_") + _loc2_.id) + "_") + this.var_2927[_loc6_]) + "_") + FigureData.var_221);
                        _loc4_ = (this.var_2923.getAssetByName(_loc3_) as BitmapDataAsset);
                        if (((_loc4_) && (_loc4_.content)))
                        {
                            _loc7_ = true;
                        }
                        else
                        {
                            _loc6_++;
                        };
                    };
                };
                if (_loc4_)
                {
                    _loc5_ = (_loc4_.content as BitmapData).clone();
                    _loc10_ = ((-1 * _loc4_.offset.x) - this.var_2922.x);
                    _loc11_ = ((-1 * _loc4_.offset.y) - this.var_2922.y);
                    if (((this.var_2920) && (_loc2_.colorLayerIndex > 0)))
                    {
                        _loc12_ = this._colors[(_loc2_.colorLayerIndex - 1)];
                        if (_loc12_ != null)
                        {
                            _loc5_.colorTransform(_loc5_.rect, _loc12_.colorTransform);
                        };
                    };
                    _loc1_.copyPixels(_loc5_, _loc5_.rect, new Point(_loc10_, _loc11_), null, null, true);
                }
                else
                {
                    Logger.log(("Could not find asset: " + _loc3_));
                };
            };
            return (_loc1_);
        }

        private function sortByDrawOrder(param1:IFigurePart, param2:IFigurePart):Number
        {
            var _loc3_:Number = var_2442.indexOf(param1.type);
            var _loc4_:Number = var_2442.indexOf(param2.type);
            if (_loc3_ < _loc4_)
            {
                return (-1);
            };
            if (_loc3_ > _loc4_)
            {
                return (1);
            };
            if (param1.index < param2.index)
            {
                return (-1);
            };
            if (param1.index > param2.index)
            {
                return (1);
            };
            return (0);
        }

        public function avatarImageReady(param1:String):void
        {
            if (!this.analyzePartLayers())
            {
                return;
            };
            this.updateThumbVisualization();
        }


    }
}