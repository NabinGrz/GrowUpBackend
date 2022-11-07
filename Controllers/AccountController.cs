using Growup.Data;
using Growup.DTOs;
using Growup.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Growup.Controllers
{
    public class AccountController : ControllerBase
    {
        private IUserService _userService;
        private IMailService _mailService;
        private GrowupDbContext _db;
        public AccountController(IUserService userService,
                                 IMailService mailService,
                                 GrowupDbContext db)
        {
            _userService = userService;
            _mailService = mailService;
            _db = db;
        }

        // /api/account/register
        [HttpPost("/api/v1/account/register")]
        public async Task<IActionResult> RegisterAsync([FromBody] RegisterViewModel model)
        {

            if (ModelState.IsValid)
            {
                var result = await _userService.RegisterUserAsync(model);
                if (result.IsSuccess)
                {
                    return Ok(result);
                }
                return BadRequest(result);
            }
            return BadRequest("Some properties are not valid");//Status : 400
        }

        // /api/v1/account/login
        [HttpPost("/api/v1/account/login")]
        public async Task<IActionResult> LoginAsync([FromBody] LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var result = await _userService.LoginUserAsync(model);
                if (result.IsSuccess)
                {
                    await _mailService.SendEmailAsync(model.Email, "Login Notice", "<h1> Your account was loggedin</h1>");
                    return Ok(result);
                }
                else
                {
                }
            }
            return BadRequest("Some properties are not valid");
        }



        // /api/v1/account/confirmemail?userid&token
        [HttpGet("/api/v1/account/confirmEmail")]
        public async Task<IActionResult> ActionResult(string userId, string token)
        {
            if (string.IsNullOrWhiteSpace(userId) || string.IsNullOrWhiteSpace("token"))
            {
                return NotFound();
            }
            var result = await _userService.ConfirmEmailAsync(userId, token);
            if (result.IsSuccess)
            {
                return Ok(result);
            }
            return BadRequest(result);
        }

        // /api/v1/account/resetpassword
        [HttpPost("/api/v1/account/forgotpassword")]
        public async Task<IActionResult> ForgotPassword([FromBody] ResetPasswordViewModel email)
        {
            if (string.IsNullOrEmpty(email.Email))
            {
                return NotFound();
            }
            var result = await _userService.ForgotPasswordAsync(email.Email);
            if (result.IsSuccess)
            {
                return Ok(result);
            }
            return BadRequest(result);
        }

        // /api/v1/account/resetpassword?email&token
        [HttpPost("/api/v1/account/resetpassword")]
        public async Task<IActionResult> ResetPassword([FromForm] ResetPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var result = await _userService.ResetPasswordAsync(model);
                if (result.IsSuccess)
                {
                    return Ok(result);
                }
                return BadRequest(result);
            }
            return BadRequest("Some properties are missing");
        }


        [HttpPost("/api/v1/account/update/account")]
        [Authorize]
        public IActionResult UpdateAccount([FromBody] AccountUpdateVM model)
        {
            try
            {
                var userId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
                var userInDb = _db.Users.SingleOrDefault(m => m.Id == userId);
                userInDb.Email = model.Email;
                userInDb.PhoneNumber = model.PhoneNumber;
                _db.SaveChanges();
                return Ok(new { message = "Account Updated Successfully!" });
            }
            catch (Exception)
            {
                return BadRequest(new { message = "Internal server error" });
            }

        }

        [HttpPost("/api/v1/account/update/profile")]
        [Authorize]
        public IActionResult UpdateAccount([FromBody] UpdateProfileVM model)
        {
            try
            {
                var userId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
                var userInDb = _db.Users.SingleOrDefault(m => m.Id == userId);
                userInDb.Address = model.Address;
                userInDb.Gender = model.Gender;
                userInDb.FullName = model.FullName;
                _db.SaveChanges();
                return Ok(new { message = "Profile Updated Successfully!" });
            }
            catch (Exception)
            {
                return BadRequest(new { message = "Internal server error" });
            }
        }

        [HttpGet("/api/v1/account/user/detail")]
        [Authorize]
        public IActionResult GetUserDetail(string id)
        {
            try
            {
                var user = _db.Users.Single(m => m.Id == id);
                return Ok(user);
            }
            catch (Exception)
            {
                return BadRequest(new { msg = "User Not Found!" });
            }
        }

        [HttpGet("/api/v1/account/teachers")]
        [Authorize]
        public async Task<IActionResult> GetAllTeachers()
        {
            var teachers = await _userService.GetAllTeachersAsync();
            return Ok(teachers);
        }
        [HttpGet("/api/v1/account/students")]
        [Authorize]
        public async Task<IActionResult> GetAllStudents()
        {
            var students = await _userService.GetAllStudentsAsync();
            return Ok(students);
        }

        [HttpGet("/api/v1/user/id")]
        [Authorize]
        public IActionResult GetLoginUserId()
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            return Ok(new { UserId = userId });
        }
    }
}
