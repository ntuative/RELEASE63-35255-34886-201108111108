package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;

    public class PlaceholderView extends HelpViewController implements IHelpViewController 
    {

        public function PlaceholderView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
            param2.registerLocalizationParameter("info.client.version", "version", new String(201108111102));
        }

        override public function render():void
        {
            if (container != null)
            {
                container.dispose();
            };
            container = (buildXmlWindow("placeholder") as IWindowContainer);
            if (container == null)
            {
                return;
            };
            container.background = true;
            container.color = 0x1FFFFFF;
            super.render();
        }


    }
}