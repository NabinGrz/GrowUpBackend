using Growup.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Growup.Data
{
    public class GrowupDbContext : IdentityDbContext<ApplicationUser>
    {
        public GrowupDbContext(DbContextOptions<GrowupDbContext> options) : base(options)
        {

        }

        public DbSet<Comment> Comments { get; set; }
        public DbSet<Videos> Videos{ get; set; }
        public DbSet<Skill> Skills { get; set; }
        public DbSet<NewsFeed> NewsFeeds { get; set; }
        public DbSet<NewsFeedRating> newsFeedRatings { get; set; }
        public DbSet<VideoRating> VideoRatings { get; set; }
        public DbSet<TeacherRating> TeacherRating { get; set; }
        public DbSet<SkillCategory> SkillCateogries { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<Exam> Exams { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<Test> Test { get; set; }
        public DbSet<Option> Options { get; set; }
        public DbSet<Schedule> Schedule { get; set; }
        public DbSet<TestOptions> TestOptions { get; set; }



    }
}
