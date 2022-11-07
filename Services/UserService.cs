using Growup.DTOs;
using Growup.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace Growup.Services
{
    public class UserService : IUserService
    {
        private UserManager<ApplicationUser> _userManager;
        private IMailService _mailService;
        private IConfiguration _configuration;
        public UserService(UserManager<ApplicationUser> userManager, IConfiguration configuration, IMailService mailService)
        {
            _userManager = userManager;
            _configuration = configuration;
            _mailService = mailService;
        }
        public async Task<UserResponse> RegisterUserAsync(RegisterViewModel model)
        {
            if(model == null)
            {
                throw new NullReferenceException("Register Model Is Null!");
            }
            if(model.Password != model.ConfirmPassword)
            {
                return new UserResponse
                {
                    Message = "Confirm Password doesn't match the password",
                    IsSuccess = false,
                };
                
            }
            var user = new ApplicationUser()
            {
                Email = model.Email,
                UserName = model.Email,
                Gender = model.Gender,
                FullName = model.FullName,
                Address = model.Address,
            };

            var result = await _userManager.CreateAsync(user, model.Password);
            if (result.Succeeded)
            {

                switch (model.Role)
                {
                    case "Teacher":
                        await _userManager.AddToRoleAsync(user, "Teacher");
                        break;
                    case "Admin":
                        await _userManager.AddToRoleAsync(user, "Admin");
                        break;
                    default:
                        await _userManager.AddToRoleAsync(user, "Student");
                        break;
                }

                // TODO: Send Confirmation Email
                var confirmEmailToken = await _userManager.GenerateEmailConfirmationTokenAsync(user);
                var encodedEmailToken = Encoding.UTF8.GetBytes(confirmEmailToken);
                var validEmailToken = WebEncoders.Base64UrlEncode(encodedEmailToken);

                string url = $"{_configuration.GetValue<string>("AppUrl")}/api/v1/account/confirmemail?userid={user.Id}&token={validEmailToken}";
                await _mailService.SendEmailAsync(user.Email, "Confirm your mail", "<h4>Welcome to Growup</h4>" +
                    $"<p>Please confirm your email by <a href={url}>clicking here</a></p>");
                return new UserResponse
                {
                    Message = "User Created Successfully!",
                    IsSuccess = true
                };
            }
            return new UserResponse
            {
                Message = "User did not create",
                IsSuccess = false,
                Errors = result.Errors.Select(e => e.Description)
            };
        }


        public async Task<UserResponse> LoginUserAsync(LoginViewModel model)
        {
            var user = await _userManager.FindByEmailAsync(model.Email);
            var r = await _userManager.GetRolesAsync(user);
            if(user == null)
            {
                return new UserResponse {
                    Message = "User with this email not found!",
                    IsSuccess = false,
                    User = "",
                };
            }
            var result = await _userManager.CheckPasswordAsync(user, model.Password);
            if (!result)
            {
                return new UserResponse
                {
                    Message = "Invalid Username or Password",
                    IsSuccess = false,
                    User = "",
                };
            }

            // Generate Access Token
            var claims = new[]
            {
                new Claim("Email", model.Email),
                new Claim(ClaimTypes.NameIdentifier, user.Id),
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["AccountSettings:Key"]));

            var token = new JwtSecurityToken(
                issuer: _configuration["AccountSettings:Issuer"],
                audience: _configuration["AccountSettings:Audience"],
                claims: claims,
                expires: DateTime.Now.AddDays(30),
                signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256)
            ) ;

            string tokenAsString = new JwtSecurityTokenHandler().WriteToken(token);
           
            return new UserResponse
            {
                Message = tokenAsString,
                IsSuccess = true,
                ExpireDate = token.ValidTo,
                User = r[0].ToString(),
        };
        }


        public async Task<List<ApplicationUser>> GetAllTeachersAsync()
        {
            var teachers = await _userManager.GetUsersInRoleAsync("Teacher");
            return teachers.ToList();
        }

        public async Task<List<ApplicationUser>> GetAllStudentsAsync()
        {
            var students = await _userManager.GetUsersInRoleAsync("Student");
            return students.ToList();
        }
        public async Task<UserResponse> ConfirmEmailAsync(string userId, string token)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if(user == null)
            {
                return new UserResponse
                {
                    IsSuccess = false,
                    Message = "User not found"
                };   
            }
            var decodedToken = WebEncoders.Base64UrlDecode(token);
            var normalToken = Encoding.UTF8.GetString(decodedToken);
            var result = await _userManager.ConfirmEmailAsync(user, normalToken);
            if (result.Succeeded)
            {
                return new UserResponse
                {
                    Message = "Email confirmed successfully",
                    IsSuccess = true,
                };
            }
            return new UserResponse
            {
                IsSuccess = false,
                Message = "Email did not confirm",
                Errors = result.Errors.Select(e => e.Description),
            };
        }


        public async Task<UserResponse> ForgotPasswordAsync(string email)
        {
            var user = await _userManager.FindByEmailAsync(email);
            if(user == null)
            {
                return new UserResponse
                {
                    IsSuccess = false,
                    Message = "No user associated with email!"
                };
                   
            }
            var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            var encodedToken = Encoding.UTF8.GetBytes(token);
            var validToken = WebEncoders.Base64UrlEncode(encodedToken);

            string url = $"{_configuration["AppUrl"]}/resetpassword?Email={email}&token={validToken}";
            await _mailService.SendEmailAsync(email, "Reset Password", "<h4>Follow the instruction to reset password<h4>" +
                $"<p>To reset your password  <a href='{url}'>Click here</a></p>");
            return new UserResponse
            {
                Message = "Reset Password Link is send to your mail.",
                IsSuccess = true
            };
        }


        public async Task<UserResponse> ResetPasswordAsync(ResetPasswordViewModel model)
        {
            var user = await _userManager.FindByEmailAsync(model.Email);
            if (user == null)
            {
                return new UserResponse
                {
                    IsSuccess = false,
                    Message = "No user associated with email!"
                };

            }
            if(model.NewPassword != model.ConfirmPassword)
            {
                return new UserResponse
                {
                    IsSuccess = false,
                    Message = "Password not matched with confirm password"
                };
            }
            var decodedToken = WebEncoders.Base64UrlDecode(model.Token);
            string normalToken = Encoding.UTF8.GetString(decodedToken);

            var result = await _userManager.ResetPasswordAsync(user, normalToken, model.NewPassword);
            if (result.Succeeded)
            {
                return new UserResponse
                {
                    Message = "Password has been reset successfully",
                    IsSuccess = true,
                };
            }
            return new UserResponse
            {
                Message = "Something went wrong!",
                IsSuccess = false,
                Errors = result.Errors.Select(e =>e.Description)
            };
        }

    }

}
