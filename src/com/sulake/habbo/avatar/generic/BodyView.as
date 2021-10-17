package com.sulake.habbo.avatar.generic
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.common.AvatarEditorGridView;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BodyView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        private const var_2941:String = "tab_boy";
        private const var_2942:String = "tab_girl";

        public function BodyView(param1:IAvatarEditorCategoryModel, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param2, param3, param1);
            var_2534 = FigureData.var_1850;
        }

        override public function reset():void
        {
            super.reset();
            var_2534 = FigureData.var_1850;
        }

        override public function init():void
        {
            var _loc1_:XmlAsset;
            var _loc2_:AvatarEditorGridView;
            if (!_window)
            {
                _loc1_ = (_assetLibrary.getAssetByName("avatareditor_generic_base") as XmlAsset);
                if (_loc1_)
                {
                    _window = IWindowContainer(_windowManager.buildFromXML((_loc1_.content as XML)));
                    _window.visible = false;
                    _window.procedure = this.windowEventProc;
                };
            };
            if (!var_2532)
            {
                var_2532 = new Dictionary();
                var_2532[FigureData.var_1850] = new AvatarEditorGridView(var_2533, FigureData.var_1850, _windowManager, _assetLibrary);
            }
            else
            {
                for each (_loc2_ in var_2532)
                {
                    _loc2_.initFromList();
                };
            };
            _isInitialized = true;
            updateGridView();
            attachImages();
            this.updateGenderTab();
        }

        override public function getWindowContainer():IWindowContainer
        {
            if (!_isInitialized)
            {
                this.init();
            };
            this.updateGenderTab();
            return (_window);
        }

        public function updateGenderTab():void
        {
            if (var_2533 == null)
            {
                return;
            };
            switch (var_2533.controller.gender)
            {
                case FigureData.var_1672:
                    activateTab(this.var_2941);
                    inactivateTab(this.var_2942);
                    return;
                case FigureData.FEMALE:
                    activateTab(this.var_2942);
                    inactivateTab(this.var_2941);
                    return;
            };
        }

        public function switchCategory(param1:String):void
        {
            this.updateGenderTab();
        }

        private function windowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case this.var_2941:
                        var_2533.controller.gender = FigureData.var_1672;
                        param1.stopPropagation();
                        break;
                    case this.var_2942:
                        var_2533.controller.gender = FigureData.FEMALE;
                        param1.stopPropagation();
                        break;
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    switch (param2.name)
                    {
                        case this.var_2941:
                        case this.var_2942:
                            activateTab(param2.name);
                            break;
                    };
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_624)
                    {
                        switch (param2.name)
                        {
                            case this.var_2941:
                            case this.var_2942:
                                this.updateGenderTab();
                                return;
                        };
                    };
                };
            };
        }


    }
}