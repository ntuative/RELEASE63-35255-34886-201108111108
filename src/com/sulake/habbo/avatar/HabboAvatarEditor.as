package com.sulake.habbo.avatar
{
    import com.sulake.habbo.avatar.structure.IFigureData;
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.enum.AvatarType;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import com.sulake.habbo.avatar.generic.BodyModel;
    import com.sulake.habbo.avatar.head.HeadModel;
    import com.sulake.habbo.avatar.torso.TorsoModel;
    import com.sulake.habbo.avatar.legs.LegsModel;
    import com.sulake.habbo.avatar.hotlooks.HotLooksModel;
    import com.sulake.habbo.avatar.enum.AvatarEditorSideCategory;
    import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
    import com.sulake.habbo.avatar.promo.ClubPromoModel;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.common.CategoryData;

    public class HabboAvatarEditor 
    {

        private static const var_1842:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
        private static const var_1843:String = "hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68";
        private static const each:int = 2;

        private var var_3062:uint;
        private var var_3061:HabboAvatarEditorManager;
        private var var_3063:IFigureData;
        private var _view:AvatarEditorView;
        private var _isInitialized:Boolean = false;
        private var var_534:Map;
        private var var_3064:Map;
        private var var_3065:Dictionary;
        private var var_2938:String = FigureData.var_1672;
        private var var_3066:String;
        private var var_3067:int = 0;
        private var var_3068:Boolean;
        private var var_3069:IHabboAvatarEditorDataSaver = null;
        private var var_3070:Boolean = false;

        public function HabboAvatarEditor(param1:uint, param2:HabboAvatarEditorManager)
        {
            this.var_3062 = param1;
            this.var_3061 = param2;
            this.var_3063 = this.var_3061.avatarRenderManager.getFigureData(AvatarType.var_178);
        }

        public function dispose():void
        {
            var _loc1_:IAvatarEditorCategoryModel;
            var _loc2_:ISideContentModel;
            if (this.var_534 != null)
            {
                for each (_loc1_ in this.var_534)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                };
                this.var_534 = null;
            };
            if (this.var_3064 != null)
            {
                for each (_loc2_ in this.var_3064)
                {
                    _loc2_.dispose();
                    _loc2_ = null;
                };
                this.var_3064 = null;
            };
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
            this.var_3063 = null;
            this.var_3065 = null;
            this.var_3069 = null;
        }

        private function init(param1:Array=null):void
        {
            if (this._isInitialized)
            {
                return;
            };
            this.var_3065 = new Dictionary();
            this.var_3065[FigureData.var_1672] = new FigureData(this);
            this.var_3065[FigureData.FEMALE] = new FigureData(this);
            var _loc2_:FigureData = this.var_3065[FigureData.var_1672];
            var _loc3_:FigureData = this.var_3065[FigureData.FEMALE];
            _loc2_.loadAvatarData(var_1842, FigureData.var_1672);
            _loc3_.loadAvatarData(var_1843, FigureData.FEMALE);
            this.var_534 = new Map();
            this.var_3064 = new Map();
            this.var_534.add(AvatarEditorFigureCategory.var_1844, new BodyModel(this));
            this.var_534.add(AvatarEditorFigureCategory.var_130, new HeadModel(this));
            this.var_534.add(AvatarEditorFigureCategory.var_1845, new TorsoModel(this));
            this.var_534.add(AvatarEditorFigureCategory.var_1846, new LegsModel(this));
            if (((param1 == null) || (param1.indexOf(AvatarEditorFigureCategory.HOTLOOKS) > -1)))
            {
                this.var_534.add(AvatarEditorFigureCategory.HOTLOOKS, new HotLooksModel(this));
            };
            this.var_3064.add(AvatarEditorSideCategory.var_1847, new WardrobeModel(this));
            this.var_3064.add(AvatarEditorSideCategory.var_1848, new ClubPromoModel(this));
            this._isInitialized = true;
        }

        public function loadAvatarInEditor(param1:String, param2:String, param3:int=0):void
        {
            var _loc6_:IAvatarEditorCategoryModel;
            switch (param2)
            {
                case FigureData.var_1672:
                case "m":
                case "M":
                    param2 = FigureData.var_1672;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    param2 = FigureData.FEMALE;
                    break;
            };
            var _loc4_:Boolean;
            if (this.var_3067 != param3)
            {
                this.var_3067 = param3;
                _loc4_ = true;
            };
            var _loc5_:FigureData = this.var_3065[param2];
            if (_loc5_ == null)
            {
                return;
            };
            _loc5_.loadAvatarData(param1, param2);
            if (param2 != this.gender)
            {
                this.gender = param2;
                _loc4_ = true;
            };
            if (this.var_3066 != param1)
            {
                this.var_3066 = param1;
                _loc4_ = true;
            };
            if (((this.var_534) && (_loc4_)))
            {
                for each (_loc6_ in this.var_534)
                {
                    _loc6_.reset();
                };
            };
            if (this._view != null)
            {
                this._view.update();
            };
        }

        public function getFigureSetType(param1:String):ISetType
        {
            if (this.var_3063 == null)
            {
                return (null);
            };
            return (this.var_3063.getSetType(param1));
        }

        public function getPalette(param1:int):IPalette
        {
            if (this.var_3063 == null)
            {
                return (null);
            };
            return (this.var_3063.getPalette(param1));
        }

        public function openWindow(param1:IHabboAvatarEditorDataSaver, param2:Array=null, param3:Boolean=false, param4:String=null):IFrameWindow
        {
            this.var_3069 = param1;
            this.var_3070 = param3;
            this.init(param2);
            if (this._view == null)
            {
                this._view = new AvatarEditorView(this, param2);
            };
            this.selectDefaultCategory(param2);
            return (this._view.getFrame(param2, param4));
        }

        public function embedToContext(param1:IWindowContainer=null, param2:IHabboAvatarEditorDataSaver=null, param3:Array=null, param4:Boolean=false):Boolean
        {
            this.var_3069 = param2;
            this.var_3070 = param4;
            this.init(param3);
            if (this._view == null)
            {
                this._view = new AvatarEditorView(this, param3);
            };
            this._view.embedToContext(param1, param3);
            this.selectDefaultCategory(param3);
            return (true);
        }

        private function selectDefaultCategory(param1:Array):void
        {
            if (((!(param1 == null)) && (param1.length > 0)))
            {
                this.toggleAvatarEditorPage(param1[0]);
            }
            else
            {
                this.toggleAvatarEditorPage(AvatarEditorFigureCategory.var_1844);
            };
        }

        public function get instanceId():uint
        {
            return (this.var_3062);
        }

        public function hide():void
        {
            this._view.hide();
        }

        public function getCategoryWindowContainer(param1:String):IWindowContainer
        {
            var _loc2_:IAvatarEditorCategoryModel = (this.var_534.getValue(param1) as IAvatarEditorCategoryModel);
            if (_loc2_ != null)
            {
                return (_loc2_.getWindowContainer());
            };
            return (null);
        }

        public function getSideContentWindowContainer(param1:String):IWindowContainer
        {
            var _loc2_:ISideContentModel = (this.var_3064.getValue(param1) as ISideContentModel);
            if (_loc2_ != null)
            {
                return (_loc2_.getWindowContainer());
            };
            return (null);
        }

        public function toggleAvatarEditorPage(param1:String):void
        {
            if (this._view)
            {
                this._view.toggleCategoryView(param1, false);
            };
        }

        public function useClubClothing():void
        {
            if (this.var_534 == null)
            {
                return;
            };
            if (this.var_3068)
            {
                return;
            };
            this.var_3068 = true;
            this.update();
        }

        public function get figureData():FigureData
        {
            return (this.var_3065[this.var_2938]);
        }

        public function saveCurrentSelection():void
        {
            var _loc3_:UpdateFigureDataMessageComposer;
            var _loc1_:String = this.figureData.getFigureString();
            var _loc2_:String = this.figureData.gender;
            if (this.var_3069 != null)
            {
                this.var_3069.saveFigure(_loc1_, _loc2_);
            }
            else
            {
                _loc3_ = new UpdateFigureDataMessageComposer(_loc1_, _loc2_);
                this.var_3061.communication.getHabboMainConnection(null).send(_loc3_);
                _loc3_.dispose();
                _loc3_ = null;
            };
        }

        public function generateDataContent(param1:IAvatarEditorCategoryModel, param2:String):CategoryData
        {
            var _loc5_:int;
            var _loc6_:IFigurePartSet;
            var _loc7_:AvatarEditorGridPartItem;
            var _loc8_:ISetType;
            var _loc9_:IPalette;
            var _loc10_:Array;
            var _loc11_:Array;
            var _loc12_:Boolean;
            var _loc13_:IPartColor;
            var _loc14_:Array;
            var _loc15_:Boolean;
            var _loc16_:Boolean;
            var _loc17_:int;
            var _loc18_:AvatarEditorGridColorItem;
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:BitmapDataAsset;
            var _loc22_:BitmapData;
            var _loc23_:Boolean;
            var _loc24_:Array;
            if (!param1)
            {
                return (null);
            };
            if (!param2)
            {
                return (null);
            };
            var _loc3_:Array = [];
            var _loc4_:Array = new Array();
            _loc5_ = 0;
            while (_loc5_ < each)
            {
                _loc4_.push(new Array());
                _loc5_++;
            };
            _loc8_ = this.getFigureSetType(param2);
            if (!_loc8_)
            {
                return (null);
            };
            if (_loc8_ != null)
            {
                _loc9_ = this.getPalette(_loc8_.paletteID);
                if (!_loc9_)
                {
                    return (null);
                };
                _loc10_ = this.figureData.getColourIds(param2);
                if (!_loc10_)
                {
                    _loc10_ = new Array();
                };
                _loc11_ = new Array(_loc10_.length);
                _loc12_ = ((this.isClubTryoutAllowed()) && (this.var_3068));
                for each (_loc13_ in _loc9_.colors)
                {
                    if (((_loc13_.isSelectable) && ((_loc12_) || (this.var_3067 >= _loc13_.clubLevel))))
                    {
                        _loc17_ = 0;
                        while (_loc17_ < each)
                        {
                            _loc18_ = new AvatarEditorGridColorItem((AvatarEditorView.var_1849.clone() as IWindowContainer), param1, _loc13_);
                            _loc4_[_loc17_].push(_loc18_);
                            _loc17_++;
                        };
                        if (param2 != FigureData.var_1850)
                        {
                            _loc19_ = 0;
                            while (_loc19_ < _loc10_.length)
                            {
                                if (_loc13_.id == _loc10_[_loc19_])
                                {
                                    _loc11_[_loc19_] = _loc13_;
                                };
                                _loc19_++;
                            };
                        };
                    };
                };
                if (_loc12_)
                {
                    _loc20_ = 2;
                    _loc14_ = this.var_3061.avatarRenderManager.getMandatoryAvatarPartSetIds(this.gender, _loc20_);
                }
                else
                {
                    _loc14_ = this.var_3061.avatarRenderManager.getMandatoryAvatarPartSetIds(this.gender, this.clubMemberLevel);
                };
                _loc15_ = Boolean((_loc14_.indexOf(param2) == -1));
                if (_loc15_)
                {
                    _loc21_ = (this.var_3061.assets.getAssetByName("removeSelection") as BitmapDataAsset);
                    if (_loc21_)
                    {
                        _loc22_ = (_loc21_.content as BitmapData).clone();
                        _loc7_ = new AvatarEditorGridPartItem((AvatarEditorView.var_1851.clone() as IWindowContainer), param1, null, null, false);
                        _loc7_.iconImage = _loc22_;
                        _loc3_.push(_loc7_);
                    };
                };
                _loc16_ = (!(param2 == FigureData.var_1850));
                for each (_loc6_ in _loc8_.partSets)
                {
                    _loc23_ = false;
                    if (_loc6_.gender == FigureData.var_1852)
                    {
                        _loc23_ = true;
                    }
                    else
                    {
                        if (_loc6_.gender == this.gender)
                        {
                            _loc23_ = true;
                        };
                    };
                    if ((((_loc6_.isSelectable) && (_loc23_)) && ((_loc12_) || (this.var_3067 >= _loc6_.clubLevel))))
                    {
                        _loc7_ = new AvatarEditorGridPartItem((AvatarEditorView.var_1851.clone() as IWindowContainer), param1, _loc6_, _loc11_, _loc16_);
                        _loc3_.push(_loc7_);
                    };
                };
            };
            _loc3_.sort(this.orderByClub);
            _loc5_ = 0;
            while (_loc5_ < each)
            {
                _loc24_ = (_loc4_[_loc5_] as Array);
                _loc24_.sort(this.orderPaletteByClub);
                _loc5_++;
            };
            return (new CategoryData(_loc3_, _loc4_));
        }

        public function isClubTryoutAllowed():Boolean
        {
            return (this.var_3061.configuration.getBoolean("avatareditor.allowclubtryout", false));
        }

        public function isSideContentEnabled():Boolean
        {
            return (this.var_3070);
        }

        public function hasInvalidClubItems():Boolean
        {
            var _loc2_:IAvatarEditorCategoryModel;
            var _loc3_:Boolean;
            var _loc1_:Boolean;
            for each (_loc2_ in this.var_534)
            {
                _loc3_ = _loc2_.hasClubItemsOverLevel(this.clubMemberLevel);
                if (_loc3_)
                {
                    _loc1_ = true;
                };
            };
            return (_loc1_);
        }

        public function stripClubItems():void
        {
            var _loc1_:IAvatarEditorCategoryModel;
            for each (_loc1_ in this.var_534)
            {
                _loc1_.stripClubItemsOverLevel(this.clubMemberLevel);
            };
            this.figureData.updateView();
        }

        public function getDefaultColour(param1:String):int
        {
            var _loc3_:IPalette;
            var _loc4_:IPartColor;
            var _loc2_:ISetType = this.getFigureSetType(param1);
            if (_loc2_ != null)
            {
                _loc3_ = this.getPalette(_loc2_.paletteID);
                for each (_loc4_ in _loc3_.colors)
                {
                    if (((_loc4_.isSelectable) && (this.var_3067 >= _loc4_.clubLevel)))
                    {
                        return (_loc4_.id);
                    };
                };
            };
            return (-1);
        }

        private function orderByClub(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem):Number
        {
            var _loc3_:Number = ((param1.partSet == null) ? -1 : Number(param1.partSet.clubLevel));
            var _loc4_:Number = ((param2.partSet == null) ? -1 : Number(param2.partSet.clubLevel));
            if (_loc3_ < _loc4_)
            {
                return (-1);
            };
            if (_loc3_ > _loc4_)
            {
                return (1);
            };
            if (param1.partSet.id < param2.partSet.id)
            {
                return (-1);
            };
            if (param1.partSet.id > param2.partSet.id)
            {
                return (1);
            };
            return (0);
        }

        private function orderPaletteByClub(param1:AvatarEditorGridColorItem, param2:AvatarEditorGridColorItem):Number
        {
            var _loc3_:Number = ((param1.partColor == null) ? -1 : (param1.partColor.clubLevel as Number));
            var _loc4_:Number = ((param2.partColor == null) ? -1 : (param2.partColor.clubLevel as Number));
            if (_loc3_ < _loc4_)
            {
                return (-1);
            };
            if (_loc3_ > _loc4_)
            {
                return (1);
            };
            if (param1.partColor.index < param2.partColor.index)
            {
                return (-1);
            };
            if (param1.partColor.index > param2.partColor.index)
            {
                return (1);
            };
            return (0);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }

        public function set gender(param1:String):void
        {
            var _loc2_:IAvatarEditorCategoryModel;
            if (this.var_2938 == param1)
            {
                return;
            };
            this.var_2938 = param1;
            for each (_loc2_ in this.var_534)
            {
                _loc2_.reset();
            };
            if (this._view != null)
            {
                this._view.update();
            };
        }

        public function get handler():AvatarEditorMessageHandler
        {
            return (this.var_3061.handler);
        }

        public function get wardrobe():WardrobeModel
        {
            if (!this._isInitialized)
            {
                return (null);
            };
            return (this.var_3064.getValue(AvatarEditorSideCategory.var_1847));
        }

        public function set clubMemberLevel(param1:int):void
        {
            this.var_3067 = param1;
        }

        public function get clubMemberLevel():int
        {
            return (this.var_3067);
        }

        public function get manager():HabboAvatarEditorManager
        {
            return (this.var_3061);
        }

        public function update():void
        {
            var _loc1_:IAvatarEditorCategoryModel;
            var _loc2_:ISideContentModel;
            for each (_loc1_ in this.var_534)
            {
                _loc1_.reset();
            };
            for each (_loc2_ in this.var_3064)
            {
                _loc2_.reset();
            };
            if (this._view)
            {
                this._view.update();
            };
        }


    }
}