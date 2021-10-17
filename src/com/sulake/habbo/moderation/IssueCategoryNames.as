package com.sulake.habbo.moderation
{
    public class IssueCategoryNames 
    {


        public static function getCategoryName(param1:int):String
        {
            switch (param1)
            {
                case 0:
                    return ("Automatic");
                case 101:
                    return ("Sex");
                case 102:
                    return ("PII");
                case 103:
                    return ("Scam");
                case 104:
                    return ("Bullying");
                case 105:
                    return ("Disruption");
                case 106:
                    return ("Other");
                default:
                    return ("Unknown");
            };
        }


    }
}