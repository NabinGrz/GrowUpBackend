using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class TeacherRating
    {
        public int Id { get; set; }
        public string TeacherId { get; set; }
        public string StudentId { get; set; }

        [Range(0.0, 5.1)]
        public float Rating { get; set; }
    }
}
