using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Comment
    {
        public int Id { get; set; }
        public string Description { get; set; }

        public int NewsFeedId { get; set; }
        public NewsFeed NewsFeed {get; set;}

        public string ApplicationUserId { get; set; }
        public ApplicationUser ApplicationUser { get; set; }

    }
}
