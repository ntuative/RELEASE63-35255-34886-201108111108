package com.sulake.habbo.avatar.torso
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class TorsoModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function TorsoModel(param1:HabboAvatarEditor)
        {
            super(param1);
        }

        override protected function init():void
        {
            super.init();
            initCategory(FigureData.var_2366);
            initCategory(FigureData.var_2367);
            initCategory(FigureData.var_2368);
            initCategory(FigureData.CHEST_PRINTS);
            _isInitialized = true;
            if (!_view)
            {
                _view = new TorsoView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view)
                {
                    _view.init();
                };
            };
        }


    }
}