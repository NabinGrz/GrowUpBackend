using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class NewsFeed
    {
        public int Id { get; set; }

        [Required]
        public string Title { get; set; }

        
        public string ImageUrl { get; set; }

        [Required]
        [NotMapped]
        public IFormFile Image { get; set; }

        public string ApplicationUserId { get; set; }

        public ApplicationUser Application { get; set; }
        public List<NewsFeedRating> NewsFeedRatings { get; set; }
    }
}
