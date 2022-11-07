using Growup.DTOs;
using Growup.Models;
using System.Collections.Generic;

namespace Growup.repository
{
    public interface IMainRepository
    {
        // NewsFeed Methods
        UserResponse SaveNewsFeed(NewsFeed model);
        UserResponse SaveSchedule(Schedule model);
        NewsFeed GetSingleNewsFeed(int id);
        List<NewsFeed> GetNewsFeed();
        List<Schedule> GetSchedule();
        List<Schedule> GetScheduleOfTeacher(string id);
        List<NewsFeed> GetNewsFeedOfUser(string userId);
        void DeleteNewsFeed(int id);
        void DeleteBookings(int id);
        void DeleteSchedule(int id);
        UserResponse UpdateNewsFeed(NewsFeed model);

        //comment
        UserResponse SaveComment(Comment comment);
        UserResponse UpdateComment(Comment comment);
        void DeleteComment(int id);
        List<Comment> GetCommentsOfNewsFeed(int id);
        Comment GetSingleComment(int id);
        
        //Skill
        UserResponse SaveSkill(Skill model);
        public UserResponse UpdateSkill(Skill model);

        public List<Skill> GetAllSkill();

        public Skill GetSingleSkill(int id);
        public void DeleteSkill(int id);


        //videos
        UserResponse AddVideo(Videos model);
        UserResponse UpdateVideo(Videos model);
        void DeleteVideo(int id);
        List<Videos> GetVidoesOfSkill(int id);

        UserResponse SaveVideoRating(VideoRating videoRating);
        float GetAverageVideoRating(int videoId);

        UserResponse SaveTeacherRating(TeacherRating teacherRating);
        float GetAverageTeacherRating(string teacherId);
        int CountVideoRating(int videoRatingId);
        int CountTeacherRating(string teacherId);

        //skill Categories
        void AddSkillCategory(SkillCategory model);
        void UpdateSkillCategory(SkillCategory model);
        SkillCategory GetSingleSkillCategory(int id);
        List<SkillCategory> GetAllCategory();
        List<SkillCategory> GetCategoryName(int id);
        List<SkillCategory> GetAllSkillCategoriesWithSkill();
        void DeleteSkillCategories(int id);
        int VidoesCountInSkill(int id);
        int VideosCountOfSingleSkill(int sid);

        public int CountNewsFeedRating(int newsFeedId);
        public float GetAverageNewsFeedRating(int newsFeedId);
        public UserResponse SaveNewsFeedRating(NewsFeedRating newsFeedRating);
        public void SaveBooking(Booking booking);
        List<Booking> GetStudentsBooking(string studentId);
        List<Booking> GetBookingOfTeachers(string teacherId);

        //Exam
        void SaveQuestion(Question model);
        void SaveTest(Test test);
        void UpdateQuestion(Question model);
        void DeleteQuestion(int id);
        List<Question> GetAllQuestionOfSkill(int id);
        List<Test> GetAllTestQuestion(int id);
        List<Question> GetAllQuestion();
        List<Exam> GetAllExam();
        List<Test> GetAllTestOfExam(int examID);
        List<Option> GetAllOptions();
        void SaveOption(Option option);
        void SaveTestOption(TestOptions option);
        void UpdateOption(Option option);
        void Book(int id, Schedule schedule);
        void DeleteOption(int id);
        void SaveExamResult(Exam exam);
        List<Exam> GetExamOfParticularSkill( int skillId);
        int GetVideoCountInSkill(int skillId);
    }
}