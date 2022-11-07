using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Skill
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string TitleImage { get; set; }

        [NotMapped]
        public IFormFile  ImageFile { get; set; }

        public List<Videos> Videos { get; set; }

        public int SkillCategoryId { get; set; }
    }
}
