using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace Growup.Services
{
    public class MailService : IMailService
    {
        private IConfiguration _configuration;
        public MailService(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public async Task SendEmailAsync(string toEmail, string subject, string content)
        {
            MailMessage mail = new MailMessage
            {
                Subject = subject,
                Body = content,
                From = new MailAddress(_configuration.GetValue<string>("SMTPConfig:SenderAddress"), "Growup"),
                IsBodyHtml = _configuration.GetValue<bool>("SMTPConfig:IsBodyHTML"),
            };
            mail.To.Add(toEmail);
            NetworkCredential networkCredential = new NetworkCredential(_configuration.GetValue<string>("SMTPConfig:UserName"), _configuration.GetValue<string>("SMTPConfig:Password"));
            SmtpClient smtpClient = new SmtpClient
            {
                Host = _configuration["SMTPConfig:host"],
                Port = _configuration.GetValue<int>("SMTPConfig:Port"),
                EnableSsl = _configuration.GetValue<bool>("SMTPConfig:EnableSSL"),
                UseDefaultCredentials = _configuration.GetValue<bool>("SMTPConfig:UseDefaultCredentials"),
                Credentials = networkCredential
            };
            mail.BodyEncoding = Encoding.Default;
            await smtpClient.SendMailAsync(mail);
        }

    }
}
