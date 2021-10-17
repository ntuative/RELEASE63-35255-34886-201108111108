package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboQuestEngine;
    import com.sulake.iid.IIDHabboQuestEngine;

    public class HabboQuestEngineCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboQuestEngineCom_manifest;
        public static var requiredClasses:Array = new Array(HabboQuestEngine, IIDHabboQuestEngine);
        public static const icon_quest_hidden:Class = HabboQuestEngineCom_icon_quest_hidden;
        public static const Campaign:Class = HabboQuestEngineCom_Campaign;
        public static const CampaignCompleted:Class = HabboQuestEngineCom_CampaignCompleted;
        public static const EntryArrows:Class = HabboQuestEngineCom_EntryArrows;
        public static const QuestEntry:Class = HabboQuestEngineCom_QuestEntry;
        public static const Quest:Class = HabboQuestEngineCom_Quest;
        public static const QuestDetails:Class = HabboQuestEngineCom_QuestDetails;
        public static const Quests:Class = HabboQuestEngineCom_Quests;
        public static const QuestTracker:Class = HabboQuestEngineCom_QuestTracker;
        public static const QuestCompletedDialog:Class = HabboQuestEngineCom_QuestCompletedDialog;
        public static const QuestHelp:Class = HabboQuestEngineCom_QuestHelp;
        public static const AchievementCategory:Class = HabboQuestEngineCom_AchievementCategory;
        public static const Achievements:Class = HabboQuestEngineCom_Achievements;
        public static const Achievement:Class = HabboQuestEngineCom_Achievement;
        public static const AchievementLevelUp:Class = HabboQuestEngineCom_AchievementLevelUp;
        public static const ProgressBar:Class = HabboQuestEngineCom_ProgressBar;
        public static const NextQuestTimer:Class = HabboQuestEngineCom_NextQuestTimer;


    }
}