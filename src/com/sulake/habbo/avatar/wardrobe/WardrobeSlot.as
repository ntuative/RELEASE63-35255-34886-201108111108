package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.geom.Matrix;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class WardrobeSlot implements IOutfit, IAvatarImageListener 
    {

        private var var_2438:HabboAvatarEditor;
        private var var_2994:String;
        private var var_2938:String;
        private var var_2996:Boolean;
        private var _view:IWindowContainer;
        private var var_2997:IBitmapWrapperWindow;
        private var var_2998:int;
        private var var_1023:Boolean;

        public function WardrobeSlot(param1:HabboAvatarEditor, param2:int, param3:Boolean, param4:String=null, param5:String=null)
        {
            this.var_2438 = param1;
            this.var_2998 = param2;
            this.createView();
            this.update(param4, param5, param3);
        }

        public function get id():int
        {
            return (this.var_2998);
        }

        public function update(param1:String, param2:String, param3:Boolean):void
        {
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
            this.var_2994 = param1;
            this.var_2938 = param2;
            this.var_2996 = param3;
            this.updateView();
        }

        private function createView():void
        {
            var _loc1_:XmlAsset = (this.var_2438.manager.assets.getAssetByName("wardrobe_slot") as XmlAsset);
            if (!_loc1_)
            {
                return;
            };
            this._view = (this.var_2438.manager.windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
            this._view.procedure = this.eventHandler;
            this._view.visible = false;
            this.var_2997 = (this._view.findChildByName("image") as IBitmapWrapperWindow);
        }

        public function dispose():void
        {
            this.var_2438 = null;
            this.var_2994 = null;
            this.var_2938 = null;
            this.var_2997 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this.var_1023 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function updateView():void
        {
            var _loc1_:BitmapData;
            var _loc5_:IAvatarImage;
            var _loc6_:BitmapDataAsset;
            var _loc7_:int;
            var _loc8_:int;
            var _loc2_:Boolean = true;
            if (((this.var_2994) && (this.var_2996)))
            {
                _loc5_ = this.var_2438.manager.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType.var_275, this.var_2938, this);
                if (_loc5_)
                {
                    _loc5_.setDirection(AvatarSetType.var_129, parseInt(FigureData.var_2360));
                    _loc1_ = _loc5_.getCroppedImage(AvatarSetType.var_129);
                    _loc5_.dispose();
                };
            }
            else
            {
                _loc6_ = (this.var_2438.manager.assets.getAssetByName("wardrobe_empty_slot") as BitmapDataAsset);
                if (_loc6_)
                {
                    _loc1_ = (_loc6_.content as BitmapData);
                    _loc2_ = false;
                };
            };
            if (!_loc1_)
            {
                return;
            };
            if (this.var_2997)
            {
                if (this.var_2997.bitmap)
                {
                    this.var_2997.bitmap.dispose();
                };
                this.var_2997.bitmap = new BitmapData(this.var_2997.width, this.var_2997.height, true, 0);
                _loc7_ = int(((this.var_2997.width - _loc1_.width) / 2));
                _loc8_ = int(((this.var_2997.height - _loc1_.height) / 2));
                this.var_2997.bitmap.draw(_loc1_, new Matrix(1, 0, 0, 1, _loc7_, _loc8_));
            };
            if (_loc2_)
            {
                _loc1_.dispose();
            };
            var _loc3_:IContainerButtonWindow = (this._view.findChildByName("set_button") as IContainerButtonWindow);
            if (_loc3_)
            {
                _loc3_.visible = this.var_2996;
            };
            var _loc4_:IContainerButtonWindow = (this._view.findChildByName("get_button") as IContainerButtonWindow);
            if (_loc4_)
            {
                _loc4_.visible = ((this.var_2996) && (!(this.var_2994 == null)));
            };
        }

        private function eventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "set_button":
                    this.var_2994 = this.var_2438.figureData.getFigureString();
                    this.var_2938 = this.var_2438.gender;
                    this.var_2438.handler.saveWardrobeOutfit(this.var_2998, this);
                    this.updateView();
                    return;
                case "get_button":
                    if (this.var_2994)
                    {
                        this.var_2438.loadAvatarInEditor(this.var_2994, this.var_2938, this.var_2438.clubMemberLevel);
                    };
                    return;
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

        public function get view():IWindowContainer
        {
            return (this._view);
        }

        public function avatarImageReady(param1:String):void
        {
            this.updateView();
        }


    }
}