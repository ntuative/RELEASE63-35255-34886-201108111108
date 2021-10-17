package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class Outfit implements IOutfit, IAvatarImageListener 
    {

        private var var_2438:HabboAvatarEditor;
        private var var_2994:String;
        private var var_2938:String;
        private var _view:OutfitView;
        private var var_1023:Boolean;

        public function Outfit(param1:HabboAvatarEditor, param2:String, param3:String)
        {
            this.var_2438 = param1;
            this._view = new OutfitView(param1.manager.windowManager, param1.manager.assets, (!(param2 == "")));
            switch (param3)
            {
                case FigureData.var_1672:
                case "m":
                case "M":
                    param3 = FigureData.var_1672;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    param3 = FigureData.FEMALE;
                    break;
            };
            this.var_2994 = param2;
            this.var_2938 = param3;
            this.update();
        }

        public function dispose():void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this.var_2994 = null;
            this.var_2938 = null;
            this.var_1023 = true;
            this.var_2438 = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function update():void
        {
            var _loc2_:BitmapData;
            var _loc1_:IAvatarImage = this.var_2438.manager.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType.var_275, this.var_2938, this);
            if (_loc1_)
            {
                _loc1_.setDirection(AvatarSetType.var_129, int(FigureData.var_2360));
                _loc2_ = _loc1_.getImage(AvatarSetType.var_129, true);
                if (this._view)
                {
                    this._view.udpate(_loc2_);
                };
                _loc1_.dispose();
            };
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }

        public function get view():OutfitView
        {
            return (this._view);
        }

        public function avatarImageReady(param1:String):void
        {
            this.update();
        }


    }
}