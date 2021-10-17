package com.sulake.habbo.avatar
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;

    public class PlaceholderPetImage extends PetImage 
    {

        private var _assets:IAssetLibrary;
        private var var_3077:Map;
        private var var_1033:BitmapData;

        public function PlaceholderPetImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:String, param4:String, param5:IAssetLibrary)
        {
            super(param1, param2, param3, param4);
            this._assets = param5;
            this.var_3077 = new Map();
            var _loc6_:AvatarCanvas = _structure.getCanvas(_scale, var_1022.definition.geometryType);
            if (_loc6_)
            {
                this.var_1033 = new BitmapData(_loc6_.width, _loc6_.height, true, 0xFFFFFF);
            };
        }

        override public function dispose():void
        {
            var _loc1_:BitmapData;
            if (this.var_3077)
            {
                for each (_loc1_ in this.var_3077)
                {
                };
                this.var_3077.dispose();
                (this.var_3077 = null);
            };
            if (this.var_1033)
            {
                (this.var_1033 = null);
            };
            (this._assets = null);
            super.dispose();
        }

        override public function getCroppedImage(param1:String):BitmapData
        {
            if (var_1023)
            {
                return (null);
            };
            var _loc2_:BitmapData = this.getPlaceHolderImage(var_1024, _scale);
            if (!_loc2_)
            {
                return (null);
            };
            return (_loc2_.clone());
        }

        override public function getImage(param1:String, param2:Boolean):BitmapData
        {
            if (var_1023)
            {
                return (null);
            };
            var _loc3_:BitmapData = this.getPlaceHolderImage(var_1024, _scale);
            if (((!(_loc3_)) || (!(this.var_1033))))
            {
                return (null);
            };
            this.var_1033.fillRect(this.var_1033.rect, 0xFFFFFF);
            this.var_1033.copyPixels(_loc3_, _loc3_.rect, new Point(((this.var_1033.width - _loc3_.width) / 2), (this.var_1033.height - _loc3_.height)), null, null, true);
            if (param2)
            {
                return (this.var_1033.clone());
            };
            return (this.var_1033);
        }

        private function getPlaceHolderImage(param1:int, param2:String):BitmapData
        {
            var _loc5_:BitmapDataAsset;
            var _loc3_:String = "pet_placeholder_";
            if (param2 == AvatarScaleType.var_275)
            {
                (_loc3_ = (_loc3_ + "s"));
            };
            (_loc3_ = (_loc3_ + param1.toString()));
            (_loc3_ = (_loc3_ + "_png"));
            var _loc4_:BitmapData = this.var_3077.getValue(_loc3_);
            if (!_loc4_)
            {
                _loc5_ = (this._assets.getAssetByName(_loc3_) as BitmapDataAsset);
                (_loc4_ = (_loc5_.content as BitmapData));
                this.var_3077.add(_loc3_, _loc4_.clone());
                (_loc4_ = this.var_3077.getValue(_loc3_));
            };
            return (_loc4_);
        }

        override public function isPlaceholder():Boolean
        {
            return (true);
        }


    }
}