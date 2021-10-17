package com.sulake.habbo.avatar.legs
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class LegsModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function LegsModel(param1:HabboAvatarEditor)
        {
            super(param1);
        }

        override protected function init():void
        {
            super.init();
            initCategory(FigureData.var_2369);
            initCategory(FigureData.var_2370);
            initCategory(FigureData.var_2371);
            _isInitialized = true;
            if (!_view)
            {
                _view = new LegsView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view)
                {
                    _view.init();
                };
            };
        }


    }
}