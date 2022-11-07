using Growup.DTOs;
using Growup.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Growup.Services
{
    public interface IUserService
    {
        Task<UserResponse> RegisterUserAsync(RegisterViewModel model);
        Task<UserResponse> LoginUserAsync(LoginViewModel model);
        Task<UserResponse> ConfirmEmailAsync(string userId, string token);

        Task<UserResponse> ForgotPasswordAsync(string email);

        Task<UserResponse> ResetPasswordAsync(ResetPasswordViewModel model);
        Task<List<ApplicationUser>> GetAllTeachersAsync();
        Task<List<ApplicationUser>> GetAllStudentsAsync();
    }
}