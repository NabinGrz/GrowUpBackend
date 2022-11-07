using Growup.Data;
using Growup.DTOs;
using Growup.Models;
using Growup.repository;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Growup.Controllers
{
    [ApiController]
    
    public class MainController : ControllerBase
    {
        private readonly IWebHostEnvironment _webHostEnvironment;
        private IConfiguration _configuration;
        private IMainRepository _repo;
        private GrowupDbContext _db;
        public MainController(IWebHostEnvironment webHostEnvironment, IMainRepository repo,IConfiguration configuration)
        {
            _webHostEnvironment = webHostEnvironment;
            _repo = repo;
            _configuration = configuration;
        }
        [HttpPost("/api/v1/addschedule")]
        public IActionResult AddSchedule([FromBody] Schedule model)
        {
            if (ModelState.IsValid)
            {
                var result = _repo.SaveSchedule(model);
                return Ok(result);

            }
            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }

        [HttpGet("/api/v1/get_all_schedule")]
        [Authorize]
        public IActionResult GetAllSchedule()
        {
            try
            {
                var schedule = _repo.GetSchedule();
                return Ok(schedule);
            }
            catch (Exception)
            {

                return BadRequest(
                    new UserResponse()
                    {
                        Message = "Something went wrong!"
                    }
                );
            }
        }
        [HttpGet("/api/v1/get_teacher_schedule")]
        [Authorize]
        public IActionResult GetScheduleOfTeacher(string id)
        {
            try
            {
                var schedule = _repo.GetScheduleOfTeacher(id);
                return Ok(schedule);
            }
            catch (Exception)
            {

                return BadRequest(
                    new UserResponse()
                    {
                        Message = "Something went wrong!"
                    }
                );
            }
        }

      
        [HttpPost("/api/v1/addnewsfeed")]
        [Authorize]
        public IActionResult AddNewsFeed([FromForm]NewsFeed model)
        {
            if (ModelState.IsValid)
            {
                if(model.Image != null)
                {
                    string folder = "Media/Images/";
                    folder += Guid.NewGuid().ToString() + model.Image.FileName;
                    string serverFolder = Path.Combine(_webHostEnvironment.WebRootPath, folder);
                    model.Image.CopyTo(new FileStream(serverFolder, FileMode.Create));
                    model.ApplicationUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
                    model.ImageUrl = _configuration["AppUrl"] +"/"+folder;
                    var result = _repo.SaveNewsFeed(model);
                    if (result.IsSuccess)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return BadRequest(result);
                    }
                }

                
            }
            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }

        [HttpGet("/api/v1/get_single_newsfeed")]
        [Authorize]
        public IActionResult GetSingleNewsFeed(int id)
        {
            try
            {
                var newsFeed = _repo.GetSingleNewsFeed(id);
                return Ok(newsFeed);
            }
            catch (Exception)
            {

                return BadRequest(
                    new UserResponse()
                    {
                        Message = "Something went wrong!"
                    }
                );
            }
        }

        [HttpGet("/api/v1/get_all_newsfeed")]
        [Authorize]
        public IActionResult GetAllNewsFeed()
        {
            try
            {
                var newsFeeds = _repo.GetNewsFeed();
                return Ok(newsFeeds);
            }
            catch (Exception)
            {

                return BadRequest(
                    new UserResponse()
                    {
                        Message = "Something went wrong!"
                    }
                );
            }
        }

        [HttpGet("/api/v1/get_all_newsfeed_of_user")]
        [Authorize]
        public IActionResult GetAllUsersNewsFeed()
        {
            try
            {
                var userId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
                var newsFeeds = _repo.GetNewsFeedOfUser(userId);
                return Ok(newsFeeds);
            }
            catch (Exception)
            {

                return BadRequest(
                    new UserResponse()
                    {
                        Message = "Something went wrong!"
                    }
                );
            }
        }

        [HttpDelete("/api/v1/newsfeed/")]
        [Authorize]
        public IActionResult DeleteNewsFeed(int id)
        {
            try
            {
                _repo.DeleteNewsFeed(id);
                return Ok();
            }
            catch (Exception)
            {

                return BadRequest(new UserResponse() { Message = "Cannot Delete Newsfeed" });
            }
        }
        //BOOKING DELETE FOR TEACHER
        [HttpDelete("/api/v1/deleteBooking")]
        [Authorize]
        public IActionResult DeleteBooking(int id)
        {
            try
            {
                _repo.DeleteBookings(id);
                return Ok();
            }
            catch (Exception)
            {

                return BadRequest(new UserResponse() { Message = "Cannot Delete Bookings" });
            }
        }
        //SCHEDULE DELETE
        [HttpDelete("/api/v1/deleteSchedule")]
        [Authorize]
        public IActionResult DeleteSchedule(int id)
        {
            try
            {
                _repo.DeleteSchedule(id);
                return Ok();
            }
            catch (Exception)
            {

                return BadRequest(new UserResponse() { Message = "Cannot Delete Schedule" });
            }
        }
        [HttpPut("/api/v1/newsfeed")]
        [Authorize]
        public IActionResult UpdateNewsFeed([FromBody]NewsFeed model)
        {
            if (ModelState.IsValid)
            {
                if (model.Image != null)
                {
                    string folder = "Media/Images/";
                    folder += Guid.NewGuid().ToString() + model.Image.FileName;
                    string serverFolder = Path.Combine(_webHostEnvironment.WebRootPath, folder);
                    model.Image.CopyTo(new FileStream(serverFolder, FileMode.Create));
                    model.ApplicationUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
                    model.ImageUrl = _configuration["AppUrl"] + "/" + folder;
                    var result = _repo.UpdateNewsFeed(model);
                    if (result.IsSuccess)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return BadRequest(result);
                    }
                }


            }
            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }

        [HttpPost("/api/v1/addcomment")]
        [Authorize]
        public IActionResult AddComment([FromBody]Comment comment)
        {
            if (ModelState.IsValid)
            {
                var result = _repo.SaveComment(comment);
                return Ok(result);
                
            }
            return BadRequest(new UserResponse() { Message = "Some properties are mising" });
        }

        [HttpPost("api/v1/updatecomment")]
        [Authorize]
        public IActionResult UpdateComment([FromBody]Comment comment)
        {
            if (ModelState.IsValid)
            {
                var result = _repo.UpdateComment(comment);
                return Ok(result);

            }
            return BadRequest(new UserResponse() { Message = "Some properties are mising" });
        }

        [HttpDelete("api/v1/comment")]
        [Authorize]
        public IActionResult DeleteComment(int id)
        {
            _repo.DeleteComment(id);
            return Ok();
        }

        [HttpGet("api/v1/get_comments_of_newsFeed")]
        [Authorize]
        public IActionResult GetAllCommentsOfNewsFeed(int id)
        {
            // id = news feed ko id
            var result = _repo.GetCommentsOfNewsFeed(id);
            return Ok(result);
        }

        [HttpGet("api/v1/get/comment")]
        [Authorize]
        public IActionResult GetSingleComment(int id)
        {
            // id = comment ko id
            var result = _repo.GetSingleComment(id);
            return Ok(result);
        }

        [HttpPost("/api/v1/Skill")]
        [Authorize]
        public IActionResult AddSkill([FromForm] Skill model)
        {
            if (ModelState.IsValid)
            {
                if (model.ImageFile != null)
                {
                    string folder = "Media/Images/";
                    folder += Guid.NewGuid().ToString() + model.ImageFile.FileName;
                    string serverFolder = Path.Combine(_webHostEnvironment.WebRootPath, folder);
                    model.ImageFile.CopyTo(new FileStream(serverFolder, FileMode.Create));
                   
                    model.TitleImage = _configuration["AppUrl"] + "/" + folder;
                    var result = _repo.SaveSkill(model);
                    if (result.IsSuccess)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return BadRequest(result);
                    }
                }
            }
            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }

        [HttpPut("/api/v1/Skill")]
        [Authorize]
        public IActionResult UpdateSkill([FromForm] Skill model)
        {
            if (ModelState.IsValid)
            {
                if (model.ImageFile != null)
                {
                    string folder = "Media/Images/";
                    folder += Guid.NewGuid().ToString() + model.ImageFile.FileName;
                    string serverFolder = Path.Combine(_webHostEnvironment.WebRootPath, folder);
                    model.ImageFile.CopyTo(new FileStream(serverFolder, FileMode.Create));

                    model.TitleImage = _configuration["AppUrl"] + "/" + folder;
                    var result = _repo.UpdateSkill(model);
                    if (result.IsSuccess)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return BadRequest(result);
                    }
                }
            }
            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }


        [HttpGet("/api/v1/getskills")]
        [Authorize]
        public IActionResult GetAllSkill()
        {
            return Ok(_repo.GetAllSkill());
        }

        [HttpGet("/api/v1/getsingleskill")]
        [Authorize]
        public IActionResult GetSingleSkill(int id)
        {
            return Ok(_repo.GetSingleSkill(id));
        }

        [HttpDelete("/api/v1/delete")]
        [Authorize]
        public IActionResult DeleteSkill(int id)
        {
            _repo.DeleteSkill(id);
            return Ok();
        }


        [HttpPost("/api/v1/video")]
        [Authorize]
        [RequestSizeLimit(637280000)]
        public IActionResult AddVideo([FromForm] Videos model)
        {
            if (model.Video != null)
            {
                string folder = "Media/Videos/";
                folder += Guid.NewGuid().ToString() + model.Video.FileName;
                string serverFolder = Path.Combine(_webHostEnvironment.WebRootPath, folder);
                model.Video.CopyTo(new FileStream(serverFolder, FileMode.Create));

                model.VideoUrl = _configuration["AppUrl"] + "/" + folder;
                var result = _repo.AddVideo(model);
                if (result.IsSuccess)
                {
                    return Ok(result);
                }
                else
                {
                    return BadRequest(result);
                }
            }

            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }


        [HttpPut("/api/v1/video")]
        [Authorize]
        [RequestSizeLimit(637280000)]
        public IActionResult UpdateVideo([FromForm] Videos model)
        {
            if (model.Video != null)
            {
                string folder = "Media/Videos/";
                folder += Guid.NewGuid().ToString() + model.Video.FileName;
                string serverFolder = Path.Combine(_webHostEnvironment.WebRootPath, folder);
                model.Video.CopyTo(new FileStream(serverFolder, FileMode.Create));

                model.VideoUrl = _configuration["AppUrl"] + "/" + folder;
                var result = _repo.UpdateVideo(model);
                if (result.IsSuccess)
                {
                    return Ok(result);
                }
                else
                {
                    return BadRequest(result);
                }
            }

            return BadRequest(new UserResponse()
            {
                Message = "Some Properties are missing",
                IsSuccess = false,
            });
        }

        [HttpDelete("/api/v1/video")]
        [Authorize]
        public IActionResult DeleteVideo(int id)
        {
            _repo.DeleteVideo(id);
            return Ok();
        }

        [HttpGet("/api/v1/allvideosofskill")]
        [Authorize]
        public IActionResult GetAllVideoOfSkill(int id)
        {
            return Ok(_repo.GetVidoesOfSkill(id));
        }

        [HttpPost("/api/v1/AddVideoRating")]
        [Authorize]
        public IActionResult SaveVideoRating([FromBody] VideoRating model)
        {
            model.ApplicationUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            if (ModelState.IsValid)
            {
                var result = _repo.SaveVideoRating(model);
                
                return Ok(result);
            }
            else
            {
               return BadRequest("Some properties are missing");
            }
        }

        [HttpGet("/api/v1/GetAverageVideoRating")]
        [Authorize]
        public IActionResult GetAverageVideoRating(int videoId)
        {
            var average = _repo.GetAverageVideoRating(videoId);
            return Ok(new { average = average });
        }


        [HttpPost("/api/v1/AddTeacherRating")]
        [Authorize]
        public IActionResult SaveTeacherRating([FromBody] TeacherRating model)
        {
            model.StudentId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            if (ModelState.IsValid)
            {
                var result = _repo.SaveTeacherRating(model);

                return Ok(result);
            }
            else
            {
                return BadRequest("Some properties are missing");
            }
        }

        [HttpGet("/api/v1/GetAverageTeacherRating")]
        [Authorize]
        public IActionResult GetAverageTeacherRating(string teacherId)
        {
            var average = _repo.GetAverageTeacherRating(teacherId);
            return Ok(new { average = average });
        }

        [HttpGet("/api/v1/category")]
        [Authorize]
        public IActionResult GetSingleSkillCategory(int id)
        {
            return Ok(_repo.GetSingleSkillCategory(id));
        }
        [HttpGet("/api/v1/allcategory")]
        [Authorize]
        public IActionResult GetAllCategory()
        {
            return Ok(_repo.GetAllCategory());
        }

        [HttpGet("/api/v1/categoryname")]
        [Authorize]
        public IActionResult GetCategoryName(int id)
        {
            return Ok(_repo.GetCategoryName(id));
        }
        [HttpPost("/api/v1/category")]
        [Authorize]
        public IActionResult AddSkillCategory([FromBody] SkillCategory model)
        {
            if (ModelState.IsValid)
            {
                _repo.AddSkillCategory(model);
                return Ok(new { msg = "category added successfully!" });
            }
            return BadRequest("Some properties are missing");
        }
        [HttpPut("/api/v1/category")]
        [Authorize]
        public IActionResult UpdateSkillCategory([FromBody] SkillCategory model)
        {
            if (ModelState.IsValid)
            {
                _repo.UpdateSkillCategory(model);
                return Ok(new { msg = "category updated successfully!" });
            }
            return BadRequest("Some properties are missing");
        }

        [HttpDelete("/api/v1/category")]
        [Authorize]
        public IActionResult DeleteCateogry(int id)
        {
            _repo.DeleteSkillCategories(id);
            return Ok(new { msg = "Ok Deleted" });
        }

        [HttpGet("/api/v1/categorylist")]
        [Authorize]
        public IActionResult GetAllCategoriesWithSkill()
        {
            return Ok(_repo.GetAllSkillCategoriesWithSkill());
        }

        [HttpGet("/api/v1/video/count")]
        [Authorize]
        public IActionResult GetVideoCountOfSkill(int id)
        {
            return Ok(_repo.VidoesCountInSkill(id));
        }


        [HttpGet("/api/v1/video/rating/count")]
        [Authorize]
        public IActionResult GetVideoRatingCount(int id)
        {
            return Ok(_repo.CountVideoRating(id));
        }

        [HttpGet("/api/v1/teacher/rating/count")]
        [Authorize]
        public IActionResult GetTeacherRatingCount(string id)
        {
            return Ok(_repo.CountTeacherRating(id));
        }


        [HttpPost("/api/v1/AddNewsFeedRating")]
        [Authorize]
        public IActionResult SaveNewsFeedRating([FromBody] NewsFeedRating model)
        {
            model.ApplicationUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            if (ModelState.IsValid)
            {
                var result = _repo.SaveNewsFeedRating(model);

                return Ok(result);
            }
            else
            {
                return BadRequest("Some properties are missing");
            }
        }

        [HttpGet("/api/v1/GetAverageNewsFeedRating")]
        [Authorize]
        public IActionResult GetAverageNewsFeedRating(int id)
        {
            var average = _repo.GetAverageNewsFeedRating(id);
            return Ok(new { average = average });
        }

        [HttpGet("/api/v1/newsfeed/rating/count")]
        [Authorize]
        public IActionResult GetNewsFeedRatingCount(int id) 
        {
            return Ok(_repo.CountNewsFeedRating(id));
        }

        [HttpPost("/api/v1/booking")]
        [Authorize]
        public IActionResult SaveBooking([FromBody] Booking booking)
        {
            booking.StudentId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            if (ModelState.IsValid)
            {
                _repo.SaveBooking(booking);
                return Ok(new { message = "Booking saved" });
            }
            return BadRequest(new { message = "Some properties are missing" });
        }

        [HttpGet("/api/v1/teacher/booking")]
        [Authorize]
        public IActionResult GetTeacherBooking(string id)
        {
            return Ok(_repo.GetBookingOfTeachers(id));
        }

        [HttpGet("/api/v1/students/booking")]
        [Authorize]
        public IActionResult GetStudentBooking(string id)
        {
            return Ok(_repo.GetStudentsBooking(id));
        }

        [HttpPost("/api/v1/question")]
        [Authorize]
        public IActionResult SaveQuestion([FromBody] Question model)
        {
            // skillId:int, QuestionText:string
            try
            {
                if (ModelState.IsValid)
                {
                    _repo.SaveQuestion(model);
                    return Ok(new { message = "Question Added Successfully" });
                }
                return BadRequest(new { message = "Some Properties are missing"});
            }
            catch (Exception)
            {

                return BadRequest(new { message = "Internal Server Error" });
            }
        }

        [HttpDelete("/api/v1/question")]
        [Authorize]
        public IActionResult DeleteQuestion(int id) //question Id
        {
            try
            {
                _repo.DeleteQuestion(id);
                return Ok(new { message = "Delete Question Successfull" });
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }

        [HttpPut("/api/v1/question")]
        [Authorize]
        public IActionResult UpdateQuestion([FromBody] Question question)//id, question text, skillid
        {
            
            try
            {
                if (ModelState.IsValid)
                {
                    _repo.UpdateQuestion(question);
                    return Ok();
                }
                return BadRequest(new { message = "Some Properties are missing" });
            }
            catch (Exception)
            {

                return BadRequest(new { message = "Internal Server Error" });
            }
        }

        [HttpGet("/api/v1/all/question")]
        [Authorize]
        public IActionResult AllQuestionOfSkill(int id) //skillId
        {
            return Ok(_repo.GetAllQuestionOfSkill(id));
        }

        [HttpGet("/api/v1/all/testquestion")]
        [Authorize]
        public IActionResult AllTestQuestions(int id) //skillId
        {
            return Ok(_repo.GetAllTestQuestion(id));
        }

        [HttpGet("/api/v1/all/questionall")]
        [Authorize]
        public IActionResult AllQuestionSkill() //skillId
        {
            return Ok(_repo.GetAllQuestion());
        }

        [HttpPost("/api/v1/option")]
        [Authorize]
        public IActionResult SaveOption([FromBody] Option model)
        {
            // skillId:int, QuestionText:string
            try
            {
                if (ModelState.IsValid)
                {
                    _repo.SaveOption(model);
                    return Ok(new { message = "Option Added Successfully" });
                }
                return BadRequest(new { message = "Some Properties are missing" });
            }
            catch (Exception)
            {

                return BadRequest(new { message = "Internal Server Error" });
            }
        }
        [HttpPost("/api/v1/save/testoption")]
        [Authorize]
        public IActionResult SaveTestOption([FromBody] TestOptions model)
        {
            // skillId:int, QuestionText:string
            try
            {
                if (ModelState.IsValid)
                {
                    _repo.SaveTestOption(model);
                    return Ok(new { message = "Option Added Successfully" });
                }
                return BadRequest(new { message = "Some Properties are missing" });
            }
            catch (Exception)
            {

                return BadRequest(new { message = "Internal Server Error" });
            }
        }
        [HttpGet("/api/v1/all/optionsall")]
        [Authorize]
        public IActionResult AllOptions() //skillId
        {
            return Ok(_repo.GetAllOptions());
        }

        [HttpDelete("/api/v1/option")]
        [Authorize]
        public IActionResult DeleteOption(int id) //option Id
        {
            try
            {
                _repo.DeleteOption(id);
                return Ok(new { message = "Delete Option Successfull" });
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }

        [HttpPut("/api/v1/option")]
        [Authorize]
        public IActionResult UpdateOption([FromBody] Option option)//id, option text, questionId
        {

            try
            {
                if (ModelState.IsValid)
                {
                    _repo.UpdateOption(option);
                    return Ok(new { message = "Updated Successfull" });
                }
                return BadRequest(new { message = "Some Properties are missing" });
            }
            catch (Exception)
            {

                return BadRequest(new { message = "Internal Server Error" });
            }
        }
        [HttpPut("/api/v1/updateSchedule")]
        [Authorize]
        public IActionResult Book(int id, [FromBody] Schedule schedule)//id, option text, questionId
        {
          
            try
            {
                if (ModelState.IsValid)
                {
                    _repo.Book(id, schedule);
                   return Ok();
                }
                return BadRequest(new { message = "some properties are missing" });
            }
            catch (Exception)
            {

                return BadRequest(new { message = "internal server error" });
            }
        }

        [HttpPost("/api/v1/save/exam")]
        [Authorize]
        public IActionResult SaveExamResult([FromBody]Exam exam)
        {
            try
            {
                _repo.SaveExamResult(exam);
                return Ok();
            }
            catch (Exception)
            {

                return BadRequest();
            }
        }

        [HttpPost("/api/v1/save/test")]
        [Authorize]
        public IActionResult SaveTest([FromBody] Test test)
        {
            try
            {
                _repo.SaveTest(test);
                return Ok();
            }
            catch (Exception)
            {

                return BadRequest();
            }
        }

        [HttpGet("/api/v1/getparticularexam")]
        [Authorize]
        public IActionResult GetExamHistoryOfStudent(int id) // id -> skillId
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier).Value; 
            return Ok(_repo.GetExamOfParticularSkill( id));
        }
        [HttpGet("/api/v1/all/getallexam")]
        [Authorize]
        public IActionResult AllExam() //skillId
        {
            return Ok(_repo.GetAllExam());
        }

        [HttpGet("/api/v1/all/getalltestofexam")]
        [Authorize]
        public IActionResult AllTestOfExam(int examID) //skillId
        {
            return Ok(_repo.GetAllTestOfExam(examID));
        }


        [HttpGet("/api/v1/video/count/skill")]
        [Authorize]
        public IActionResult GetVideoCountInSkill(int id)//skillId{
        {
            return Ok(new { count = _repo.GetVideoCountInSkill(id) });
        }
    }
}
