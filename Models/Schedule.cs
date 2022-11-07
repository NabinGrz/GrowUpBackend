using System;
using System.ComponentModel.DataAnnotations;

namespace Growup.Models
{
    public class Schedule
    {
        public int Id { get; set; }
        public bool IsBooked { get; set; }
        public DateTime ScheduleDateTime { get; set; }
        public string ApplicationUserId { get; set; }
        public ApplicationUser Application { get; set; }

        [Required]
        public string Time { get; set; }
    }
}
