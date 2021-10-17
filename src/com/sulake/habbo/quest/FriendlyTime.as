package com.sulake.habbo.quest
{
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class FriendlyTime 
    {

        private static const var_2509:int = 60;
        private static const var_2510:int = (60 * 60);//3600
        private static const var_2512:int = (3 * var_2509);//180
        private static const var_2511:int = (3 * var_2510);//10800


        public static function getFriendlyTime(param1:IHabboLocalizationManager, param2:int):String
        {
            if (param2 > var_2511)
            {
                return (getLocalization(param1, "friendlytime.hours", Math.round((param2 / var_2510))));
            };
            if (param2 > var_2512)
            {
                return (getLocalization(param1, "friendlytime.minutes", Math.round((param2 / var_2509))));
            };
            return (getLocalization(param1, "friendlytime.seconds", Math.round(param2)));
        }

        public static function getLocalization(param1:IHabboLocalizationManager, param2:String, param3:int):String
        {
            param1.registerParameter(param2, "amount", ("" + param3));
            return (param1.getKey(param2, param2));
        }


    }
}