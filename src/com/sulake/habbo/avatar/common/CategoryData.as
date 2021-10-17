package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;

    public class CategoryData 
    {

        private const var_2933:int = 2;

        private var _parts:Array;
        private var var_2934:Array;
        private var var_2935:int = -1;
        private var var_2936:Array;

        public function CategoryData(param1:Array, param2:Array)
        {
            this._parts = param1;
            this.var_2934 = param2;
        }

        public function dispose():void
        {
            var _loc1_:AvatarEditorGridPartItem;
            var _loc2_:Array;
            var _loc3_:AvatarEditorGridColorItem;
            if (this._parts)
            {
                for each (_loc1_ in this._parts)
                {
                    _loc1_.dispose();
                };
                this._parts = null;
            };
            if (this.var_2934)
            {
                for each (_loc2_ in (this.var_2934 as Array))
                {
                    if (_loc2_)
                    {
                        for each (_loc3_ in _loc2_)
                        {
                            _loc3_.dispose();
                        };
                    };
                };
                this.var_2934 = null;
            };
            this.var_2935 = -1;
            this.var_2936 = null;
        }

        public function selectPartId(param1:int):void
        {
            var _loc3_:AvatarEditorGridPartItem;
            if (!this._parts)
            {
                return;
            };
            var _loc2_:int;
            while (_loc2_ < this._parts.length)
            {
                _loc3_ = this._parts[_loc2_];
                if (_loc3_.id == param1)
                {
                    this.selectPartIndex(_loc2_);
                    return;
                };
                _loc2_++;
            };
        }

        public function selectColorIds(param1:Array):void
        {
            var _loc2_:AvatarEditorGridColorItem;
            var _loc4_:Array;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:AvatarEditorGridColorItem;
            if (!this.var_2934)
            {
                return;
            };
            if (!param1)
            {
                return;
            };
            this.var_2936 = new Array(param1.length);
            var _loc3_:int;
            while (_loc3_ < this.var_2934.length)
            {
                _loc4_ = this.getPalette(_loc3_);
                if (_loc4_)
                {
                    if (param1.length > _loc3_)
                    {
                        _loc5_ = param1[_loc3_];
                    }
                    else
                    {
                        _loc7_ = (_loc4_[0] as AvatarEditorGridColorItem);
                        if (((_loc7_) && (_loc7_.partColor)))
                        {
                            _loc5_ = _loc7_.partColor.id;
                        };
                    };
                    _loc6_ = 0;
                    while (_loc6_ < _loc4_.length)
                    {
                        _loc2_ = (_loc4_[_loc6_] as AvatarEditorGridColorItem);
                        if (_loc2_.partColor.id == _loc5_)
                        {
                            this.var_2936[_loc3_] = _loc6_;
                            _loc2_.isSelected = true;
                        }
                        else
                        {
                            _loc2_.isSelected = false;
                        };
                        _loc6_++;
                    };
                };
                _loc3_++;
            };
            this.updatePartColors();
        }

        public function selectPartIndex(param1:int):AvatarEditorGridPartItem
        {
            var _loc2_:AvatarEditorGridPartItem;
            var _loc3_:AvatarEditorGridPartItem;
            if (!this._parts)
            {
                return (null);
            };
            if (((this.var_2935 >= 0) && (this._parts.length > this.var_2935)))
            {
                _loc2_ = this._parts[this.var_2935];
                if (_loc2_)
                {
                    _loc2_.isSelected = false;
                };
            };
            if (this._parts.length > param1)
            {
                _loc3_ = (this._parts[param1] as AvatarEditorGridPartItem);
                if (_loc3_)
                {
                    _loc3_.isSelected = true;
                    this.var_2935 = param1;
                    return (_loc3_);
                };
            };
            return (null);
        }

        public function selectColorIndex(param1:int, param2:int):AvatarEditorGridColorItem
        {
            var _loc3_:Array = this.getPalette(param2);
            if (!_loc3_)
            {
                return (null);
            };
            if (_loc3_.length <= param1)
            {
                return (null);
            };
            this.deselectColorIndex(this.var_2936[param2], param2);
            this.var_2936[param2] = param1;
            var _loc4_:AvatarEditorGridColorItem = (_loc3_[param1] as AvatarEditorGridColorItem);
            if (!_loc4_)
            {
                return (null);
            };
            _loc4_.isSelected = true;
            this.updatePartColors();
            return (_loc4_);
        }

        private function deselectColorIndex(param1:int, param2:int):void
        {
            var _loc3_:Array = this.getPalette(param2);
            if (!_loc3_)
            {
                return;
            };
            if (_loc3_.length <= param1)
            {
                return;
            };
            var _loc4_:AvatarEditorGridColorItem = (_loc3_[param1] as AvatarEditorGridColorItem);
            if (!_loc4_)
            {
                return;
            };
            _loc4_.isSelected = false;
        }

        public function getSelectedColorIds():Array
        {
            var _loc7_:Array;
            var _loc8_:AvatarEditorGridColorItem;
            if (((!(this.var_2936)) || (this.var_2936.length == 0)))
            {
                return (null);
            };
            if (((!(this.var_2934)) || (this.var_2934.length == 0)))
            {
                return (null);
            };
            var _loc1_:Array = (this.var_2934[0] as Array);
            if (((!(_loc1_)) || (_loc1_.length == 0)))
            {
                return (null);
            };
            var _loc2_:AvatarEditorGridColorItem = (_loc1_[0] as AvatarEditorGridColorItem);
            if (((!(_loc2_)) || (!(_loc2_.partColor))))
            {
                return (null);
            };
            var _loc3_:int = _loc2_.partColor.id;
            var _loc4_:Array = new Array();
            var _loc5_:int;
            while (_loc5_ < this.var_2936.length)
            {
                _loc7_ = this.var_2934[_loc5_];
                if (!((!(_loc7_)) || (_loc7_.length <= _loc5_)))
                {
                    if (_loc7_.length > this.var_2936[_loc5_])
                    {
                        _loc8_ = (_loc7_[this.var_2936[_loc5_]] as AvatarEditorGridColorItem);
                        if (((_loc8_) && (_loc8_.partColor)))
                        {
                            _loc4_.push(_loc8_.partColor.id);
                        }
                        else
                        {
                            _loc4_.push(_loc3_);
                        };
                    }
                    else
                    {
                        _loc4_.push(_loc3_);
                    };
                };
                _loc5_++;
            };
            var _loc6_:AvatarEditorGridPartItem = this.getCurrentPart();
            if (!_loc6_)
            {
                return (null);
            };
            return (_loc4_.slice(0, Math.max(_loc6_.colorLayerCount, 1)));
        }

        private function getSelectedColors():Array
        {
            var _loc2_:AvatarEditorGridColorItem;
            var _loc1_:Array = new Array();
            var _loc3_:int;
            while (_loc3_ < this.var_2936.length)
            {
                _loc2_ = this.getSelectedColor(_loc3_);
                if (_loc2_)
                {
                    _loc1_.push(_loc2_.partColor);
                }
                else
                {
                    _loc1_.push(null);
                };
                _loc3_++;
            };
            return (_loc1_);
        }

        public function getSelectedColor(param1:int):AvatarEditorGridColorItem
        {
            var _loc2_:Array = this.getPalette(param1);
            if (((!(_loc2_)) || (_loc2_.length <= this.var_2936[param1])))
            {
                return (null);
            };
            return (_loc2_[this.var_2936[param1]] as AvatarEditorGridColorItem);
        }

        public function getCurrentColorId(param1:int):int
        {
            var _loc2_:AvatarEditorGridColorItem = this.getSelectedColor(param1);
            if (((_loc2_) && (_loc2_.partColor)))
            {
                return (_loc2_.partColor.id);
            };
            return (0);
        }

        public function get parts():Array
        {
            return (this._parts);
        }

        public function getPalette(param1:int):Array
        {
            if (!this.var_2936)
            {
                return (null);
            };
            if (!this.var_2934)
            {
                return (null);
            };
            if (this.var_2934.length <= param1)
            {
                return (null);
            };
            return (this.var_2934[param1] as Array);
        }

        public function getCurrentPart():AvatarEditorGridPartItem
        {
            return (this._parts[this.var_2935] as AvatarEditorGridPartItem);
        }

        private function updatePartColors():void
        {
            var _loc2_:AvatarEditorGridPartItem;
            var _loc1_:Array = this.getSelectedColors();
            for each (_loc2_ in this._parts)
            {
                if (_loc2_)
                {
                    _loc2_.colors = _loc1_;
                };
            };
        }

        public function hasClubSelectionsOverLevel(param1:int):Boolean
        {
            var _loc6_:int;
            var _loc7_:IPartColor;
            var _loc8_:IFigurePartSet;
            var _loc2_:Boolean;
            var _loc3_:Array = this.getSelectedColors();
            if (_loc3_)
            {
                _loc6_ = 0;
                while (_loc6_ < _loc3_.length)
                {
                    _loc7_ = _loc3_[_loc6_];
                    if (((_loc7_) && (_loc7_.clubLevel > param1)))
                    {
                        _loc2_ = true;
                    };
                    _loc6_++;
                };
            };
            var _loc4_:Boolean;
            var _loc5_:AvatarEditorGridPartItem = this.getCurrentPart();
            if (((_loc5_) && (_loc5_.partSet)))
            {
                _loc8_ = _loc5_.partSet;
                if (((_loc8_) && (_loc8_.clubLevel > param1)))
                {
                    _loc4_ = true;
                };
            };
            return ((_loc2_) || (_loc4_));
        }

        public function stripClubItemsOverLevel(param1:int):Boolean
        {
            var _loc3_:IFigurePartSet;
            var _loc4_:AvatarEditorGridPartItem;
            var _loc2_:AvatarEditorGridPartItem = this.getCurrentPart();
            if (((_loc2_) && (_loc2_.partSet)))
            {
                _loc3_ = _loc2_.partSet;
                if (_loc3_.clubLevel > param1)
                {
                    _loc4_ = this.selectPartIndex(0);
                    if (((_loc4_) && (_loc4_.partSet == null)))
                    {
                        this.selectPartIndex(1);
                    };
                    return (true);
                };
            };
            return (false);
        }

        public function stripClubColorsOverLevel(param1:int):Boolean
        {
            var _loc9_:IPartColor;
            var _loc2_:Array = new Array();
            var _loc3_:Array = this.getSelectedColors();
            var _loc4_:Boolean;
            var _loc5_:Array = this.getPalette(0);
            if (((!(_loc5_)) || (_loc5_.length == 0)))
            {
                return (false);
            };
            var _loc6_:AvatarEditorGridColorItem = (_loc5_[0] as AvatarEditorGridColorItem);
            if (((!(_loc6_)) || (_loc6_.partColor)))
            {
                return (false);
            };
            var _loc7_:int = _loc6_.partColor.id;
            var _loc8_:int;
            while (_loc8_ < _loc3_.length)
            {
                _loc9_ = _loc3_[_loc8_];
                if (!_loc9_)
                {
                    _loc2_.push(_loc7_);
                    _loc4_ = true;
                }
                else
                {
                    if (_loc9_.clubLevel > param1)
                    {
                        _loc2_.push(_loc7_);
                        _loc4_ = true;
                    }
                    else
                    {
                        _loc2_.push(_loc9_.id);
                    };
                };
                _loc8_++;
            };
            if (_loc4_)
            {
                this.selectColorIds(_loc2_);
            };
            return (_loc4_);
        }


    }
}