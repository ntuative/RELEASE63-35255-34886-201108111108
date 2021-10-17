package com.sulake.habbo.avatar.generic
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.common.CategoryData;
    import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class BodyModel extends CategoryBaseModel implements IAvatarEditorCategoryModel, IAvatarImageListener 
    {

        private var var_2940:Boolean;

        public function BodyModel(param1:HabboAvatarEditor)
        {
            super(param1);
        }

        override protected function init():void
        {
            super.init();
            initCategory(FigureData.var_1850);
            _isInitialized = true;
            if (!_view)
            {
                _view = new BodyView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view)
                {
                    _view.init();
                };
            };
        }

        override public function switchCategory(param1:String):void
        {
        }

        override public function selectColor(param1:String, param2:int, param3:int):void
        {
            var _loc4_:CategoryData = var_534[param1];
            if (_loc4_ == null)
            {
                return;
            };
            _loc4_.selectColorIndex(param2, param3);
            var_2438.figureData.savePartSetColourId(param1, _loc4_.getSelectedColorIds(), true);
            this.updateSelectionsFromFigure(FigureData.var_1850);
        }

        override protected function updateSelectionsFromFigure(param1:String):void
        {
            var _loc5_:AvatarEditorGridPartItem;
            var _loc6_:String;
            var _loc7_:IAvatarImage;
            if (!var_534)
            {
                return;
            };
            var _loc2_:int = var_2438.figureData.getPartSetId(FigureData.var_1850);
            var _loc3_:Array = var_2438.figureData.getColourIds(FigureData.var_1850);
            var _loc4_:CategoryData = var_534[param1];
            if (_loc4_ == null)
            {
                return;
            };
            _loc4_.selectPartId(_loc2_);
            _loc4_.selectColorIds(_loc3_);
            for each (_loc5_ in _loc4_.parts)
            {
                _loc6_ = var_2438.figureData.getFigureStringWithFace(_loc5_.id);
                _loc7_ = var_2438.manager.avatarRenderManager.createAvatarImage(_loc6_, AvatarScaleType.var_128, null, this);
                _loc5_.iconImage = _loc7_.getCroppedImage(AvatarSetType.var_130);
                _loc7_.dispose();
            };
        }

        public function avatarImageReady(param1:String):void
        {
            if (!this.var_2940)
            {
                this.var_2940 = true;
                this.updateSelectionsFromFigure(FigureData.var_1850);
            };
        }


    }
}