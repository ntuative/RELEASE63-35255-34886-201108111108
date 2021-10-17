package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PurseCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function PurseCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function init():Boolean
        {
            var _loc2_:String;
            var _loc3_:ITextWindow;
            var _loc4_:ITextWindow;
            var _loc5_:ITextWindow;
            var _loc6_:IButtonWindow;
            if (!super.init())
            {
                return (false);
            };
            var _loc1_:Array = ["vouchers_btn", "coins_btn"];
            for each (_loc2_ in _loc1_)
            {
                _loc6_ = (_window.findChildByName(_loc2_) as IButtonWindow);
                if (_loc6_ != null)
                {
                    _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                };
            };
            _loc3_ = (_window.findChildByName("purse_info_tickets") as ITextWindow);
            _loc4_ = (_window.findChildByName("purse_info_film") as ITextWindow);
            _loc5_ = (_window.findChildByName("purse_amount") as ITextWindow);
            _loc5_.text = page.viewer.catalog.getPurse().credits.toString();
            return (true);
        }

        private function onMouseClick(event:WindowMouseEvent):void
        {
            var element:IWindow = (event.target as IWindow);
            var id:String = element.name;
            switch (id)
            {
                case "vouchers_btn":
                    page.viewer.catalog.windowManager.alert("Purse Voucher", "Vouchers clicked", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
                case "coins_btn":
                    page.viewer.catalog.windowManager.alert("Purse Credits", "Credits clicked", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
                default:
                    Logger.log("PurseCatalogWidget: unknonwn button");
            };
        }


    }
}