package com.sulake.habbo.avatar.head
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class HeadModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function HeadModel(param1:HabboAvatarEditor)
        {
            super(param1);
        }

        override protected function init():void
        {
            super.init();
            initCategory(FigureData.var_2361);
            initCategory(FigureData.var_2362);
            initCategory(FigureData.var_2363);
            initCategory(FigureData.var_2364);
            initCategory(FigureData.var_2365);
            _isInitialized = true;
            if (!_view)
            {
                _view = new HeadView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view)
                {
                    _view.init();
                };
            };
        }


    }
}