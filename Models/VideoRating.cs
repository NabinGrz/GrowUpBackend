using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class VideoRating
    {
        public int Id { get; set; }
        public string ApplicationUserId { get; set; }
        public int VideoId { get; set; }
    
        [Range(0,5.1)]
        public float Rating { get; set; } = 0;
    }
}
