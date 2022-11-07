using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Videos
    {
        public int Id { get; set; }
        public string VideoName { get; set; }
        public string ImageUrl { get; set; }

        [Required]
        [NotMapped]
        public IFormFile Image { get; set; }
        public string VideoUrl { get; set; }
        [NotMapped]
        public IFormFile Video { get; set; }
        public int SkillId { get; set; }

        public Skill Skill { get; set; }

        [Range(0.0, 5.1)]
        public float Rating { get; set; } = 0;
    }
}
