using Growup.Data;
using Growup.DTOs;
using Growup.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.repository
{
    public class MainRepository : IMainRepository
    {
        public GrowupDbContext _db;
        public MainRepository(GrowupDbContext db)
        {
            _db = db;
        }
        public List<Schedule> GetSchedule()
        {
            return _db.Schedule.ToList();
        }
        public List<Schedule> GetScheduleOfTeacher(string id)
        {
            return _db.Schedule.Where(m => m.ApplicationUserId == id).ToList();
        }
        public UserResponse SaveSchedule(Schedule model)
        {
            try
            {
                _db.Schedule.Add(model);
                _db.SaveChanges();
                return new UserResponse
                {
                    Message = "Schedule saved successfully!",
                    IsSuccess = true
                };
            }
            catch (Exception e)
            {
                return new UserResponse
                {
                    Message = "Error occured while saving schedule",
                    IsSuccess = false
                };
            }
        }
        // saves the news feed with image
        public UserResponse SaveNewsFeed(NewsFeed model)
        {
            try
            {
                _db.NewsFeeds.Add(model);
                _db.SaveChanges();
                return new UserResponse
                {
                    Message = "NewsFeed saved successfully!",
                    IsSuccess = true
                };
            }
            catch (Exception e)
            {
                return new UserResponse
                {
                    Message = "Error occured while saving newsfeed",
                    IsSuccess = false
                };
            }

        }

        //returns single news feed
        public NewsFeed GetSingleNewsFeed(int id)
        {
            return _db.NewsFeeds.Include("ApplicationUser").Include("NewsFeedRatings").SingleOrDefault(m => m.Id == id);
        }

        //return list of news feed
        public List<NewsFeed> GetNewsFeed()
        {
            return _db.NewsFeeds.ToList();
        }

        //return list of news feed of a particular users
        public List<NewsFeed> GetNewsFeedOfUser(string userId)
        {
            return _db.NewsFeeds.Where(m => m.ApplicationUserId == userId).ToList();
        }

        //delete news feed
        public void DeleteNewsFeed(int id)
        {
            var newsFeedInDb = _db.NewsFeeds.SingleOrDefault(m => m.Id == id);
             _db.NewsFeeds.Remove(newsFeedInDb);
        }

        //delete booking for teacher
        public void DeleteBookings(int id)
        {
            var bookings = _db.Bookings.SingleOrDefault(m => m.Id == id);
            _db.Bookings.Remove(bookings);
            _db.SaveChanges();
        }

        //delete schedule
        public void DeleteSchedule(int id)
        {
            var schedule = _db.Schedule.SingleOrDefault(m => m.Id == id);
            _db.Schedule.Remove(schedule);
            _db.SaveChanges();
        }
        //update news feed
        public UserResponse UpdateNewsFeed(NewsFeed model)
        {
            try
            {
                var newsFeedInDb = _db.NewsFeeds.SingleOrDefault(m => m.Id == model.Id);
                newsFeedInDb.Title = model.Title;
                newsFeedInDb.ImageUrl = model.ImageUrl;
                _db.SaveChanges();
                return new UserResponse
                {
                    Message = "NewsFeed Updated successfully!",
                    IsSuccess = true
                };
            }
            catch (Exception)
            {

                return new UserResponse
                {
                    Message = "NewsFeed not saved successfully!",
                    IsSuccess = true
                };
            }
            
        }


        public UserResponse SaveComment(Comment comment)
        {
            try
            {
                _db.Comments.Add(comment);
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Comment add successfull!"
                };
            }
            catch (Exception)
            {

                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Something went wrong"
                };
            }
            
        }

        public UserResponse UpdateComment(Comment comment)
        {
            try
            {
                var commentInDb = _db.Comments.SingleOrDefault(m => m.Id == comment.Id);
                commentInDb.Description = comment.Description;
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Comment Added Successfully!"
                };
            }
            catch (Exception)
            {

                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Something went wrong"
                };
            }

        }

        public void DeleteComment(int id)
        {
            var commentInDb = _db.Comments.SingleOrDefault(m => m.Id == id);
            _db.Comments.Remove(commentInDb);
            _db.SaveChanges();
        }

        public List<Comment> GetCommentsOfNewsFeed(int id)
        {
            return _db.Comments.Where(m => m.NewsFeedId == id).ToList();
        }

        public Comment GetSingleComment(int id)
        {
            return _db.Comments.Include("ApplicationUser").SingleOrDefault(m => m.Id == id);
        }

        public UserResponse SaveSkill(Skill model)
        {
            try
            {
                _db.Skills.Add(model);
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Skill created succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }


        public UserResponse UpdateSkill(Skill model)
        {
            try
            {
                var skillInDb = _db.Skills.SingleOrDefault(m => m.Id == model.Id);
                skillInDb.Title = model.Title;
                skillInDb.TitleImage = model.TitleImage;
                skillInDb.SkillCategoryId = model.SkillCategoryId;
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Skill update succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }

        public List<Skill> GetAllSkill()
        {
            return _db.Skills.ToList();
        }

        public Skill GetSingleSkill(int id)
        {
            return _db.Skills.Include("Videos").SingleOrDefault(m => m.Id == id);
        }

        public void DeleteSkill(int id)
        {
            var skillInDb = _db.Skills.SingleOrDefault(m => m.Id == id);
            _db.Skills.Remove(skillInDb);
            _db.SaveChanges();
        }

        public UserResponse AddVideo(Videos model)
        {
            try
            {
                _db.Videos.Add(model);
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Video added succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }

        public UserResponse UpdateVideo(Videos model)
        {
            try
            {
                var videoInDb = _db.Videos.SingleOrDefault(m => m.Id == model.Id);
                videoInDb.Rating = model.Rating;
                videoInDb.VideoUrl = model.VideoUrl;
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Video Updated succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }

        public void DeleteVideo(int id)
        {
            var video = _db.Videos.SingleOrDefault(m => m.Id == id);
            _db.Videos.Remove(video);
            _db.SaveChanges();

        }

        public List<Videos> GetVidoesOfSkill(int id)
        {
            return _db.Videos.Where(m => m.SkillId == id).ToList();
        }
        
        public UserResponse SaveVideoRating(VideoRating videoRating)
        {
            try
            {
                var videoRatingInDb = _db.VideoRatings
                    .SingleOrDefault(m => m.ApplicationUserId == videoRating.ApplicationUserId && m.VideoId == videoRating.VideoId);
                if(videoRatingInDb == null)
                {
                    _db.VideoRatings.Add(videoRating);
                    _db.SaveChanges();
                }
                else
                {
                    videoRatingInDb.Rating = videoRating.Rating;
                    _db.SaveChanges();
                }
                return new UserResponse()
                {
                    Message = "Video rating Saved Successfully",
                    IsSuccess = true
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    Message = "Something went wrong",
                    IsSuccess = false
                };
            }
        }
        

        public float GetAverageVideoRating(int videoId)
        {
            try
            {
                var ratingOfVideo = _db.VideoRatings.Where(m => m.VideoId == videoId);
                var average = ratingOfVideo.Average(m => m.Rating);
                return average;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public UserResponse SaveTeacherRating(TeacherRating teacherRating)
        {
            try
            {
                var teacherRatingInDb = _db.TeacherRating
                    .SingleOrDefault(m => m.StudentId == teacherRating.StudentId && m.TeacherId == teacherRating.TeacherId);
                if (teacherRatingInDb == null)
                {
                    _db.TeacherRating.Add(teacherRating);
                    _db.SaveChanges();
                }
                else
                {
                    teacherRatingInDb.Rating = teacherRating.Rating;
                    _db.SaveChanges();
                }
                return new UserResponse()
                {
                    Message = "Teacher Saved Successfully",
                    IsSuccess = true
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    Message = "Something went wrong",
                    IsSuccess = false
                };
            }
        }


        public float GetAverageTeacherRating(string teacherId)
        {
            var ratingOfTeacher = _db.TeacherRating.Where(m => m.TeacherId == teacherId);
            var average = ratingOfTeacher.Average(m => m.Rating);
            return average;
        }


        public int CountTeacherRating(string teacherId)
        {
            var teacherRatingCount = _db.TeacherRating.Where(m => m.TeacherId == teacherId).Count();
            return teacherRatingCount;
        }

        public int CountVideoRating(int videoId)
        {
            var videoRatingCount = _db.VideoRatings.Where(m => m.VideoId == videoId).Count();
            return videoRatingCount;
        }

        public void AddSkillCategory(SkillCategory model)
        {
            _db.SkillCateogries.Add(model);
            _db.SaveChanges();
        }

        public void UpdateSkillCategory(SkillCategory model)
        {
            var categoryInDb = _db.SkillCateogries.SingleOrDefault(m => m.Id == model.Id);
            categoryInDb.Name = model.Name;
            _db.SaveChanges();
        }

        public SkillCategory GetSingleSkillCategory(int id)
        {
            return _db.SkillCateogries.SingleOrDefault(m => m.Id == id);
        }

        public List<SkillCategory> GetAllSkillCategoriesWithSkill()
        {
            return _db.SkillCateogries.Include("Skills").ToList();
        }

        public void DeleteSkillCategories(int id)
        {
            var category = _db.SkillCateogries.SingleOrDefault(m => m.Id == id);
            _db.SkillCateogries.Remove(category);
            _db.SaveChanges();
        }

        public int VidoesCountInSkill(int id)
        {
            return _db.Videos.Where(m => m.SkillId == id).Count();
        }
        public int GetVideoCountInSkill(int skillId)
        {
            return _db.Videos.Where(m => m.SkillId == skillId).Count();
        }


        public UserResponse SaveNewsFeedRating(NewsFeedRating newsFeedRating)
        {
            try
            {
                var newsFeedRatingInDb = _db.newsFeedRatings
                    .SingleOrDefault(m => m.ApplicationUserId == newsFeedRating.ApplicationUserId && m.NewsFeedId == newsFeedRating.NewsFeedId);
                if (newsFeedRatingInDb == null)
                {
                    _db.newsFeedRatings.Add(newsFeedRating);
                    _db.SaveChanges();
                }
                else
                {
                    newsFeedRatingInDb.Rating = newsFeedRating.Rating;
                    _db.SaveChanges();
                }
                return new UserResponse()
                {
                    Message = "NewsFeedRating Saved Successfully",
                    IsSuccess = true
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    Message = "Something went wrong",
                    IsSuccess = false
                };
            }
        }


        public float GetAverageNewsFeedRating(int newsFeedId)
        {
            var ratingOfNewsFeed= _db.newsFeedRatings.Where(m => m.NewsFeedId == newsFeedId);
            var average = ratingOfNewsFeed.Average(m => m.Rating);
            return average;
        }

        public int CountNewsFeedRating(int newsFeedId)
        {
            var newsFeedRatingCount = _db.newsFeedRatings.Where(m => m.NewsFeedId == newsFeedId).Count();
            return newsFeedRatingCount;
        }

        public void SaveBooking (Booking booking)
        {
            _db.Bookings.Add(booking);
            _db.SaveChanges();
        }

        public List<Booking> GetBookingOfTeachers (string teacherId)
        {
            return _db.Bookings.OrderByDescending(m => m.BookingDateTime)
                .Where(m => m.TeacherId == teacherId)
                .ToList();
        }

        public List<Booking> GetStudentsBooking(string studentId)
        {
            return _db.Bookings.Where(m => m.StudentId == studentId)
                .OrderByDescending(m => m.BookingDateTime).ToList();
        }


        public void SaveQuestion(Question model)
        {
            _db.Questions.Add(model);
            _db.SaveChanges();
        }

        public void SaveTest(Test test)
        {
            _db.Test.Add(test);
            _db.SaveChanges();
        }
        public void DeleteQuestion(int id)
        {
            var question = _db.Questions.SingleOrDefault(m => m.Id == id);
            _db.Questions.Remove(question);
            _db.SaveChanges();
        }

        public void UpdateQuestion(Question model)
        {
            var question = _db.Questions.SingleOrDefault(m => m.Id == model.Id);
            question.Text = model.Text;
            question.SkillId = model.SkillId;
            _db.SaveChanges();
        }

        public List<Question> GetAllQuestionOfSkill(int id)
        {
            return _db.Questions.Include("Options").Where(m => m.SkillId == id).ToList();
        }

        public void SaveOption(Option option)
        {
            _db.Options.Add(option);
            _db.SaveChanges();
        }
        public void SaveTestOption(TestOptions option)
        {
            _db.TestOptions.Add(option);
            _db.SaveChanges();
        }
        public void SaveExamResult(Exam exam)
        {
            _db.Exams.Add(exam);
            _db.SaveChanges();
        }

        public void UpdateOption(Option option)
        {
            var opt = _db.Options.SingleOrDefault(m => m.Id == option.Id);
            opt.IsCorrectOption = option.IsCorrectOption;
            opt.QuestionId = option.QuestionId;
            opt.Text = option.Text;
            _db.SaveChanges();
        }
        public void Book(int id, Schedule schedule)
        {
            var sch = _db.Schedule.FirstOrDefault(s => s.Id == id);
            sch.IsBooked = schedule.IsBooked;
            sch.ApplicationUserId = schedule.ApplicationUserId;
            sch.Time = schedule.Time;
            _db.SaveChanges();
        }
        public void DeleteOption(int id)
        {
            var opt = _db.Options.SingleOrDefault(m => m.Id == id);
            _db.Options.Remove(opt);
            _db.SaveChanges();
        }


        public List<Exam> GetExamOfParticularSkill( int id)
        {
            return _db.Exams.Where(m =>  m.Id == id).ToList();
        }



        public List<Question> GetAllQuestion()
        {
            return _db.Questions.ToList();
        }

        public List<Option> GetAllOptions()
        {
            return _db.Options.ToList();
        }

        List<Test> IMainRepository.GetAllTestQuestion(int id)
        {
            return _db.Test.Include("Options").Where(m => m.Id == id).ToList();
        }

        public List<Exam> GetAllExam()
        {
            return _db.Exams.ToList();
        }
        //public List<Question> GetAllQuestionOfSkill(int id)
        //{
        //    return _db.Questions.Include("Options").Where(m => m.SkillId == id).ToList();
        //}

        List<Test> IMainRepository.GetAllTestOfExam(int examID)
        {
            return _db.Test.Include("Options").Where(m => m.ExamID == examID).ToList();
        }

        public List<SkillCategory> GetAllCategory()
        {
            return _db.SkillCateogries.ToList();
        }

        public List<SkillCategory> GetCategoryName(int id)
        {
            return _db.SkillCateogries.Where(m => m.Id == id).ToList();
        }
        public int VideosCountOfSingleSkill(int sid)
        {
            throw new NotImplementedException();
        }


    }
}
