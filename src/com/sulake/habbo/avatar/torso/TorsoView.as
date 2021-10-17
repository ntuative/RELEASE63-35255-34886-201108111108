package com.sulake.habbo.avatar.torso
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.common.AvatarEditorGridView;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class TorsoView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function TorsoView(param1:TorsoModel, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param2, param3, param1);
        }

        override public function init():void
        {
            var _loc1_:XmlAsset;
            var _loc2_:AvatarEditorGridView;
            if (!_window)
            {
                _loc1_ = (_assetLibrary.getAssetByName("avatareditor_torso_base") as XmlAsset);
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
                var_2532[FigureData.var_2366] = new AvatarEditorGridView(var_2533, FigureData.var_2366, _windowManager, _assetLibrary);
                var_2532[FigureData.var_2367] = new AvatarEditorGridView(var_2533, FigureData.var_2367, _windowManager, _assetLibrary);
                var_2532[FigureData.var_2368] = new AvatarEditorGridView(var_2533, FigureData.var_2368, _windowManager, _assetLibrary);
                var_2532[FigureData.CHEST_PRINTS] = new AvatarEditorGridView(var_2533, FigureData.CHEST_PRINTS, _windowManager, _assetLibrary);
            }
            else
            {
                for each (_loc2_ in var_2532)
                {
                    _loc2_.initFromList();
                };
            };
            _isInitialized = true;
            attachImages();
            if (((var_2533) && (var_2534 == "")))
            {
                var_2533.switchCategory(FigureData.var_2367);
            };
        }

        override public function dispose():void
        {
            super.dispose();
            var_2533 = null;
        }

        public function switchCategory(param1:String):void
        {
            if (_window == null)
            {
                return;
            };
            if (_window.disposed)
            {
                return;
            };
            if (var_2534 == param1)
            {
                return;
            };
            inactivateTab(var_2535);
            switch (param1)
            {
                case FigureData.var_2367:
                    var_2535 = "tab_shirt";
                    break;
                case FigureData.var_2366:
                    var_2535 = "tab_jacket";
                    break;
                case FigureData.CHEST_PRINTS:
                    var_2535 = "tab_prints";
                    break;
                case FigureData.var_2368:
                    var_2535 = "tab_accessories";
                    break;
                default:
                    throw (new Error((('[TorsoView] Unknown item category: "' + param1) + '"')));
            };
            var_2534 = param1;
            activateTab(var_2535);
            if (!_isInitialized)
            {
                this.init();
            };
            updateGridView();
        }

        private function windowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "tab_jacket":
                        this.switchCategory(FigureData.var_2366);
                        break;
                    case "tab_shirt":
                        this.switchCategory(FigureData.var_2367);
                        break;
                    case "tab_accessories":
                        this.switchCategory(FigureData.var_2368);
                        break;
                    case "tab_prints":
                        this.switchCategory(FigureData.CHEST_PRINTS);
                        break;
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    switch (param2.name)
                    {
                        case "tab_jacket":
                        case "tab_prints":
                        case "tab_shirt":
                        case "tab_accessories":
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
                            case "tab_jacket":
                            case "tab_prints":
                            case "tab_shirt":
                            case "tab_accessories":
                                if (var_2535 != param2.name)
                                {
                                    inactivateTab(param2.name);
                                };
                                return;
                        };
                    };
                };
            };
        }


    }
}