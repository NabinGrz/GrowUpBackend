using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Booking
    {
        public int Id { get; set; }
        public string TeacherId { get; set; }
        public string StudentId { get; set; }
        public string ZoomId { get; set; }
        public string ZoomPassword { get; set; }
        public DateTime BookingDateTime { get; set; }
    }
}
